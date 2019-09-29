FROM alpine:latest
MAINTAINER Jakub Fridrich (https://jafr.eu/)

RUN apk --no-cache add dnsmasq syslinux nfs-utils

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir -p /etc/tftpboot/pxelinux.cfg

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY default.conf /etc/tftpboot/pxelinux.cfg/default

EXPOSE 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
