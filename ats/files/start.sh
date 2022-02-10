#!/bin/bash
bash /root/remap.sh > /usr/local/etc/trafficserver/remap.config
bash /root/records.sh > /usr/local/etc/trafficserver/records.config
bash /root/ssl_multicert.sh > /usr/local/etc/trafficserver/ssl_multicert.config
bash /root/logging.sh > /usr/local/etc/trafficserver/logging.config
cp /root/ip_allow.config  /usr/local/etc/trafficserver/

/usr/local/bin/traffic_server -Cclear
rm -f /usr/local/var/trafficserver/server.lock
/usr/local/bin/traffic_manager start &

while true
do
    if [ -f /usr/local/var/log/trafficserver/squid.log ]; then
        tail -f /usr/local/var/log/trafficserver/squid.log
    fi
    sleep 3
done

