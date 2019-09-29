FROM alpine:latest
MAINTAINER Jakub Fridrich (https://jafr.eu/)

RUN apk update && apk upgrade
RUN apk --no-cache add dnsmasq syslinux nfs-utils \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

#RUN mkdir -p /etc/tftpboot \
#    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
#    && mkdir -p /etc/tftpboot/pxelinux.cfg

ADD dnsmasq.conf /etc/dnsmasq.conf
#ADD default.conf /etc/tftpboot/pxelinux.cfg/default

ADD start_dnsmasq.sh /

RUN chmod 777 /start_dnsmasq.sh
#ADD entrypoint.sh /usr/local/bin
#RUN rc-update add dnsmasq
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /start_dnsmasq.sh
