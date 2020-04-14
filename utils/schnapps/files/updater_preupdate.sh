#!/bin/sh
[ "$ROOT_DIR" = "/" ] || exit 0
schnapps create -t pre "Automatic pre-update snapshot"
