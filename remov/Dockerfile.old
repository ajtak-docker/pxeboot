FROM roboxes/centos8:latest

#RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
#systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#rm -f /lib/systemd/system/multi-user.target.wants/*;\
#rm -f /etc/systemd/system/*.wants/*;\
#rm -f /lib/systemd/system/local-fs.target.wants/*; \
#rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#rm -f /lib/systemd/system/basic.target.wants/*;\
#rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum update -q -y && yum upgrade -q -y
RUN yum install -y -q dnsmasq tftp-server nano syslinux nfs-utils \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir /etc/tftpboot/pxelinux.cfg

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD default.conf /etc/tftpboot/pxelinux.cfg/default
ADD entrypoint.sh /usr/local/sbin

RUN chmod 755 /usr/local/sbin/entrypoint.sh

RUN systemctl start dnsmasq \
        && systemctl start tftpd \
        && systemctl enable dnsmasq \
        && systemctl enable tftpd

#ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
