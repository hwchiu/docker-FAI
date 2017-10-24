#!/usr/bin/env bash
IMAGE=ubuntu-16.04.3-desktop-amd64
IMAGEISO=${IMAGE}.iso
apt-get update
apt-get -y install isc-dhcp-server \
    tftpd \
    xinetd \
    nfs-kernel-server

mkdir -p /install/tftpboot/ubuntu-16.04.3-desktop-amd64
chmod -R 777 /install/tftpboot
chown -R nobody /install/tftpboot
touch /var/lib/dhcp/dhcpd.leases
chown root:dhcpd /var/lib/dhcp /var/lib/dhcp/dhcpd.leases
chmod 775 /var/lib/dhcp
chmod 664 /var/lib/dhcp/dhcpd.leases


mkdir /tmp/iso
cd /tmp/iso
wget -q http://releases.ubuntu.com/16.04/ubuntu-16.04.3-desktop-amd64.iso
mount -oloop,ro /tmp/${IMAGEISO} /tmp/iso

cp /tmp/iso/casper/{vmlinuz.efi,initrd.lz} /install/tftpboot/${IMAGE}/
mkdir /${IMAGE}
cp -R /tmp/iso/* /tmp/iso/.disk /${IMAGE}/
umount /tmp/iso
echo "/${IMAGE}           *(ro,sync,no_wdelay,insecure_locks,no_root_squash,insecure,no_subtree_check)" >> /etc/exports
rm -rf /tmp/${IMAGEISO}

### NFS Server and Image files
