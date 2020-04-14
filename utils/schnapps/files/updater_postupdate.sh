#!/bin/sh
[ "$ROOT_DIR" = "/" ] || exit 0
schnapps create -t post "Automatic post-update snapshot"
