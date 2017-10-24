#!/bin/bash
if [ $# -lt 1 ];
then
        echo "[Usage] run.sh IFNAME"
        echo "Example. run.sh enp0s8"
        exit
fi
INTERFACE=$1
sed -i -e "s/FAIbr0/$INTERFACE/g" "/etc/default/isc-dhcp-server"
service rpcbind restart
service isc-dhcp-server restart
service xinetd restart
service nfs-kernel-server restart
