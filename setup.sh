#!/usr/bin/env bash
apt-get update
#Copy Files


#Install FAI
wget -O - https://fai-project.org/download/074BCDE4.asc | apt-key add -
echo "deb http://fai-project.org/download stretch koeln" > /etc/apt/sources.list.d/fai.list
apt-get update
#apt-get install -y isc-dhcp-server fai-quickstart
apt-get install -y fai-quickstart

sed -i -e 's/^#deb/deb/' /etc/fai/apt/sources.list
sed -i -e 's/#LOGUSER/LOGUSER/' /etc/fai/fai.conf

fai-setup -v

cp -a /usr/share/doc/fai-doc/examples/simple/* /srv/fai/config/
mv "/tmp/dhcpd.conf" "/etc/dhcp/dhcpd.conf"
mv "/tmp/run.sh:" ~/
sed -i -e "s/\/var\/lib\/tftpboot/\/srv\/tftp/g" /etc/default/tftpd-hpa
