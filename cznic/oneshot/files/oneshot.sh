#!/bin/busybox sh

# Copyright (c) 2013, CZ.NIC, z.s.p.o. (http://www.nic.cz/)
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the CZ.NIC nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL CZ.NIC BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -ex

SCRIPT_DIR=/usr/share/oneshot/scripts
COMPLETED_DIR=/usr/share/oneshot/completed

mkdir -p "$COMPLETED_DIR"

ls "$SCRIPT_DIR" | sort | while read SCRIPT ; do
	if [ ! -f "$COMPLETED_DIR/$SCRIPT" ] ; then
		echo "Running one-shot script $SCRIPT" | logger -t oneshot -p user.info
		if ! "$SCRIPT_DIR/$SCRIPT" ; then
			echo "Failed to execute $SCRIPT" | logger -t oneshot -p user.err
			# Busybox's sh doesn't work well with exit. Use this instead.
			kill -SIGABRT $$
		fi
		touch "$COMPLETED_DIR/$SCRIPT"
		echo "Script $SCRIPT complete" | logger -t oneshot -p user.info
	fi
done
