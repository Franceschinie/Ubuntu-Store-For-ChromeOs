#!/bin/sh 
lxc stop -f penguin
lxc delete penguin
lxc launch ubuntu:23.04 penguin --debug < /dev/null
lxc exec penguin -- curl -s https://raw.githubusercontent.com/Franceschinie/switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu/main/setup.sh | bash -s 
