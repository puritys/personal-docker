#!/bin/bash
/usr/sbin/apachectl &

while true
do
    logfile="/var/logs/apache-access"
    if [ -f $logfile ]; then
        tail -f $logfile
    fi
    sleep 3
done
