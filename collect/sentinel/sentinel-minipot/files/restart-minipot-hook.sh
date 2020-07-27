#!/bin/sh
# restart Sentinel:Minipot service
/etc/init.d/sentinel-minipot restart
# Reload firewall to apply redirect
/etc/init.d/firewall reload
