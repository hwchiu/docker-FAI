#!/bin/bash
mkdir /tmp/iso
mount -oloop,ro /tmp/${IMAGEISO} /tmp/iso

cp /tmp/iso/casper/{vmlinuz.efi,initrd.lz} /install/tftpboot/${IMAGE}/
mkdir /${IMAGE}
cp -R /tmp/iso/* /tmp/iso/.disk /${IMAGE}/
umount /tmp/iso
echo "/${IMAGE}           *(ro,sync,no_wdelay,insecure_locks,no_root_squash,insecure,no_subtree_check)" >> /etc/exports
rm -rf /tmp/${IMAGEISO}

service rpcbind restart
exec dhcpd -user dhcpd -group dhcpd -f -4 -pf /run/dhcp-server/dhcpd.pid -cf /etc/dhcp/dhcpd.conf FAIbr0 &
service xinetd restart
service nfs-kernel-server restart
sleep 3000000
