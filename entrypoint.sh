## NFS Mount -- outside dockerhub
RUN mkdir /mnt/nfs \
    && mount -t nfs ${NFS_PATH} /mnt/nfs/ \
    && cp /mnt/nfs/casper/vmlinuz /etc/tftpboot/images/ubuntu/vmlinuz \
    && cp /mnt/nfs/casper/initrd /etc/tftpboot/images/ubuntu/initrd \
    && umount /mnt/nfs \
    && rm -rf /mnt/nfs \
