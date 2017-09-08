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
# This script acts like "proxy", it ouputs flows in suricata json format, just with updated counters. All other suricata events are passed to output immediatelly.
# This script outputs its data UNIX-DRGAM socket argv[2].

import socket
import json
import string
import sys
import os
import datetime
from datetime import datetime, timezone
import re
from threading import Thread, Lock
from time import sleep
import subprocess

active_flows={}
active_flows_lock=Lock()
closed_flows={}
closed_flows_lock=Lock()
send_socket = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
send_socket_path = ""
send_socket_lock=Lock() #unfortunatelly sockets are not thread-safe in Python...


def send_line(line):
	global send_socket_path, send_socket, send_socket_lock
	send_socket_lock.acquire()
	try:
		send_socket.sendto((line+"\n").encode(), send_socket_path)
	except IOError as e:
		print(e)
	send_socket_lock.release()

def send_json(json_dict):
	send_line(json.dumps(json_dict))

def hash_flow(src_ip, dest_ip, src_port, dest_port, proto):
	return str(proto)+":"+src_ip+":"+str(src_port)+"->"+dest_ip+":"+str(dest_port)

def suricata_timestamp():
	#should return current timestamp in suricata format. Eg. '2017-09-08T13:52:25.821230+0200'
	return str(datetime.now(timezone.utc).astimezone().strftime("%Y-%m-%dT%H:%M:%S.%f%z"))

def conntrack_monitor():
	global active_flows, active_flows_lock, closed_flows, closed_flows_lock
	destroy_pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)\s+packets=([0-9]+)\s+bytes=([0-9]+)')
	update_pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)')
	with os.popen('/usr/sbin/conntrack -E') as conntrack:
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
				#unfortunatelly, it's not only uncertain if local addresses are to be found in original (first match) or reply (second match)
				#but also suricata might get the direction wrong (it's guessing based on higher/lower ports sometimes)
				#so we need to check all four possibilities
				key1=hash_flow(original[0], original[1], original[2], original[3], proto)
				key2=hash_flow(reply[0], reply[1], reply[2], reply[3], proto)
				closed_flows_lock.acquire()
				if key1 in closed_flows:
					print("destroy_closed_found1")
					closed_flows[key1]["timestamp"]=suricata_timestamp()
					closed_flows[key1]["flow"]["pkts_toserver"]=original[4]
					closed_flows[key1]["flow"]["pkts_toclient"]=reply[4]
					closed_flows[key1]["flow"]["bytes_toserver"]=original[5]
					closed_flows[key1]["flow"]["bytes_toclient"]=reply[5]
					closed_flows[key1]["flow"]["state"]="closed"
					send_json(closed_flows[key1])
					del closed_flows[key1]
				elif key2 in closed_flows:
					print("destroy_closed_found2")
					closed_flows[key2]["timestamp"]=suricata_timestamp()
					closed_flows[key2]["flow"]["pkts_toserver"]=reply[4]
					closed_flows[key2]["flow"]["pkts_toclient"]=original[4]
					closed_flows[key2]["flow"]["bytes_toserver"]=reply[5]
					closed_flows[key2]["flow"]["bytes_toclient"]=original[5]
					closed_flows[key2]["flow"]["state"]="closed"
					send_json(closed_flows[key2])
					del closed_flows[key2]
				closed_flows_lock.release()
				active_flows_lock.acquire()
				if key1 in active_flows:
					print("destroy_found1")
					active_flows[key1]["timestamp"]=suricata_timestamp()
					active_flows[key1]["flow"]["pkts_toserver"]=original[4]
					active_flows[key1]["flow"]["pkts_toclient"]=reply[4]
					active_flows[key1]["flow"]["bytes_toserver"]=original[5]
					active_flows[key1]["flow"]["bytes_toclient"]=reply[5]
					active_flows[key1]["flow"]["state"]="closed"
					send_json(active_flows[key1])
					del active_flows[key1]
				elif key2 in active_flows:
					print("destroy_found2")
					active_flows[key2]["timestamp"]=suricata_timestamp()
					active_flows[key2]["flow"]["pkts_toserver"]=reply[4]
					active_flows[key2]["flow"]["pkts_toclient"]=original[4]
					active_flows[key2]["flow"]["bytes_toserver"]=reply[5]
					active_flows[key2]["flow"]["bytes_toclient"]=original[5]
					active_flows[key2]["flow"]["state"]="closed"
					send_json(active_flows[key2])
					del active_flows[key2]
				active_flows_lock.release()
				print(str(len(active_flows))+" flows remaining")
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
					print("update_found1")
					active_flows[key1]["flow"]["end"]=suricata_timestamp()
					active_flows[key1]["flow"]["state"]="closed"
					closed_flows_lock.acquire()
					closed_flows[key1]=active_flows[key1]
					del active_flows[key1]
					closed_flows_lock.release()
				elif key2 in active_flows:
					print("update_found2")
					active_flows[key2]["flow"]["end"]=suricata_timestamp()
					active_flows[key2]["flow"]["state"]="closed"
					closed_flows_lock.acquire()
					closed_flows[key2]=active_flows[key2]
					del active_flows[key2]
					closed_flows_lock.release()
				active_flows_lock.release()
				print(str(len(active_flows))+" flows remaining")

def conntrack_get():
	global closed_flows, closed_flows_lock
	print("closed flows thread")
	pattern = re.compile(r'src=([0-9a-fA-F.:]+)\s+dst=([0-9a-fA-F.:]+)\s+sport=([0-9]+)\s+dport=([0-9]+)\s+packets=([0-9]+)\s+bytes=([0-9]+)')
	while 1:
		sleep(5)
		if len(closed_flows)==0:
			continue
		print(closed_flows.keys())
		devnull = open(os.devnull, 'w')
		f = subprocess.check_output(['/usr/sbin/conntrack', '-L'], stderr=devnull).decode()
		devnull.close()
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
			closed_flows_lock.acquire()
			if key1 in closed_flows:
					closed_flows[key1]["timestamp"]=suricata_timestamp()
					closed_flows[key1]["flow"]["pkts_toserver"]=original[4]
					closed_flows[key1]["flow"]["pkts_toclient"]=reply[4]
					closed_flows[key1]["flow"]["bytes_toserver"]=original[5]
					closed_flows[key1]["flow"]["bytes_toclient"]=reply[5]
					send_json(closed_flows[key1])
					del closed_flows[key1]
			if key2 in closed_flows:
					closed_flows[key2]["timestamp"]=suricata_timestamp()
					closed_flows[key2]["flow"]["pkts_toserver"]=original[4]
					closed_flows[key2]["flow"]["pkts_toclient"]=reply[4]
					closed_flows[key2]["flow"]["bytes_toserver"]=original[5]
					closed_flows[key2]["flow"]["bytes_toclient"]=reply[5]
					send_json(closed_flows[key2])
					del closed_flows[key2]
			closed_flows_lock.release()
		closed_flows_lock.acquire()
		if len(closed_flows)>0:
			print("there are some closed_flows after running conntrack_get loop. This shouldn't happen.")
		closed_flows_lock.release()

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
				if data["flow"]["state"]!="bypassed":
					send_line(l)
					continue
				proto=data["proto"]
				if proto != "TCP" and proto != "UDP":
					send_line(l)
					continue
				if "bypass" in data["flow"]:
					del data["flow"]["bypass"]
				src_ip=data["src_ip"]
				dest_ip=data["dest_ip"]
				src_port=data["src_port"]
				dest_port=data["dest_port"]
				flow_id=data["flow_id"]
				print("NEW FLOW: {}: {}:{} -> {}:{} (proto {})".format(flow_id,src_ip,src_port,dest_ip,dest_port,proto))
				key=hash_flow(src_ip, dest_ip, src_port, dest_port, proto.upper())
				active_flows_lock.acquire()
				active_flows[key]=data
				active_flows_lock.release()
			else: #if this is anything else then flow...
				send_line(l) #...just resend immediatelly

def main(argv = sys.argv):
	global send_socket_path
	print(suricata_timestamp())
	if len(argv) < 3:
		print("usage: {} recv_socket send_socket".format(argv[0]))
		return 1
	send_socket_path=argv[2]
	thread1 = Thread(target = conntrack_monitor)
	thread1.daemon = True
	thread1.start()
	thread2 = Thread(target = conntrack_get)
	thread2.daemon = True
	thread2.start()
	try:
		suricata_get_flow(argv[1])
	except KeyboardInterrupt:
		os.unlink(argv[1])
		return 0
		
if __name__ == "__main__":
	main()
