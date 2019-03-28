#!/bin/ash

#Copyright 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
#This file as originaly part of NUCI configuration server.
#
#cagen is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#cagen is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with cagen.  If not, see <http://www.gnu.org/licenses/>.

set -e

SCRIPT="$0"
OPENSSL_CONF=/etc/cagen/openssl.cnf
CA_DIR=${CA_DIR:-/etc/ssl/ca/}

LOCKFILE=
CA=

do_restart() {
	[ '!' "$CA" ]
	[ '!' "$LOCKFILE" ]
	CA="$1"
	LOCKFILE="$2"
}

do_background() {
	"$SCRIPT" restart "$CA" "$LOCKFILE" "$@" </dev/null >/dev/null 2>&1 &
	trap '' HUP INT QUIT TERM EXIT
	exit 0
}

unlock() {
	if [ "$LOCKFILE" -a -f "$LOCKFILE" ] ; then
		rm "$LOCKFILE"
		LOCKFILE=
	fi
}

cleanup() {
	if [ "$CA" ] ; then
		rm -f "$CA_DIR"/"$CA"/generating
		CA=
	fi
	unlock
}

lock() {
	set -o noclobber
	while ! echo $$ 2>/dev/null >"$1" ; do
		sleep 1
	done
	LOCKFILE="$1"
	set +o noclobber
}

msg() {
	echo "$1: $2"
}

test_active_ca() {
	if [ -z "$CA" ]; then
		msg "$1" "no CA active"
		exit 1
	fi
}

test_exists() {
	if [ ! -e "$CA_DIR"/"$1" ]; then
		msg "$2" "CA '$1' doesn't exist"
		exit 1
	fi

}

trap cleanup HUP INT QUIT TERM EXIT

do_switch() {
	cleanup
	test_exists "$1" switch
	cd "$CA_DIR"/"$1"
	lock /tmp/ca-lock-"$1"
	rm -f generating
	CA="$1"
}

do_new_ca() {
	if [ -e "$CA_DIR"/"$1" ]; then
		msg new_ca "CA '$1' already exists"
		exit 1
	fi
	mkdir -p "$CA_DIR"/"$1"
	touch "$CA_DIR"/"$1"/index.txt
	touch "$CA_DIR"/"$1"/notes.txt
	echo 01 >"$CA_DIR"/"$1"/serial
	echo 01 >"$CA_DIR"/"$1"/crlnumber
	do_switch "$1"
}

do_gen_crl() {
	openssl ca -gencrl -out ca.crl -config "$OPENSSL_CONF"
}

do_gen_ca() {
	msg gen_ca "started ($CA)"
	test_active_ca gen_ca
	if [ -f "ca.crt" ]; then
		msg gen_ca "CA '$CA' already created"
		exit 1
	fi
	echo "-- root $CA" >generating
	echo "$CA" | openssl req -new -x509 -extensions v3_ca -keyout ca.key -out ca.crt -config "$OPENSSL_CONF" -nodes -days 3650
	chmod 0400 ca.key
	do_gen_crl
	rm generating
	msg gen_ca "finished ($CA)"
}

do_gen_dh() {
	msg gen_dh "started"
	test_active_ca gen_dh
	echo 'dhparams' >generating
	openssl dhparam -out dhparam.pem 2048
	rm generating
	msg gen_dh "finished"
}

do_gen_server() {
	msg gen_server "started ($1)"
	test_active_ca gen_server
	SERIAL=$(cat serial)
	echo "$SERIAL server $1" >>notes.txt
	echo "$SERIAL server $1" >generating
	echo "$1" | openssl req -new -newkey rsa:4096 -keyout "$SERIAL".key -nodes -out "$SERIAL".csr -config "$OPENSSL_CONF" -extensions usr_server
	openssl ca -out "$SERIAL".crt -config "$OPENSSL_CONF" -batch -extensions usr_server -infiles "$SERIAL".csr
	chmod 0400 "$SERIAL".key
	do_gen_crl
	rm generating
	msg gen_server "finished ($1)"
}

do_gen_client() {
	msg gen_client "started ($1)"
	test_active_ca gen_client
	SERIAL=$(cat serial)
	echo "$SERIAL client $1" >>notes.txt
	echo "$SERIAL client $1" >generating
	echo "$1" | openssl req -new -newkey rsa:4096 -keyout "$SERIAL".key -nodes -out "$SERIAL".csr -config "$OPENSSL_CONF" -extensions usr_client
	openssl ca -out "$SERIAL".crt -config "$OPENSSL_CONF" -batch -extensions usr_client -infiles "$SERIAL".csr
	chmod 0400 "$SERIAL".key
	do_gen_crl
	rm generating
	msg gen_client "finished ($1)"
}

do_drop_ca() {
	msg drop_ca "started"
	if [ "$CA" = "$1" ]; then
		msg drop_ca "CA '$1' is active and can't be dropped"
		exit 1
	fi
	test_exists "$1" drop_ca

	unlock
	lock /tmp/ca-lock-"$1"
	rm -rf "$CA_DIR"/"$1"
	rm -f "$LOCKFILE"
	LOCKFILE=
	msg drop_ca "finished"
}

do_refresh() {
	msg refresh "started"
	cd "$CA_DIR"
	ls >/tmp/tmp.$$
	while read CA_NAME ; do
		do_switch "$CA_NAME"
		do_gen_crl
	done < /tmp/tmp.$$
	rm /tmp/tmp.$$
	msg refresh "finished"
}

do_revoke() {
	msg revoke "started ($1)"
	test_active_ca revoke
	if grep '^R' index.txt | cut -f4 | grep -q -F "$1" ; then
		: already revoked
	else
		openssl ca -revoke "$1".pem -config "$OPENSSL_CONF"
	fi
	do_gen_crl
	msg revoke "finished ($1)"
}

while [ "$1" ] ; do
	CMD="$1"
	shift
	case "$CMD" in
		restart)
			do_restart "$1" "$2"
			shift 2
			;;
		background)
			do_background "$@"
			;;
		new_ca)
			do_new_ca "$1"
			shift
			;;
		gen_ca)
			do_gen_ca
			;;
		gen_dh)
			do_gen_dh
			;;
		gen_server)
			do_gen_server "$1"
			shift
			;;
		gen_client)
			do_gen_client "$1"
			shift
			;;
		switch)
			do_switch "$1"
			shift
			;;
		drop_ca)
			do_drop_ca "$1"
			shift
			;;
		refresh)
			do_refresh
			;;
		revoke)
			do_revoke "$1"
			shift
			;;
		help|-h|--help)
			cat <<END
turris-cagen command [param] command [param] ...

A CA generator. Mostly for backend use, but you can use it for anything else.
To work with a concrete CA you have to switch to it first.

The generated certificates live in /etc/ssl/ca/.

Commands:
	background		Terminate now and run the rest of the commands in background
	new_ca <name>		Create a new CA (without any keys or certificates) and switch to it
	gen_ca			Generate the certificates for the CA itself (invalidates all current certificates)
	gen_dh			Generate new DH parameters
	gen_server <name>	Generate a server-side certificate
	gen_client <name>	Generate a client-side certificate
	switch <name>		Choose a CA to run the following commands on
	drop_ca <name>		Delete the whole CA
	refresh			Regenerate CRLs for all the CAs
	revoke <serial>		Revoke a certificate
END
			;;
	esac
done
