#!/usr/bin/env bash

cp /etc/fstab /etc/fstab.backup


blkid | grep sdb1 | awk '{ print $2 }' > ${HOME}/newhomeUUID.txt
sed -i 's/\"//g' ${HOME}/newhomeUUID.txt

NEWFSTAB=$(cat ${HOME}/newhomeUUID.txt)
echo "$NEWFSTAB     /home    ext4    defaults   0  2" | tee -a /etc/fstab
