FROM alpine:latest

RUN apk update && apk upgrade
RUN apk --no-cache add dnsmasq nano syslinux nfs-utils openrc \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir -p /etc/tftpboot/pxelinux.cfg

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD default.conf /etc/tftpboot/pxelinux.cfg/default

COPY start_dnsmasq.sh /bin/start_dnsmasq.sh
COPY entrypoint.sh /usr/local/bin

#RUN rc-update add dnsmasq

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD "/bin/start_dnsmasq.sh"
