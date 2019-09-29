FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add dnsmasq nano syslinux nfs-utils \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir -p /etc/tftpboot/pxelinux.cfg

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD default.conf /etc/tftpboot/pxelinux.cfg/default
ADD entrypoint.sh /usr/local/sbin

RUN chmod 755 /usr/local/sbin/entrypoint.sh

RUN rc-service dnsmasq start \
    && rc-update add dnsmasq

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
