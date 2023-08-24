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
now type and wait the ubuntu install
```ruby
curl -s https://raw.githubusercontent.com/Franceschinie/switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu/main/UbuntuinstallerfroVMC.sh | bash -s 
```
now type and wait the installation of integrated ChromeOs apps
```ruby
curl -s https://raw.githubusercontent.com/Franceschinie/switch-your-ChromeOS-Linux-from-Debian-to-Ubuntu/main/setup.sh | bash -s
```
reboot system 
