#!/bin/ash

CA_DIR=/etc/ssl/ca/

if [ $# -ne 1 ]; then
	cat <<END
turris-cagen-status <ca-name>

Displays info about CA generated using turris-cagen
It examines ${CA_DIR}

END
	exit 1
fi

echo "#### CA $1 ####"

if [ ! -d "${CA_DIR}$1" ]; then
	echo "status: missing"
	exit 0
fi

cd "${CA_DIR}$1"

if [ ! -f ca.crt ]; then
	echo "status: generating"
	exit 0
fi

echo "status: ready"

echo "## Certs:"
if [ -f notes.txt ]; then
	while read line; do
		id=$(echo $line | sed 's/^\([0-9A-Za-z][0-9A-Za-z]\).*$/\1/')
		name=$(echo $line | sed 's/^[0-9A-Za-z][0-9A-Za-z] [^ ]* \([^ ]*\)$/\1/')
		if grep -q "^R\t[0-9]*Z\t[0-9]*Z\t${id}.*CN=${name}.*" index.txt ; then
			line="$line revoked"
		elif grep -q "^V\t[0-9]*Z\t\t$id.*CN=${name}.*" index.txt ; then
			line="$line valid"
		else
			line="$line generating"
		fi
		echo $line
	done < notes.txt
fi
