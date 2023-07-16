#!/bin/bash 
lxc stop -f penguin
lxc delete penguin
lxc launch ubuntu:23.04 penguin --debug < /dev/null
lxc exec penguin -- sudo apt update
lxc exec penguin -- sudo apt upgrade -y
lxc exec penguin -- sudo echo "deb https://storage.googleapis.com/cros-packages bullseye main" > /etc/apt/sources.list.d/cros.list
lxc exec penguin -- if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi
lxc exec penguin -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
lxc exec penguin -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
lxc exec penguin -- sudo apt update
lxc exec penguin -- sudo apt download cros-ui-config
lxc exec penguin -- sudo apt download cros-guest-tools
lxc exec penguin -- sudo apt download cros-im
lxc exec penguin -- sudo apt install libgtk-3-0 -y
lxc exec penguin -- sudo dpkg --configure -a
lxc exec penguin -- sudo dpkg-deb -x  cros-im_*_amd64.deb crosim
lxc exec penguin -- sudo dpkg-deb --control  cros-im_*_amd64.deb crosim/DEBIAN
lxc exec penguin -- sudo sed -i 's/, qtbase-abi-5-15-2//g' crosim/DEBIAN/control
lxc exec penguin -- sudo dpkg -b crosim crosim.deb
lxc exec penguin -- sudo apt install ./cros-ui-config_*_all.deb -y
lxc exec penguin -- sudo dpkg --configure -a 
lxc exec penguin -- sudo dpkg --force-overwrite -i cros-ui-config_*_all.deb 
lxc exec penguin -- sudo apt install ./crosim.deb -y
lxc exec penguin -- sudo apt install gnome-software -y
lxc exec penguin -- sudo apt install ./cros-guest-tools_*_all.deb -y
lxc exec penguin -- sudo rm -rf cros-guest-tools_*_all.deb cros-ui-config_*_all.deb cros-im cros-im_*_amd64.deb crosim crosim.deb 
lxc exec penguin -- sudo reboot
