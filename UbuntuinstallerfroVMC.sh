#!/bin/sh 
echo "stop the machine"
lxc stop -f penguin
lxc delete penguin
echo "download and install Ubuntu 23.04"
lxc launch ubuntu:23.04 penguin --debug
echo "starting setup"
lxc exec penguin -- bash <(curl https://raw.githubusercontent.com/Franceschinie/switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu/main/setup.sh)
