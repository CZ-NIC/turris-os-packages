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
import signal
import errno
import logging
from bottle import template

logging.basicConfig(stream=sys.stderr, level=logging.INFO)
#logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

delimiter = '__uci__delimiter__'

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
    logging.debug('Filling hostname')
    try:
        with open('/tmp/dhcp.leases','r').readlines() as line:
            for line in file.readlines():
                variables=line.split(' ')
                if data['src_ip'] == variables[2]:
                    data['src_host'] = variables[3]
                if data['dest_ip'] == variables[2]:
                    data['dest_host'] = variables[3]
    except:
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
    timestamp = timestamp*1.0 + dt.microsecond*1.0/1000000
    return timestamp

# check what is enabled
notifications = False
if uci_get('suricata-monitor.notifications.enabled') in ('1', 'yes', 'true', 'enabled', 'on'):
    notifications = True
log_traffic = False
if uci_get('suricata-monitor.logger.enabled') in ('1', 'yes', 'true', 'enabled', 'on'):
    log_traffic = True

if not notifications and not log_traffic:
    logging.error("No functionality enable, enable at least one first")
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
        logging.error('Incomplete smtp configuration!')
        logging.error('Please set smtp_server, smtp_login and smtp_password in suricata-monitor.notifications')
        sys.exit(1)

    if fr == "" or to == "":
        logging.error('Incomplete configuration!')
        logging.error('Please set from and to in suricata-monitor.notifications')
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

con = False

# prepare the database for storing logged data
if log_traffic:
    try:
        con = sqlite3.connect('/var/lib/suricata-monitor.db')
    except:
        con = False
if con:
    # Create database if it was empty
    c = con.cursor()
    try:
        c.execute('CREATE TABLE alerts '
                  '(timestamp integer, src_ip text, src_port integer, '
                    'dest_ip text, dest_port integer, '
                    'src_eth text, dst_eth text, '
                    'category text, signature text, hostname text)')
    except:
        logging.debug('Table "alerts" already exists')

# Main loop

def exit_gracefully(signum, frame):
    global server, con
    if con:
         con.close()
    server.close()
    sys.exit(0)


signal.signal(signal.SIGINT, exit_gracefully)
signal.signal(signal.SIGTERM, exit_gracefully)

if os.path.exists( "/var/run/suricata_monitor.sock" ):
    os.remove( "/var/run/suricata_monitor.sock" )

logging.debug("Opening socket...")

server = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
server.bind("/var/run/suricata_monitor.sock")

logging.debug("Listening...")


while True:
    try:
        logging.debug('Getting data...')
        line = server.recv(4092)
        if not line:
            continue
        line = string.strip(line)
        logging.debug(line)
        if not line:
            continue
        skip = False
        try:
            data = json.loads(line)
        except:
            continue
        if 'ether' not in data.keys() or 'src' not in data['ether'].keys():
            data['ether']={}
            data['ether']['src']=''
        # Handle alerts
        if data['event_type'] == 'alert':
            logging.debug('Got alert!')
            for regex in res:
                if regex.match(data['alert']['signature']):
                    skip = True
                    break
            data = fill_hostname(data)
            if skip == False and data['alert']['severity'] < sev:
                logging.debug('Sending mail to ' + to + ' about ' + data['alert']['category'])
                if notifications:
                    with open('/etc/suricata-monitor/alert.tmpl','r') as file:
                        tmpl = file.read()
                        text = template(tmpl, data)
                        chld = subprocess.Popen(['/usr/bin/msmtp', '--host=' + smtp_server,
                                                 '--tls-trust-file=/etc/ssl/ca-bundle.pem',
                                                 '--from=' + fr, '--auth=on', '--protocol=smtp',
                                                 '--user=' + smtp_login, '--passwordeval=echo "' + smtp_password + '"',
                                                 '--tls=on', to ], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                        out, err = chld.communicate(text)
                if con:
                    c.execute('INSERT INTO alerts VALUES (?,?,?,?,?,?,?,?,?,?)',
                              (timestamp2unixtime(data['timestamp']), data['src_ip'],
                               data['src_port'], data['dest_ip'], data['dest_port'],
                               data['ether']['src'], data['ether']['dst'],
                               data['alert']['category'], data['alert']['signature'],
                               data['hostname']))

        # Commit everything
        if con:
            con.commit()

    except KeyboardInterrupt:
        exit_gracefully()

    except IOError as e:
        if e.errno != errno.EINTR:
            raise
