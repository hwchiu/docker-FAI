#!/usr/bin/env bash
IMAGE=ubuntu-16.04.3-desktop-amd64
IMAGEISO=${IMAGE}.iso
apt-get update
apt-get -y install isc-dhcp-server \
    tftpd \
    xinetd \
    nfs-kernel-server


#Create Directory/Files

##Tftp Server
mkdir -p /install/tftpboot/${IMAGE}
##Loop Mount
mkdir /tmp/iso
##NFS Server
mkdir /${IMAGE}
##DHCP
touch /var/lib/dhcp/dhcpd.leases
#PXE Linux
mkdir /install/tftpboot/pxelinux.cfg

#Copy files

mv "/tmp/tftp" "/etc/xinetd.d/tftp"
mv "/tmp/dhcpd.conf" "/etc/dhcp/dhcpd.conf"
mv "/tmp/isc-dhcp-server" "/etc/default/isc-dhcp-server"
mv "/tmp/pxelinux.0" "/install/tftpboot/pxelinux.0"
mv "/tmp/libcom32.c32" "/install/tftpboot/libcom32.c32"
mv "/tmp/libutil.c32" "/install/tftpboot/libutil.c32"
mv "/tmp/ldlinux.c32" "/install/tftpboot/ldlinux.c32"
mv "/tmp/vesamenu.c32" "/install/tftpboot/vesamenu.c32"
mv "/tmp/default" "/install/tftpboot/pxelinux.cfg/default"
mv "/tmp/run.sh" "~ubuntu/run.sh"

#Change String
sed -i -e "s/IMAGE/$IMAGE/g" "/install/tftpboot/pxelinux.cfg/default"

#Change Permission
##TFTP Server
chmod -R 777 /install/tftpboot
chown -R nobody /install/tftpboot

##DHCP
chown root:dhcpd /var/lib/dhcp /var/lib/dhcp/dhcpd.leases
chmod 775 /var/lib/dhcp
chmod 664 /var/lib/dhcp/dhcpd.leases


#Donwload Images
cd /tmp/
wget -q http://releases.ubuntu.com/16.04/${IMAGEISO}

#Mount Loop Devices and get vmlinuz.efim initrd.lz and save them into TFTP server
mount -oloop,ro /tmp/${IMAGEISO} /tmp/iso
cp /tmp/iso/casper/{vmlinuz.efi,initrd.lz} /install/tftpboot/${IMAGE}/

#Copy File into NFS Servrer
cp -R /tmp/iso/* /tmp/iso/.disk /${IMAGE}/
umount /tmp/iso
#Add entry for NFS to export.
echo "/${IMAGE}           *(ro,sync,no_wdelay,insecure_locks,no_root_squash,insecure,no_subtree_check)" >> /etc/exports
rm -rf /tmp/${IMAGEISO}

