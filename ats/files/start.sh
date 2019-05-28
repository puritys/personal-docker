#!/bin/bash
bash /root/remap.sh > /usr/local/etc/trafficserver/remap.config
bash /root/records.sh > /usr/local/etc/trafficserver/records.config
bash /root/ssl_multicert.sh > /usr/local/etc/trafficserver/ssl_multicert.config
bash /root/logging.sh > /usr/local/etc/trafficserver/logging.config

ln -sf /usr/local/var/log/trafficserver/squid.log /tmp/log

/usr/local/bin/traffic_server -Cclear
rm /usr/local/var/trafficserver/server.lock
/usr/local/bin/traffic_manager

#exec "$@";
