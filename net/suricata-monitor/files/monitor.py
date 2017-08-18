#!/usr/bin/env python

import fileinput
import json
import socket
import os, os.path
import string
import sys
import subprocess
import re
import time
import datetime
import sqlite3
from bottle import template

delimiter = '__uci__delimiter__'
debug = False

# uci get wrapper
def uci_get(opt):
    chld = subprocess.Popen(['/sbin/uci', '-d', delimiter, '-q', 'get', opt],
                            stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    out, err = chld.communicate()
    out = string.strip(out).encode('ascii','ignore')
    if out.find(delimiter) != -1:
        return out.split(delimiter)
    else:
        return out

# fills hostname from dhcp.leases
def fill_hostname(data):
    if debug:
        print('Filling hostname')
    with open('/tmp/dhcp.leases','r').readlines() as line:
        for line in file.readlines():
            variables=line.split(' ')
            if data['src_ip'] == variables[2]:
                data['src_host'] = variables[3]
            if data['dest_ip'] == variables[2]:
                data['dest_host'] = variables[3]
    hostname = 'unknown'
    if 'dest_host' in data:
        hostname = data['dest_host']
    if 'src_host' in data:
        hostname = data['src_host']
    data['hostname'] = hostname
    return data

# converts textual timestamp to unixtime
def timestamp2unixtime(timestamp):
    dt = datetime.datetime.strptime(timestamp[:-5],'%Y-%m-%dT%H:%M:%S.%f')
    offset_str = timestamp[-5:]
    offset = int(offset_str[-4:-2])*60 + int(offset_str[-2:])
    if offset_str[0] == "+":
        offset = -offset
    timestamp = time.mktime(dt.timetuple()) + offset * 60
    return timestamp

# check what is enabled
notifications = False
if uci_get('suricata-monitor.notifications.enabled') in ('1', 'yes', 'true'):
    notifications = True
log_traffic = False
if uci_get('suricata-monitor.logger.enabled') in ('1', 'yes', 'true'):
    log_traffic = True
if uci_get('suricata-monitor.logger.debug') in ('1', 'yes', 'true'):
    debug = True

if not notifications and not log_traffic:
    print("No functionality enable, enable at least one first")
    sys.exit(1)

# get configuration
smtp_server = uci_get('suricata-monitor.notifications.smtp_server')
smtp_login = uci_get('suricata-monitor.notifications.smtp_login')
smtp_password = uci_get('suricata-monitor.notifications.smtp_password')
fr = uci_get('suricata-monitor.notifications.from')
to = uci_get('suricata-monitor.notifications.to')

# verify configuration
if notifications:
    if smtp_server == "" or smtp_login == "" or smtp_password == "":
        print('Incomplete smtp configuration!')
        print('Please set smtp_server, smtp_login and smtp_password in suricata-monitor.notifications')
        sys.exit(1)

    if fr == "" or to == "":
        print('Incomplete configuration!')
        print('Please set from and to in suricata-monitor.notifications')
        sys.exit(1)


res = []

# More notification settings
for regex in uci_get('suricata-monitor.notifications.ignore_regex'):
    res.append(re.compile(regex))
sev = uci_get('suricata-monitor.notifications.severity')
if sev == "":
    sev = 100
else:
    sev = int(sev)

if os.path.exists( "/var/run/suricata_monitor.sock" ):
    os.remove( "/var/run/suricata_monitor.sock" )

print("Opening socket...")

server = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
server.bind("/var/run/suricata_monitor.sock")

print("Listening...")

con = False

# prepare the database for storing logged data
if log_traffic:
    try:
        con = sqlite3.connect('/var/lib/suricata-monitor.db')
    except:
        con = False

if con:
    c = con.cursor()
    try:
        c.execute('CREATE TABLE alerts '
                  '(count integer, timestamp integer, src_ip text, '
                    'src_port integer, dest_ip text, dest_port integer, '
                    'category text, signature text, hostname text)')
    except:
        print('Table "alerts" already exists')
    try:
        c.execute('CREATE TABLE traffic '
                  '(flow_id integer, start integer, stop integer, src_ip text, '
                  'src_port integer, dest_ip text, dest_port integer, '
                  'proto text, app_proto text, bytes_send integer, '
                  'bytes_received integer, sni text, cname text)')
    except:
        print('Table "traffic" already exists')
    try:
        c.execute('CREATE TABLE dns '
                  '(time integer, client text, name text, type text, data text)')
    except:
        print('Table "dns" already exists')

# Main loop
try:
    while True:
        line = server.recv(4092)
        if not line:
            continue
        line = string.strip(line)
        if not line:
            continue
        skip = False
        try:
            data = json.loads(line)
        except:
            continue

        # Handle alerts
        if data['event_type'] == 'alert' and notifications:
            if debug:
                print('Got alert!')
            for regex in res:
                if regex.match(data['alert']['signature']):
                    skip = True
                    break
            data = fill_hostname(data)
            if skip == False and data['alert']['severity'] < sev:
                if debug:
                    print('Sending mail to ' + to + ' about ' + data['alert']['category'])
                with open('/etc/suricata/message.tmpl','r') as file:
                    tmpl = file.read() 
                    text = template(tmpl, data)
                    chld = subprocess.Popen(['/usr/bin/msmtp', '--host=' + smtp_server,
                                             '--tls-trust-file=/etc/ssl/ca-bundle.pem',
                                             '--from=' + fr, '--auth=on', '--protocol=smtp',
                                             '--user=' + smtp_login, '--passwordeval=echo "' + smtp_password + '"',
                                             '--tls=on', to ], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                    out, err = chld.communicate(text)
                if con:
                    c.execute('INSERT INTO alerts VALUES (?,?,?,?,?,?,?,?,?)',
                              (1, timestamp2unixtime(data['timestamp']), data['src_ip'],
                               data['src_port'], data['dest_ip'], data['dest_port'],
                               data['alert']['category'], data['alert']['signature'],
                               data['hostname']))

        # Handle all other traffic
        if data['event_type'] == 'dns' and con:
            if debug:
                print('Got dns!')
            if data['dns'] and data['dns']['type'] == 'answer' and 'rrtype' in data['dns'].keys() and data['dns']['rrtype'] in ('A', 'AAAA', 'CNAME') and con:
                c.execute('SELECT type,data FROM dns WHERE client = ? AND name = ? ORDER BY time LIMIT 1',
                          (data['dest_ip'], data['dns']['rrname']))
                row = c.fetchone()
                if not row or row[0] != data['dns']['rrtype'] or row[1] != data['dns']['rdata']:
                    print 'Saving DNS data'
                    c.execute('INSERT INTO dns VALUES (?,?,?,?,?)',
                              (timestamp2unixtime(data['timestamp']),
                              data['dest_ip'], data['dns']['rrname'], data['dns']['rrtype'],
                              data['dns']['rdata']))
        if data['event_type'] == 'flow' and data['flow'] and con and data['proto'] in ['TCP', 'UDP']:
            if debug:
                print('Got flow!')
            if 'app_proto' not in data.keys():
                data['app_proto'] = ''
            if 'src_port' not in data.keys():
                data['src_port'] = ''
            try:
                c.execute('UPDATE traffic VALUES SET start = ?, stop = ?, src_ip = ?, '
                          'src_port = ?, dest_ip = ?, dest_port = ?, proto = ?, '
                          'app_proto = ?, bytes_send = ?, bytes_received = ? WHERE '
                          'flow_id = ?',
                          timestamp2unixtime(data['flow']['start']),
                          timestamp2unixtime(data['flow']['end']),
                          data['src_ip'], data['src_port'], data['dest_ip'], data['dest_port'],
                          data['proto'], data['app_proto'], data['flow']['bytes_toserver'],
                          data['flow']['bytes_toclient'], data['flow_id'])
            except:
                c.execute('INSERT INTO traffic VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                          (data['flow_id'], timestamp2unixtime(data['flow']['start']),
                           timestamp2unixtime(data['flow']['end']), data['src_ip'],
                           data['src_port'], data['dest_ip'], data['dest_port'],
                           data['proto'], data['app_proto'], data['flow']['bytes_toserver'],
                           data['flow']['bytes_toclient'], '', ''))
        if data['event_type'] == 'tls' and data['tls'] and con:
            if debug:
                print('Got tls!')
            if 'sni' not in data['tls'].keys():
                data['tls']['sni'] = ''
            if 'subject' not in data['tls'].keys():
                data['tls']['subject'] = ''
            c.execute('INSERT INTO traffic VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                      (data['flow_id'], 0, 0, data['src_ip'], data['src_port'],
                       data['dest_ip'], data['dest_port'], data['proto'], '', 0,
                       0, data['tls']['sni'], data['tls']['subject']))
        if con:
            con.commit()

except:
    if con:
        con.close()
    server.close()
