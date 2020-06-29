#!/bin/sh
set -eux
. "${0%/*}/base.sh"


git clone --branch "bugfix/rework-repo-checkout" "https://gitlab.labs.nic.cz/turris/turris-build.git" "tb-new"
(
	cd tb-new
	./helpers/checkout_repo_branch.sh "$branch"
)

if diff -q "tb-new/feeds.conf" "turris-build-$branch/feekds.conf" >/dev/null; then
	(
		cd turris-build-new
		../turris-build/compile_pkgs -t "$BOARD" -j"$(nproc)" -f prepare_tools
	)
	mv "turris-build-$branch" "tb-old"
	mv "turris-build-new" "turris-build-$branch"
fi
