#!/bin/bash
echo "Ubuntu on crostini integration setup"
echo "1 starting and upgrading package manager"
sudo apt update
sudo NEEDRESTART_MODE=a apt upgrade -y
echo "2 add sources and keys"
sudo echo "deb https://storage.googleapis.com/cros-packages bullseye main" > /etc/apt/sources.list.d/cros.list
if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
echo "3 download packages"
sudo apt update
sudo apt download cros-ui-config cros-guest-tools cros-im cros-adapta cros-apt-config cros-garcon cros-host-fonts cros-notificationd cros-sommelier cros-logging cros-pipe-config cros-sommelier-config cros-sudo-config cros-systemd-overrides cros-vmstat-metrics cros-wayland cros-tast-tests cros-sftp cros-pulse-config gnome-software 
echo "4 install libraries"
sudo NEEDRESTART_MODE=a apt install libgtk-3-0 -y
sudo NEEDRESTART_MODE=a dpkg --configure -a
sudo apt satisfy cros-ui-config cros-garcon cros-sommelier cros-pipe-config cros-guest-tools gnome-software
echo "5 making apps and libs compatibile with ubuntu"
sudo dpkg-deb -x  cros-im_*_amd64.deb crosim
sudo dpkg-deb --control  cros-im_*_amd64.deb crosim/DEBIAN
sudo sed -i 's/, qtbase-abi-5-15-2//g' crosim/DEBIAN/control
sudo dpkg -b crosim crosim.deb
echo "6 install apps"
echo "1/19"
sudo NEEDRESTART_MODE=a apt install ./cros-adapta_*_all.deb -y
echo "2/19"
sudo NEEDRESTART_MODE=a apt install ./cros-ui-config_*_all.deb -y
sudo dpkg --configure -a 
sudo dpkg --force-overwrite -i cros-ui-config_*_all.deb 
echo "3/19"
sudo NEEDRESTART_MODE=a apt install ./crosim.deb -y
echo "4/19"
sudo NEEDRESTART_MODE=a apt install ./cros-apt-config_*_all.deb -y
echo "4/19"
sudo NEEDRESTART_MODE=a apt install ./cros-garcon_*_all.deb -y
echo "6/19"
sudo NEEDRESTART_MODE=a apt install ./cros-host-fonts_*_all.deb -y
echo "7/19"
sudo NEEDRESTART_MODE=a apt install ./cros-notificationd_*_all.deb -y
echo "8/19"
sudo NEEDRESTART_MODE=a apt install ./cros-sommelier_*_all.deb -y
echo "9/19"
sudo NEEDRESTART_MODE=a apt install ./cros-logging_*_all.deb -y
echo "10/19"
sudo NEEDRESTART_MODE=a apt install ./cros-pipe-config_*_all.deb -y
echo "11/19"
sudo NEEDRESTART_MODE=a apt install ./cros-sommelier-config_*_all.deb -y
echo "12/19"
sudo NEEDRESTART_MODE=a apt install ./cros-sudo-config_*_all.deb -y
echo "13/19"
sudo NEEDRESTART_MODE=a apt install ./cros-systemd-overrides_*_all.deb -y
echo "14/19"
sudo NEEDRESTART_MODE=a apt install ./cros-vmstat-metrics_*_all.deb -y
echo "15/19"
sudo NEEDRESTART_MODE=a apt install ./cros-wayland_*_all.deb -y
echo "16/19"
sudo NEEDRESTART_MODE=a apt install ./cros-pulse-config_*_all.deb -y
echo "17/19"
sudo NEEDRESTART_MODE=a apt install ./cros-guest-tools_*_all.deb -y
echo "18/19"
sudo NEEDRESTART_MODE=a apt install ./cros-tast-test_*_all.deb -y
echo "19/19"
sudo NEEDRESTART_MODE=a apt install ./cros-fstp_*_all.deb -y
echo "7 install gui store"
sudo NEEDRESTART_MODE=a apt install ./gnome-software_*_amd64.deb -y
echo "7 cleanup and reboot container"
sudo rm -rf /root/*
sudo reboot
