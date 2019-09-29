#!/bin/sh

start() {
  /usr/sbin/dnsmasq -k
}


mount() {
  mkdir -p /etc/tftpboot/images/ubuntu \
  && mkdir -p /mnt/nfs \
  && mount -t nfs ${NFS_PATH} /mnt/nfs/ \
  && cp /mnt/nfs/casper/vmlinuz /etc/tftpboot/images/ubuntu/vmlinuz \
  && cp /mnt/nfs/casper/initrd /etc/tftpboot/images/ubuntu/initrd
}

mount
start
