#!/bin/bash
echo "Ubuntu store installer for crostini (13 functions)"
echo "1 download files"
sudo wget https://raw.githubusercontent.com/Franceschinie/Ubuntu-Store-For-ChromeOs/main/cros.list
sudo wget https://raw.githubusercontent.com/Franceschinie/Ubuntu-Store-For-ChromeOs/main/cros-upgrade
sudo wget https://raw.githubusercontent.com/Franceschinie/Ubuntu-Store-For-ChromeOs/main/ScriptService.service
echo "2 starting and upgrading package manager"
sudo apt update
sudo NEEDRESTART_MODE=a apt upgrade -y
echo "3 add apt sources"
sudo cp cros.list /etc/apt/sources.list.d/
echo "4 add keys"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
echo "5 download packages from google server"
sudo apt update
sudo apt download cros-ui-config cros-guest-tools cros-im cros-adapta cros-apt-config cros-garcon cros-host-fonts cros-notificationd cros-sommelier cros-logging cros-pipe-config cros-sommelier-config cros-sudo-config cros-systemd-overrides cros-vmstat-metrics cros-wayland cros-tast-tests cros-sftp cros-pulse-config cros-xdg-desktop-portal
echo "6 download ubuntu store"
sudo apt download gnome-software
echo "7 install deps from ubuntu server"
sudo NEEDRESTART_MODE=a apt install libgtk-3-0 -y
sudo NEEDRESTART_MODE=a dpkg --configure -a
echo "8 making apps and libs compatibile with ubuntu"
sudo dpkg-deb -x  cros-im_*_amd64.deb 1
sudo dpkg-deb --control  cros-im_*_amd64.deb 1/DEBIAN
sudo sed -i 's/, qtbase-abi-5-15-2//g' 1/DEBIAN/control
sudo dpkg -b 1 1.deb
echo "9 install libs"
echo "1/5"
sudo NEEDRESTART_MODE=a apt install libd3dadapter9-mesa -y
echo "2/5"
sudo NEEDRESTART_MODE=a apt install libxatracker2 -y
echo "3/5"
sudo NEEDRESTART_MODE=a apt install mesa-va-drivers -y
echo "4/5"
sudo NEEDRESTART_MODE=a apt install mesa-vdpau-drivers -y
echo "5/5"
sudo NEEDRESTART_MODE=a apt install mesa-vulkan-drivers -y
echo "10 install apps"
echo "1/20"
sudo NEEDRESTART_MODE=a apt install ./cros-adapta_*_all.deb -y
echo "2/20"
sudo NEEDRESTART_MODE=a apt install ./cros-ui-config_*_all.deb -y
sudo dpkg --configure -a 
sudo dpkg --force-overwrite -i cros-ui-config_*_all.deb 
echo "3/20"
sudo NEEDRESTART_MODE=a apt install ./1.deb -y
echo "4/20"
sudo NEEDRESTART_MODE=a apt install ./cros-apt-config_*_all.deb -y
echo "4/20"
sudo NEEDRESTART_MODE=a apt install ./cros-garcon_*_all.deb -y
echo "6/20"
sudo NEEDRESTART_MODE=a apt install ./cros-host-fonts_*_all.deb -y
echo "7/20"
sudo NEEDRESTART_MODE=a apt install ./cros-notificationd_*_all.deb -y
echo "8/20"
sudo NEEDRESTART_MODE=a apt install ./cros-sommelier_*_all.deb -y
echo "9/20"
sudo NEEDRESTART_MODE=a apt install ./cros-logging_*_all.deb -y
echo "10/20"
sudo NEEDRESTART_MODE=a apt install ./cros-pipe-config_*_all.deb -y
echo "11/20"
sudo NEEDRESTART_MODE=a apt install ./cros-sommelier-config_*_all.deb -y
echo "12/20"
sudo NEEDRESTART_MODE=a apt install ./cros-sudo-config_*_all.deb -y
echo "13/20"
sudo NEEDRESTART_MODE=a apt install ./cros-systemd-overrides_*_all.deb -y
echo "14/20"
sudo NEEDRESTART_MODE=a apt install ./cros-vmstat-metrics_*_all.deb -y
echo "15/20"
sudo NEEDRESTART_MODE=a apt install ./cros-wayland_*_all.deb -y
echo "16/20"
sudo NEEDRESTART_MODE=a apt install ./cros-pulse-config_*_all.deb -y
echo "17/20"
sudo NEEDRESTART_MODE=a apt install ./cros-guest-tools_*_all.deb -y
echo "18/20"
sudo NEEDRESTART_MODE=a apt install ./cros-tast-tests_*_all.deb -y
echo "19/20"
sudo NEEDRESTART_MODE=a apt install ./cros-sftp_*_all.deb -y
echo "20/20"
sudo NEEDRESTART_MODE=a apt install ./cros-xdg-desktop-portal_*_all.deb -y
echo "11 install gui store"
sudo NEEDRESTART_MODE=a apt install ./gnome-software_*_amd64.deb -y
echo "12 install binary"
sudo cp -f cros-upgrade /bin/
chmod a+x /bin/cros-upgrade
sudo cp -f ScriptService.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ScriptService.service
systemctl enable ScriptService.service
echo "13 cleanup and reboot container"
sudo rm -rf /root/*
sudo reboot
