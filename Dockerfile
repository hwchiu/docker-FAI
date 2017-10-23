FROM ubuntu:16.04
MAINTAINER Hung-Wei Chiu <hwchiu@linkernetworks.com>
RUN apt-get update -y
RUN apt-get -y install isc-dhcp-server \
    tftp-server \
    xinetd


ADD configs/tftp  /etc/xinetd.d/tftp
ADD configs/dhcpd.conf /etc/dhcp/dhcpd.conf
ADD configs/isc-dhcp-server /etc/default/isc-dhcp-server
ADD run.sh /bin/run.sh

RUN mkdir -p /install/tftpboot \
    && chmod -R 777 /install/tftpboot\
    && chown -R nobody /install/tftpboot
RUN touch /var/lib/dhcp/dhcpd.leases \
    && chown root:dhcpd /var/lib/dhcp /var/lib/dhcp/dhcpd.leases \
    && chmod 775 /var/lib/dhcp \
    && chmod 664 /var/lib/dhcp/dhcpd.leases


CMD ["/bin/run.sh"]
