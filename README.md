# switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu
press ctrl + alt + t
now you can see 
crosh> copy 
and paste this command on crosh
```ruby
vmc list   
```
you see : /vm name/ (tot size, min shrinkable size, disk type, parse)
destroy al virtual machines using
```ruby
vmc destroy /vm name/
```
then create one
```ruby
vmc create termina
```
start your vm
```ruby
vmc start --enable-gpu --writable-rootfs termina
```
now you can see
(termina) chronos@localhost ~ $ 
now type
```ruby
lxc launch ubuntu:22.10 termina --debug
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
4: download libgtk
```ruby
apt download libgtk-3-0
```
5: install first integration app: cros-ui-config
```ruby
apt install cros-ui-config && dpkg --configure -a
```
5: install gtk-3-0
```ruby
apt install gtk-3-0 && dpkg --configure -a && dpkg --force-overwrite -i libgtk-3-0_3.24.34-3ubuntu2_amd64.deb 
```
6: install second integration app: cros-guest-tools
```ruby
apt install cros-guest-tools
```
7: remove files
```ruby
rm -rf libgtk-3-0_3.24.34-3ubuntu2_amd64.deb
```
