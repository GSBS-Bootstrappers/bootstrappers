#!/bin/bash

# this is meant to be run ONCE right after initial setup
# to copy out some stuff to external filesystems

# docker run -ti --rm -v /data/docker/bootstrappers/:/mnt myimageid /root/copyfs.sh

# stop services 

service apache2 stop

/root/pullBootstrapps.sh

# assume external mounts at /mnt!
tar cf - /var/log  /var/www/html/ | \
	tar -C /mnt -xf -
