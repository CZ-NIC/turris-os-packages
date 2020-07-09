#!/bin/sh
set -eu
. "${0%/*}/base.sh"

target="$(git rev-parse HEAD)"

cd "turris-build-$branch/build"
mv feeds.conf feeds.conf.old
awk -vTARGET="$target" \
	'$2 == "turrispackages" { gsub("[0-9a-z]+$", TARGET, $3) }; { print }' \
	feeds.conf.old > feeds.conf
../compile_pkgs repatch_feeds

sed -i 's/^CONFIG_SIGNED_PACKAGES=y$/CONFIG_SIGNED_PACKAGES=n/'

git -C ../.. diff --name-only HEAD "$base" -- '*/Makefile' | \
	sed -nE 's#^.*/([^/]*)/Makefile#\1#p' | \
	xargs make -j"$(nproc)"
make package/index

mv bin/packages/*/turrispackages ../../
