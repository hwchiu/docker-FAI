FROM ubuntu:16.04
MAINTAINER Hung-Wei Chiu <hwchiu@linkernetworks.com>

ARG IMAGE=ubuntu-16.04.3-desktop-amd64
ENV IMAGE=${IMAGE}
ENV IMAGEISO=${IMAGE}.iso

RUN apt-get update -y \
  && apt-get -y install isc-dhcp-server \
    tftpd \
    xinetd \
    nfs-kernel-server


ADD configs/tftp  /etc/xinetd.d/tftp
ADD configs/dhcpd.conf /etc/dhcp/dhcpd.conf
ADD configs/isc-dhcp-server /etc/default/isc-dhcp-server
ADD run.sh /bin/run.sh

RUN mkdir -p /install/tftpboot \
    && chmod -R 777 /install/tftpboot\
    && chown -R nobody /install/tftpboot \
    && touch /var/lib/dhcp/dhcpd.leases \
    && chown root:dhcpd /var/lib/dhcp /var/lib/dhcp/dhcpd.leases \
    && chmod 775 /var/lib/dhcp \
    && chmod 664 /var/lib/dhcp/dhcpd.leases

### NFS Server and Image files
COPY images/${IMAGEISO} /tmp

RUN mkdir /tmp/iso

RUN chmod 755 /bin/run.sh
RUN env
CMD ["/bin/run.sh"]
