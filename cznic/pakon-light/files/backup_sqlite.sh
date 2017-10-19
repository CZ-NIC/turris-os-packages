#!/bin/sh
if [ $# -ne 2 ]; then
	echo "usage: $0 src dst"
	exit 1
fi

SRC=$1
DST=$2
DST_EXT=$(echo "$DST" | awk -F . '{print $NF}')
TMP_FILE=$(mktemp)
[ -f "$SRC" ] || exit 1
/usr/bin/sqlite3 $SRC ".backup '$TMP_FILE'" || { rm -f "$TMP_FILE"; exit 1; }
if [[ $DST_EXT == "xz" ]]; then
	xz -9 --stdout "$TMP_FILE" > "$DST.tmp"|| { rm -f "$TMP_FILE"; exit 1; }
else
	cp "$TMP_FILE" "$DST.tmp"
fi
rm -f "$TMP_FILE"
mv "$DST.tmp" "$DST"
