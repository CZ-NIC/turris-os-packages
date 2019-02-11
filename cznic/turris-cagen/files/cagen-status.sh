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
	awk -F '(\t| )' '
		# from notes.txt
		ARGIND == 1 {
			result[$1]=$1 " " $2 " " $3;
			status[$1]="generating";
		}
		# from index.txt
		ARGIND == 2 && $1 == "V" {
			status[$4]="valid"
		}
		# from index.txt
		ARGIND == 2 && $1 == "R" {
			status[$4]="revoked"
		}
		END {
			for (id in result)
				print result[id] " " status[id]
		}
	' notes.txt index.txt | sort
fi
