#!/bin/bash

# Deploy vars
CHROOT="/my-chroot"
DIST_MIRROR_URL="http://mirror.yandex.ru/ubuntu/"
DIST="trusty"

# Paths inside chroot
chroot_var_run="/var/run"
chroot_etc_docker="/etc/docker"
chroot_var_log="/var/log"

# Host Path
var_run=$(readlink -f /var/run)
etc_docker=$(readlink -f  /etc/docker)
var_log=$(readlink -f /var/log)

cd /
mkdir $CHROOT
debootstrap $DIST $CHROOT $DIST_MIRROR_URL

# Attaching host root to chroot
echo "proc /$CHROOT/proc proc defaults 0 0" >> /etc/fstab
echo "sysfs /$CHROOT/sys sysfs defaults 0 0" >> /etc/fstab
echo "$var_run $CHROOT/$chroot_var_run none bind 0 0" >> /etc/fstab
echo "$etc_docker $CHROOT/$chroot_etc_docker none bind 0 0" >> /etc/fstab
echo "$var_log $CHROOT/$chroot_var_log none bind 0 0" >> /etc/fstab

# Directory hardlinks
mount $CHROOT/$chroot_var
mount $CHROOT/$chroot_var
mount $CHROOT/$chroot_var
mount $CHROOT/proc
mount $CHROOT/sys

for each_file in /etc/hosts /etc/hostname /etc/resolv.conf ; do
	rm -f $CHROOT/$each_file;
	ln $each_file $CHROOT/$each_file;
done

chroot /$CHROOT /bin/bash
# dselect

#[ you may use aptitude, install mc and vim ... ]
#main # echo "8:23:respawn:/usr/sbin/chroot /$CHROOT " \
#"/sbin/getty 38400 tty8" >> /etc/inittab
#[ define a login tty that will use this system ]
#main # init q
#[ reload init ]

MESOS
--docker_socket=VALUE 
 	The UNIX socket path to be mounted into the docker executor container to provide docker CLI access to the docker daemon. This must be the path used by the slave's docker image. (default: /var/run/docker.sock) 

--docker_store_dir=VALUE
 	Directory the Docker provisioner will store images in (default: /tmp/mesos/store/docker) 