FROM centos:latest
RUN yum install -y dnsmasq tftp-server nano syslinux nfs-utils \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir /etc/tftpboot/pxelinux.cfg

RUN systemctl start dnsmasq \
    && systemctl start tftpd \
    && systemctl enable dnsmasq \
    && systemctl enable tftpd

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD default.conf /etc/tftpboot/pxelinux.cfg/default
ADD entrypoint.sh /usr/local/sbin

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
#ENTRYPOINT ["mysql"]
