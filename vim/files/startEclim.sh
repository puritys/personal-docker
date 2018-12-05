#!/bin/bash

sudo rm -f /tmp/.X1-lock
ps aux |grep -i Xvfb |grep -v grep | awk '{printf "kill -9 %s\n",$2}' | sudo sh
sudo Xvfb :1 -screen 0 1024x768x24 &
DISPLAY=:1 sudo -u vim /root/eclipse/eclimd -b

