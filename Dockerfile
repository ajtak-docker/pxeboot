FROM centos:latest
RUN yum install -y dnsmasq tftp-server nano syslinux nfs-utils \
    && mv /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

RUN mkdir -p /etc/tftpboot \
    && cp -rs /usr/share/syslinux/* /etc/tftpboot \
    && mkdir /etc/tftpboot/pxelinux.cfg

## NFS Mount
RUN mkdir /mnt/nfs \
    && mount -t nfs  192.168.0.150:/srv/storage /mnt/nfs/ \
    && cp /mnt/nfs/casper/vmlinuz /etc/tftpboot/images/ubuntu/vmlinuz \
    && cp /mnt/nfs/casper/initrd /etc/tftpboot/images/ubuntu/initrd \
    && umount /mnt/nfs \
    && rm -rf /mnt/nfs \

RUN systemctl start dnsmasq \
    && systemctl start tftpd \
    && systemctl enable dnsmasq \
    && systemctl enable tftpd


ADD dnsmasq.conf /etc/dnsmasq.conf
ADD default.conf /etc/tftpboot/pxelinux.cfg/default


#ENTRYPOINT ["mysql"]
