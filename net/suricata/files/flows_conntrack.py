#!/usr/bin/python3
#
#    DevDetect - small utility to detect new devices on local network
#    Copyright (C) 2017 CZ.NIC, z.s.p.o. (http://www.nic.cz/)
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# author Martin Petracek, <martin.petracek@nic.cz>
#
# When suricata bypass is enabled, flows information (packets/bytes counts and end timestamp) aren't always right.
# When flow is bypassed, suricata reports it as closed (with state="bypassed") and don't care about it anymore.
# This script does the accounting of bypassed flows, it doesn't output them immediatelly, it keeps them until they are really closed.
# It utilizes conntrack, kernel module for connection tracking. It monitors conntrack output to find out the counters and flow end time.
#
# To use it, just point suricata "flow" output to UNIX-DGRAM socket and run this script with that path as argv[1].
# This script acts like "proxy", it ouputs flows (to stdout) in suricata json format, just with updated counters.
# All other suricata events are passed to output immediatelly.

import socket
import json
import string
import sys
import os
import datetime
import signal
from datetime import datetime, timezone
import re
from threading import Thread, Lock, Condition
from time import sleep
import subprocess
import logging, sys

logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

new_flows={} #keeps new flows, not yet monitored by conntrack_monitor - needs to be verified, if they really are in conntrack
active_flows={} #keeps active_flows, is monitored by conntrack_monitor
closed_flows={} #keeps closed flows, it just waits until conntrack_get gets their counters and they are deleted (actually also conntrack_monitor checks them, if it doesn't see DESTROY)

active_flows_lock=Lock()
#new_flows and closed_flows share the same lock new_and_closed_flows_lock - this is because it's easier for implementation
# - it's actually conditional variable, not just lock and it's easier like that then having 2 separate locks
new_and_closed_flows_lock=Condition()

output_lock=Lock()


def send_line(line):
	global output_lock
	output_lock.acquire()
	try:
		print(line)
	except IOError as e:
		os.unlink(sys.argv[1])
		sys.exit(1)
	output_lock.release()

def send_json(json_dict):
	send_line(json.dumps(json_dict))

def hash_flow(src_ip, dest_ip, src_port, dest_port, proto):
	return str(proto)+":"+src_ip+":"+str(src_port)+"->"+dest_ip+":"+str(dest_port)

def suricata_timestamp():
	#should return current timestamp in suricata format. Eg. '2017-09-08T13:52:25.821230+0200'
	return str(datetime.now(timezone.utc).astimezone().strftime("%Y-%m-%dT%H:%M:%S.%f%z"))

#this reads lines from `conntrack -E` - conntrack events
# - when it sees 'DESTROY ...', it removes flow from active_flows and outputs it (it also checks closed_flows, because between getting the counters by conntrack_get, the flow may (and does) disappear)
# - when it sees 'UPDATE FIN_WAIT ...', it moves flow from active_flows to closed_flows
def conntrack_monitor():
	global active_flows, active_flows_lock, closed_flows, new_and_closed_flows_lock
	destroy_pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)\s+packets=([0-9]+)\s+bytes=([0-9]+)')
	update_pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)')
	with os.popen('/usr/sbin/conntrack -E 2>/dev/null') as conntrack:
		for line in conntrack:
			line=line.strip()
			if line.startswith("[DESTROY]"):
				#example of line: '[DESTROY] tcp 6 7439 ESTABLISHED src=192.168.1.126 dst=192.168.1.1 sport=44542 dport=22 packets=2863 bytes=175201 src=192.168.1.1 dst=192.168.1.126 sport=22 dport=44542 packets=2445 bytes=2358312 ...'
				line=line[9:].strip() #skip '[DESTROY]' part
				proto=line[:4].strip().upper()
				matches = destroy_pattern.findall(line)
				if len(matches)<2:
					continue
				original = matches[0]
				reply = matches[1]
				key1=hash_flow(original[0], original[1], original[2], original[3], proto)
				key2=hash_flow(reply[0], reply[1], reply[2], reply[3], proto)
				new_and_closed_flows_lock.acquire()
				if key1 in closed_flows:
					logging.debug("closed flow destroyed")
					closed_flows[key1]["timestamp"]=suricata_timestamp()
					closed_flows[key1]["flow"]["pkts_toserver"]=original[4]
					closed_flows[key1]["flow"]["pkts_toclient"]=reply[4]
					closed_flows[key1]["flow"]["bytes_toserver"]=original[5]
					closed_flows[key1]["flow"]["bytes_toclient"]=reply[5]
					closed_flows[key1]["flow"]["state"]="closed"
					send_json(closed_flows[key1])
					del closed_flows[key1]
				elif key2 in closed_flows:
					logging.debug("closed flow destroyed")
					closed_flows[key2]["timestamp"]=suricata_timestamp()
					closed_flows[key2]["flow"]["pkts_toserver"]=reply[4]
					closed_flows[key2]["flow"]["pkts_toclient"]=original[4]
					closed_flows[key2]["flow"]["bytes_toserver"]=reply[5]
					closed_flows[key2]["flow"]["bytes_toclient"]=original[5]
					closed_flows[key2]["flow"]["state"]="closed"
					send_json(closed_flows[key2])
					del closed_flows[key2]
				new_and_closed_flows_lock.release()
				active_flows_lock.acquire()
				if key1 in active_flows:
					logging.debug("active flow destroyed")
					active_flows[key1]["timestamp"]=suricata_timestamp()
					active_flows[key1]["flow"]["pkts_toserver"]=original[4]
					active_flows[key1]["flow"]["pkts_toclient"]=reply[4]
					active_flows[key1]["flow"]["bytes_toserver"]=original[5]
					active_flows[key1]["flow"]["bytes_toclient"]=reply[5]
					active_flows[key1]["flow"]["state"]="closed"
					send_json(active_flows[key1])
					del active_flows[key1]
				elif key2 in active_flows:
					logging.debug("active flow destroyed")
					active_flows[key2]["timestamp"]=suricata_timestamp()
					active_flows[key2]["flow"]["pkts_toserver"]=reply[4]
					active_flows[key2]["flow"]["pkts_toclient"]=original[4]
					active_flows[key2]["flow"]["bytes_toserver"]=reply[5]
					active_flows[key2]["flow"]["bytes_toclient"]=original[5]
					active_flows[key2]["flow"]["state"]="closed"
					send_json(active_flows[key2])
					del active_flows[key2]
				active_flows_lock.release()
			if line.startswith("[UPDATE]"):
				#example of line: ' [UPDATE] tcp      6 120 FIN_WAIT src=192.168.1.126 dst=216.58.209.36 sport=54428 dport=443 src=216.58.209.36 dst=172.20.6.144 sport=443 dport=54428 ...'
				#unfortunatelly doesn't provide packet/bytes counters, but we get time of flow end
				line=line[8:].strip()
				proto=line[:4].strip().upper()
				#we are only interested in TCP, UDP doesn't have the notion of closing the connection - it will be only destroyed
				if proto!="TCP":
					continue
				#we are only interested about the moment when TCP connection is being closed
				if "FIN_WAIT" not in line:
					continue
				matches = update_pattern.findall(line)
				if len(matches)<2:
					continue
				original = matches[0]
				reply = matches[1]
				key1=hash_flow(original[0], original[1], original[2], original[3], proto)
				key2=hash_flow(reply[0], reply[1], reply[2], reply[3], proto)
				active_flows_lock.acquire()
				if key1 in active_flows:
					logging.debug("active flow moved to closed_flows")
					active_flows[key1]["flow"]["end"]=suricata_timestamp()
					active_flows[key1]["flow"]["state"]="closed"
					new_and_closed_flows_lock.acquire()
					closed_flows[key1]=active_flows[key1]
					del active_flows[key1]
					new_and_closed_flows_lock.notify()
					new_and_closed_flows_lock.release()
				elif key2 in active_flows:
					logging.debug("active flow moved to closed_flows")
					active_flows[key2]["flow"]["end"]=suricata_timestamp()
					active_flows[key2]["flow"]["state"]="closed"
					new_and_closed_flows_lock.acquire()
					closed_flows[key2]=active_flows[key2]
					del active_flows[key2]
					new_and_closed_flows_lock.notify()
					new_and_closed_flows_lock.release()
				active_flows_lock.release()

#this reads `conntrack -L` and searches for new flows (to verify they are there, they might disappear between receiving report from suricata and reading conntrack)
#if they are there, it moves them from new_flows to active_flows
#also, it it searches for closed flows (marked as closed by conntrack_monitor, when it sees 'UPDATE FIN_WAIT ...' - that doesn't provide counters, so it gets them and outputs and deletes the flow)
def conntrack_get():
	global closed_flows, new_and_closed_flows_lock, new_flows
	conntrack_get.sleep_for = 1
	pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)\s+packets=([0-9]+)\s+bytes=([0-9]+)')
	while 1:
		new_and_closed_flows_lock.acquire()
		if len(new_flows)==0 and len(closed_flows)==0:
			new_and_closed_flows_lock.wait()
		new_and_closed_flows_lock.release()
		sleep(conntrack_get.sleep_for)
		new_and_closed_flows_lock.acquire()
		logging.debug("conntrack_get woken up: new_flows len "+str(len(new_flows))+", closed_flows len "+str(len(closed_flows)))
		new_flows_local = new_flows.copy()
		new_flows.clear()
		closed_flows_local = closed_flows.copy()
		closed_flows.clear()
		new_and_closed_flows_lock.release()
		f = subprocess.check_output(['/usr/sbin/conntrack', '-L'], stderr=subprocess.DEVNULL).decode()
		flows=f.split('\n')
		for line in flows:
			proto=line[:4].strip().upper()
			matches = pattern.findall(line)
			if len(matches)<2:
				continue
			original = matches[0]
			reply = matches[1]
			key1=hash_flow(original[0], original[1], original[2], original[3], proto)
			key2=hash_flow(reply[0], reply[1], reply[2], reply[3], proto)
			if key1 in new_flows_local:
					logging.debug("new flow moved to active_flows")
					active_flows_lock.acquire()
					active_flows[key1]=new_flows_local[key1]
					del new_flows_local[key1]
					active_flows_lock.release()
			elif key2 in new_flows_local:
					logging.debug("new flow moved to active_flows")
					active_flows_lock.acquire()
					active_flows[key2]=new_flows_local[key2]
					del new_flows_local[key2]
					active_flows_lock.release()
			if key1 in closed_flows_local:
					logging.debug("closed flow send and removed")
					closed_flows_local[key1]["timestamp"]=suricata_timestamp()
					closed_flows_local[key1]["flow"]["pkts_toserver"]=original[4]
					closed_flows_local[key1]["flow"]["pkts_toclient"]=reply[4]
					closed_flows_local[key1]["flow"]["bytes_toserver"]=original[5]
					closed_flows_local[key1]["flow"]["bytes_toclient"]=reply[5]
					send_json(closed_flows_local[key1])
					del closed_flows_local[key1]
			elif key2 in closed_flows_local:
					logging.debug("closed flow send and removed")
					closed_flows_local[key2]["timestamp"]=suricata_timestamp()
					closed_flows_local[key2]["flow"]["pkts_toserver"]=reply[4]
					closed_flows_local[key2]["flow"]["pkts_toclient"]=original[4]
					closed_flows_local[key2]["flow"]["bytes_toserver"]=reply[5]
					closed_flows_local[key2]["flow"]["bytes_toclient"]=original[5]
					send_json(closed_flows_local[key2])
					del closed_flows_local[key2]
		if len(closed_flows_local)>0:
			logging.error("there are some closed_flows after running conntrack_get loop. This shouldn't happen.")
		if len(new_flows_local)>0:
			#new flows wasn't found in conntrack - might be DESTROYed before - just output it as it was
			for _,v in new_flows_local.items():
				send_json(v)

#this reads socket from suricata and when it sees "flow" report with "state"="bypassed", it adds it into new_flows (and wakes up suricata_get_flow thread)
#all other reports are passed immediatelly
def suricata_get_flow(recv_socket_path):
	try:
		os.unlink(recv_socket_path) #remove stray socket
	except OSError:
		pass
	recv_socket = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
	recv_socket.bind(recv_socket_path)
	while True:
		datagram = recv_socket.recv(2048)
		if not datagram:
			continue
		lines = datagram.decode().split('\n')
		for l in lines:
			if not l:
				break
			data = json.loads(l)
			if data["event_type"] == "flow" and "flow" in data:
				proto=data["proto"]
				if proto != "TCP" and proto != "UDP":
					send_line(l)
					continue
				src_ip=data["src_ip"]
				dest_ip=data["dest_ip"]
				src_port=data["src_port"]
				dest_port=data["dest_port"]
				flow_id=data["flow_id"]
				key=hash_flow(src_ip, dest_ip, src_port, dest_port, proto.upper())
				key2=hash_flow(dest_ip, src_ip, dest_port, src_port, proto.upper())
				active_flows_lock.acquire()
				#workaround for suricata issue: sometimes flow is not bypassed correctly (eg. in case of SSH)
				#and we continue to get notifications about it
				#in that case, silently discard that notification
				#this should be fixed on suricata side, but I don't know where the problem could be, so at least this for now...
				#also, the flow could be reported in the other direction, that's why I'm checking key2 as well
				if key in active_flows or key2 in active_flows:
					active_flows_lock.release()
					continue
				active_flows_lock.release()
				if data["flow"]["state"]!="bypassed":
					send_line(l)
					continue
				if "bypass" in data["flow"]:
					del data["flow"]["bypass"]
				new_and_closed_flows_lock.acquire()
				new_flows[key]=data
				new_and_closed_flows_lock.notify()
				new_and_closed_flows_lock.release()
				logging.debug("new flow (added to new_flows):  {}: {}:{} -> {}:{} (proto {})".format(flow_id,src_ip,src_port,dest_ip,dest_port,proto))
				logging.debug("new_flows len "+str(len(new_flows))+", active_flows len "+str(len(active_flows))+", closed_flows len "+str(len(closed_flows))) 
			elif data["event_type"] == "flow_start":
				proto=data["proto"]
				if proto != "TCP" and proto != "UDP":
					send_line(l)
					continue
				src_ip=data["src_ip"]
				dest_ip=data["dest_ip"]
				src_port=data["src_port"]
				dest_port=data["dest_port"]
				flow_id=data["flow_id"]
				key=hash_flow(src_ip, dest_ip, src_port, dest_port, proto.upper())
				key2=hash_flow(dest_ip, src_ip, dest_port, src_port, proto.upper())
				active_flows_lock.acquire()
				#workaround for suricata issue: sometimes flow is not bypassed correctly (eg. in case of SSH)
				#and we continue to get notifications about it
				#in that case, silently discard that notification
				#this should be fixed on suricata side, but I don't know where the problem could be, so at least this for now...
				#also, the flow could be reported in the other direction, that's why I'm checking key2 as well
				if key in active_flows or key2 in active_flows:
					active_flows_lock.release()
					continue
				active_flows_lock.release()
				send_line(l)
			else: #if this is anything else then flow...
				send_line(l) #...just resend immediatelly


def exit_gracefully(signum, frame):
	logging.debug("asked to quit, sending all remaining flows")
	global new_flows, active_flows, closed_flows, active_flows_lock, new_and_closed_flows_lock
	conntrack_get.sleep_for = 0
	active_flows_lock.acquire()
	new_and_closed_flows_lock.acquire()
	closed_flows.update(active_flows)
	active_flows.clear()
	new_and_closed_flows_lock.notify()
	new_and_closed_flows_lock.release()
	active_flows_lock.release()
	sleep(2)
	new_and_closed_flows_lock.acquire()
	for _,v in new_flows.items():
		v["flow"]["state"]="closed"
		v["flow"]["reason"]="shutdown"
		v["timestamp"]=suricata_timestamp()
		v["flow"]["end"]=suricata_timestamp()
		send_json(v)
	new_flows.clear()
	new_and_closed_flows_lock.release()
	os.unlink(sys.argv[1])
	sys.exit(0)

signal.signal(signal.SIGINT, exit_gracefully)
signal.signal(signal.SIGTERM, exit_gracefully)


def main():
	if len(sys.argv) < 2:
		logging.error("usage: {} recv_socket".format(sys.argv[0]))
		return 1
	thread1 = Thread(target = conntrack_monitor)
	thread1.daemon = True
	thread1.start()
	thread2 = Thread(target = conntrack_get)
	thread2.daemon = True
	thread2.start()
	suricata_get_flow(sys.argv[1])
		
if __name__ == "__main__":
	main()
