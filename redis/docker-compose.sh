#!/bin/bash

# -----------------------
# start docker compose
# ./docker-compose.sh up
#
# restart one container
# ./docker-compose.sh reup redis
# -----------------------

if [ "x`uname`" = "xDarwin" ] ; then
    addr=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'| head -n 1`
    hostname=`nslookup $addr | grep name | awk '{print substr($4, 1, length($4)-1)}'`
else
    hostname=`hostname`;
fi

mkdir -p data
me=`whoami`

cat > docker-compose.yml << TEXT
version: '3'

services:

  redis:
    container_name: "redis"
    hostname: "$hostname"
    image: redis
    ports:
      - "6379:6379"
    volumes:
      - ~/:/$me
      - `pwd`/data:/data
      - `pwd`/conf:/usr/local/etc/redis/
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps
        redis-server
TEXT

if [ "reup" == "$1" ] && [ "x" != "x$2" ];then
    docker-compose stop $2
    docker-compose up -d $2
    exit
fi

if [ "up" == "$1" ];then
    docker-compose $1 -d
else
    docker-compose $1
fi
