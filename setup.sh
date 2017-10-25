#!/usr/bin/env bash
#Copy Files
mv "/tmp/tftp" "/etc/xinetd.d/tftp"
mv "/tmp/dhcpd.conf" "/etc/dhcp/dhcpd.conf"
mv "/tmp/isc-dhcp-server" "/etc/default/isc-dhcp-server"


#Install FAI
wget -O - https://fai-project.org/download/074BCDE4.asc | apt-key add -
echo "deb http://fai-project.org/download stretch koeln" > /etc/apt/sources.list.d/fai.list
apt-get update
apt-get install fai-quickstart

sed -i -e 's/^#deb/deb/' /etc/fai/apt/sources.list
sed -i -e 's/#LOGUSER/LOGUSER/' /etc/fai/fai.conf

fai-setup -v

cp -a /usr/share/doc/fai-doc/examples/simple/* /srv/fai/config/
cp /usr/share/doc/fai-doc/examples/etc/dhcpd.conf /etc/dhcp/
