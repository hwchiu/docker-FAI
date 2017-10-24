#!/bin/bash
service rpcbind restart
exec dhcpd -user dhcpd -group dhcpd -f -4 -pf /run/dhcp-server/dhcpd.pid -cf /etc/dhcp/dhcpd.conf FAIbr0 &
service xinetd restart
service nfs-kernel-server restart
