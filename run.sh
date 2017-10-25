#!/bin/bash
if [ $# -lt 1 ];
then
        echo "[Usage] run.sh IFNAME"
        echo "Example. run.sh enp0s8"
        exit
fi
INTERFACE=$1
sed -i -e "s/FAIbr0/$INTERFACE/g" "/etc/default/isc-dhcp-server"
myip=$(ip a s $dev|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'|head -1)
sed -i -e "s/$myip\/24/\*/" /etc/exports
sed -i -e "s/\/var\/lib\/tftpboot\//\/srv\/tftp\/" /etc/default/tftpd-hpa

service rpcbind restart
service isc-dhcp-server restart
service nfs-kernel-server restart
service tftpd-hpa restart


sudo fai-chboot -IFv -u nfs://10.0.0.2/srv/fai/config default
