#!/bin/bash 
lxc stop -f penguin
lxc delete penguin
lxc launch ubuntu:23.04 penguin --debug < /dev/null
lxc exec penguin -- echo "#!/bin/bash
echo "Ubuntu on crostini integration setup"
echo "1 starting and upgrading package manager"
sudo apt update
sudo apt upgrade -y
echo "2 add sources and keys"
sudo echo "deb https://storage.googleapis.com/cros-packages bullseye main" > /etc/apt/sources.list.d/cros.list
if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
echo "3 download packages"
sudo apt update
sudo apt download cros-ui-config
sudo apt download cros-guest-tools
sudo apt download cros-im
echo "4 install libraries"
sudo apt install libgtk-3-0 -y
sudo dpkg --configure -a
echo "5 making apps compatibile with ubuntu"
sudo dpkg-deb -x  cros-im_*_amd64.deb crosim
sudo dpkg-deb --control  cros-im_*_amd64.deb crosim/DEBIAN
sudo sed -i 's/, qtbase-abi-5-15-2//g' crosim/DEBIAN/control
sudo dpkg -b crosim crosim.deb
echo "6 install apps"
sudo apt install ./cros-ui-config_*_all.deb -y
sudo dpkg --configure -a 
sudo dpkg --force-overwrite -i cros-ui-config_*_all.deb 
sudo apt install ./crosim.deb -y
sudo apt install ./cros-guest-tools_*_all.deb -y
echo "7 cleanup and reboot container"
sudo rm -rf cros-guest-tools_*_all.deb cros-ui-config_*_all.deb cros-im cros-im_*_amd64.deb crosim crosim.deb 
sudo reboot" >> 1.sh
lxc exec penguin -- sudo chmod +x ./1.sh
lxc exec penguin -- sudo bash ./1.sh
