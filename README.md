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
curl -s https://raw.githubusercontent.com/Franceschinie/Ubuntu-Store-For-ChromeOs/main/1.sh | bash -s
```
start container
```ruby
lxc exec penguin -- bash
```
now type and wait the installation of integrated ChromeOs apps
```ruby
curl -s https://raw.githubusercontent.com/Franceschinie/Ubuntu-Store-For-ChromeOs/main/2.sh | bash -s
```
reboot system 
