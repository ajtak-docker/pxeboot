FROM alpine:3.7
MAINTAINER Jakub Fridrich (https://jafr.eu/)

RUN apk --no-cache add dnsmasq syslinux nfs-utils

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir -p /etc/tftpboot/pxelinux.cfg

COPY dnsmasq.conf /etc/
COPY default.conf /etc/tftpboot/pxelinux.cfg

EXPOSE 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
