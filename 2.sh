#!/bin/bash
echo "Ubuntu store installer fro crostini (11 functions)"
echo "1 starting and upgrading package manager"
sudo apt update
sudo NEEDRESTART_MODE=a apt upgrade -y
echo "2 add sources and keys"
sudo echo "deb https://storage.googleapis.com/cros-packages bullseye main" > /etc/apt/sources.list.d/cros.list
if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
echo "3 download packages from google server"
sudo apt update
sudo apt download cros-ui-config cros-guest-tools cros-im cros-adapta cros-apt-config cros-garcon cros-host-fonts cros-notificationd cros-sommelier cros-logging cros-pipe-config cros-sommelier-config cros-sudo-config cros-systemd-overrides cros-vmstat-metrics cros-wayland cros-tast-tests cros-sftp cros-pulse-config libgles2-mesa libgl1-mesa-glx libgl1-mesa-dev libegl1-mesa libegl1-mesa-dev libwayland-egl1-mesa libd3dadapter9-mesa-dbgsym mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers libxatracker2 
echo "5 download ubuntu store"
sudo apt download gnome-software
echo "6 install deps from ubuntu server"
sudo NEEDRESTART_MODE=a apt install libgtk-3-0 -y
sudo NEEDRESTART_MODE=a dpkg --configure -a
sudo apt satisfy cros-ui-config cros-garcon cros-sommelier cros-pipe-config cros-guest-tools gnome-software
echo "7 making apps and libs compatibile with ubuntu"
echo "1/6"
sudo dpkg-deb -x  cros-im_*_amd64.deb 1
sudo dpkg-deb --control  cros-im_*_amd64.deb 1/DEBIAN
sudo sed -i 's/, qtbase-abi-5-15-2//g' 1/DEBIAN/control
sudo dpkg -b 1 1.deb
echo "2/6"
sudo dpkg-deb -x  libd3dadapter9-mesa_*_amd64.deb 2
sudo dpkg-deb --control  libd3dadapter9-mesa_*_amd64.deb 2/DEBIAN
sudo sed -i 's/, libllvm11 (>= 1:9~svn298832-1~)//g' 2/DEBIAN/control
sudo dpkg -b 2 2.deb
echo "3/6"
sudo dpkg-deb -x  libxatracker2_*_amd64.deb 3
sudo dpkg-deb --control  libxatracker2_*_amd64.deb 3/DEBIAN
sudo sed -i 's/, libllvm11 (>= 1:9~svn298832-1~)//g' 3/DEBIAN/control
sudo dpkg -b 3 3.deb
echo "4/6"
sudo dpkg-deb -x  mesa-va-drivers_*_amd64.deb 4
sudo dpkg-deb --control  mesa-va-drivers_*_amd64.deb 4/DEBIAN
sudo sed -i 's/, libllvm11 (>= 1:9~svn298832-1~)//g' 4/DEBIAN/control
sudo dpkg -b 4 4.deb
echo "5/6"
sudo dpkg-deb -x  mesa-vdpau-drivers_*_amd64.deb 5
sudo dpkg-deb --control  mesa-vdpau-drivers_*_amd64.deb 5/DEBIAN
sudo sed -i 's/, libllvm11 (>= 1:9~svn298832-1~)//g' 5/DEBIAN/control
sudo dpkg -b 5 5.deb
echo "6/6"
sudo dpkg-deb -x  mesa-vulkan-drivers_*_amd64.deb 6
sudo dpkg-deb --control  mesa-vulkan-drivers_*_amd64.deb 6/DEBIAN
sudo sed -i 's/, libllvm11 (>= 1:9~svn298832-1~)//g' 6/DEBIAN/control
sudo dpkg -b 6 6.deb
echo "8 install google libs"
echo "1/5"
sudo NEEDRESTART_MODE=a apt install ./2.deb -y
sudo NEEDRESTART_MODE=a apt install libd3dadapter9-mesa-dbgsym -y
echo "2/5"
sudo NEEDRESTART_MODE=a apt install ./3.deb -y
sudo NEEDRESTART_MODE=a apt install libxatracker2-dbgsym -y
echo "3/5"
sudo NEEDRESTART_MODE=a apt install ./4.deb -y
sudo NEEDRESTART_MODE=a apt install mesa-va-drivers-dbgsym -y
echo "4/5"
sudo NEEDRESTART_MODE=a apt install ./5.deb -y
sudo NEEDRESTART_MODE=a apt install mesa-vdpau-drivers-dbgsym -y
echo "5/5"
sudo NEEDRESTART_MODE=a apt install ./6.deb -y
sudo NEEDRESTART_MODE=a apt install  mesa-vulkan-drivers-dbgsym -y
echo "9 install apps"
echo "1/19"
sudo NEEDRESTART_MODE=a apt install ./cros-adapta_*_all.deb -y
echo "2/19"
sudo NEEDRESTART_MODE=a apt install ./cros-ui-config_*_all.deb -y
sudo dpkg --configure -a 
sudo dpkg --force-overwrite -i cros-ui-config_*_all.deb 
echo "3/19"
sudo NEEDRESTART_MODE=a apt install ./1.deb -y
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
echo "10 install gui store"
sudo NEEDRESTART_MODE=a apt install ./gnome-software_*_amd64.deb -y
echo "11 cleanup and reboot container"
sudo rm -rf /root/*
sudo reboot
