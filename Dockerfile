FROM ubuntu:16.04
MAINTAINER Hung-Wei Chiu <hwchiu@linkernetworks.com>
RUN apt-get update -y
RUN apt-get -y install isc-dhcp-server \
    tftp-server \
    xinetd


ADD configs/custom.d  /etc/xinetd.d/tftp
ADD configs/dhcpd.conf /etc/dhcp/dhcpd.conf
ADD configs/isc-dhcp-server /etc/default/isc-dhcp-server

RUN mkdir -p /install/tftpboot \
    chmod -R 777 /install/tftpboot\
    chmod -R nobody /install/tftpboot
RUN systemctl restart isc-dhcp-server.service \
    systemctl restart xinetd.service

CMD ["/bin/bash"]
