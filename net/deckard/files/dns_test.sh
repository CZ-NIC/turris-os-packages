#!/bin/sh

python3 -m pytest forwarder_check.py --forwarder 127.0.0.1 --junitxml forwarder.xml
