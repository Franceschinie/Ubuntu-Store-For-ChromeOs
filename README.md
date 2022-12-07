# switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu
setup crostini linux 
press ctrl + alt + t
now you can see 
crosh> copy 
and paste this command on crosh
start your vm
```ruby
vmc start --enable-gpu --writable-rootfs termina
```
now you can see
(termina) chronos@localhost ~ $ 
now type
```ruby
lxc launch ubuntu:22.10 penguin --debug
```
wait the vm download and creation
execute the new vm 
```ruby
lxc exec penguin -- bash
```
get su privilegies 
```ruby
sudo su
```
update and upgrade the package menager
```ruby
apt update && apt upgrade -y
```
now we have to install the ChromeOs integration
1: add sources
```ruby
echo "deb https://storage.googleapis.com/cros-packages bullseye main" > /etc/apt/sources.list.d/cros.list
if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi
```
2: add keys
```ruby
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
```
3: re-update the package menager
```ruby
apt update
```
4: download cros integration apps
```ruby
apt download cros-ui-config
apt download cros-guest-tools
```
5: install gtk-3-0
```ruby
apt install libgtk-3-0
dpkg --configure -a
```
 6: install first integration app: cros-ui-config
```ruby
apt install ./cros-ui-config_0.15_all.deb 
dpkg --configure -a 
dpkg --force-overwrite -i cros-ui-config_0.15_all.deb 
```
7: install second integration app: cros-guest-tools
```ruby
apt install ./cros-guest-tools_0.32_all.deb
```
8: remove files
```ruby
rm -rf cros-guest-tools_0.32_all.deb cros-ui-config_0.15_all.deb 
```
