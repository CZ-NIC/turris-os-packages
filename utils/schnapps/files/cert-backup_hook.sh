#!/bin/sh
[ -z "`which cert-backup`" ] || cert-backup -X "$1"
