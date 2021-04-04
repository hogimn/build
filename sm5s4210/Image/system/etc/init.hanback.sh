#!/system/bin/sh

#ifconfig eth0 192.168.0.165 netmask 255.255.255.0 up
#route add default gw 192.168.0.1 dev eth0
setprop net.dns0 164.124.101.2
setprop net.dns1 168.126.63.1
setprop net.eth0.dns1 164.124.101.2

