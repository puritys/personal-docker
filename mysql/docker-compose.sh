#!/bin/bash

# -----------------------
# start docker compose
# ./docker-compose.sh up
#
# restart one container
# ./docker-compose.sh reup adminer
# -----------------------

MYSQL_ROOT_PASSWORD=test
ADMINER_THEME=pepa-linha

if [ "x`uname`" = "xDarwin" ] ; then
    addr=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'| head -n 1`
    hostname=`nslookup $addr | grep name | awk '{print substr($4, 1, length($4)-1)}'`
else
    hostname=`hostname`;
fi

mkdir -p db

cat > docker-compose.yml << TEXT
version: '3'

services:

  mysql:
    container_name: "mysql"
    hostname: "$hostname"
    #image: mysql:5.7.27
    image: mysql
    command: mysqld --default-authentication-plugin=mysql_native_password --sql_mode="" --character-set-server=utf8 --collation-server=utf8_unicode_ci --init-connect='SET NAMES UTF8;' --innodb-flush-log-at-trx-commit=0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: "$MYSQL_ROOT_PASSWORD"
    ports:
      - "3306:3306"
    volumes:
      - ./db:/var/lib/mysql

  adminer:
    container_name: "adminer"
    image: adminer
    restart: always
    environment:
      - ADMINER_DESIGN="$ADMINER_THEME"
    ports:
      - "80:8080"

TEXT

if [ "reup" == "$1" ] && [ "x" != "x$2" ];then
    docker-compose stop $2
    docker-compose up -d $2
    exit
fi

if [ "up" == "$1" ];then
    docker-compose pull
    docker-compose $1 -d
else
    docker-compose $1
fi
