#!/bin/bash

# -----------------------
# start docker compose
# ./docker-compose.sh up
#
# -----------------------

if [ "x`uname`" = "xDarwin" ] ; then
    addr=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'| head -n 1`
    hostname=`nslookup $addr | grep name | awk '{print substr($4, 1, length($4)-1)}'`
else
    hostname=`hostname`;
fi

# Create bash history to support Ctrl+R in container.
mkdir -p ~/docker_tmp/
touch -f ~/docker_tmp/.bash_history

me=`whoami`

cat > docker-compose.yml << TEXT

version: '3'

services:

  redis-cluster:
    container_name: "redis-cluster"
    image: redis
    ports:
      - "6379:6379"
    volumes:
      - ~/:/$me
      - ~/docker_tmp/.bash_history:/root/.bash_history
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps
        echo "yes" |  redis-cli --cluster create 173.17.0.3:7003 173.17.0.4:7004 173.17.0.5:7005
        tail -f /dev/null
    depends_on:
      - redis1
      - redis2
      - redis3
    networks:
      app_net:
        ipv4_address: 173.17.0.2

  redis1:
    container_name: "redis1"
    image: redis
    ports:
      - "7003:7003"
    volumes:
      - ~/:/$me
      - `pwd`/conf/redis1:/usr/local/etc/redis/
      - ~/docker_tmp/.bash_history:/root/.bash_history
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps telnet
        redis-server /usr/local/etc/redis/redis.conf
    networks:
      app_net:
        ipv4_address: 173.17.0.3

  redis2:
    container_name: "redis2"
    image: redis
    ports:
      - "7004:7004"
    volumes:
      - ~/:/$me
      - `pwd`/conf/redis2:/usr/local/etc/redis/
      - ~/docker_tmp/.bash_history:/root/.bash_history
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps telnet 
        redis-server /usr/local/etc/redis/redis.conf
    networks:
      app_net:
        ipv4_address: 173.17.0.4

  redis3:
    container_name: "redis3"
    image: redis
    ports:
      - "7005:7005"
    volumes:
      - ~/:/$me
      - `pwd`/conf/redis3:/usr/local/etc/redis/
      - ~/docker_tmp/.bash_history:/root/.bash_history
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps telnet
        redis-server /usr/local/etc/redis/redis.conf
    networks:
      app_net:
        ipv4_address: 173.17.0.5

  php:
    image: php:7.4-cli
    container_name: "redis_php"
    volumes:
      - ~/:/$me
      - ~/docker_tmp/.bash_history:/root/.bash_history
    networks:
      app_net:
        ipv4_address: 173.17.0.6
    command:
      - bash
      - "-c"
      - |
        apt-get update
        apt-get install -y procps telnet
        pecl install redis -y
        echo "extension=redis.so" >> /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini
        tail -f /dev/null

networks:
  app_net:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 173.17.0.0/16


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
