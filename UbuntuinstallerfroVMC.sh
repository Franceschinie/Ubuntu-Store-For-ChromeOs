#!/bin/bash 
lxc stop -f penguin
lxc delete penguin
lxc launch ubuntu:23.04 penguin --debug < /dev/null
lxc exec penguin -- bash
