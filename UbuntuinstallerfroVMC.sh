#!/bin/bash 
lxc stop -f penguin
lxc delete penguin
lxc launch ubuntu:23.04 penguin --debug < /dev/null
lxc exec penguin -- sudo wget https://github.com/Franceschinie/switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu/blob/main/setup.sh
lxc exec penguin -- sudo chmod +x ./setup.sh
lxc exec penguin -- sudo bash ./setup.sh
