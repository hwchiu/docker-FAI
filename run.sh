#!/bin/sh
CONFIG_FILE=/etc/dhcp/dhcpd.conf;
exec dhcpd -user dhcpd -group dhcpd -f -4 -pf /run/dhcp-server/dhcpd.pid -cf /etc/dhcp/dhcpd.conf FAIbr0
