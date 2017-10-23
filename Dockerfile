FROM ubuntu:16.04
MAINTAINER Hung-Wei Chiu <hwchiu@linkernetworks.com>
RUN apt-get update -y
RUN apt-get -y install isc-dhcp-server
