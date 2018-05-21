
bash /root/remap.sh > /usr/local/etc/trafficserver/remap.config
bash /root/records.sh > /usr/local/etc/trafficserver/records.config
bash /root/ssl_multicert.sh > /usr/local/etc/trafficserver/ssl_multicert.config

/usr/local/bin/traffic_manager &

