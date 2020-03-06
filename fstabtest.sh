#!/usr/bin/env bash

ANSI_RED=$'\033[1;31m'
ANSI_YEL=$'\033[1;33m'
ANSI_GRN=$'\033[1;32m'
ANSI_VIO=$'\033[1;35m'
ANSI_BLU=$'\033[1;36m'
ANSI_WHT=$'\033[1;37m'
ANSI_RST=$'\033[0m'

echo_cmd()    { echo -e "${ANSI_BLU}${@}${ANSI_RST}"; }
echo_note()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_info()   { echo -e "${ANSI_GRN}${@}${ANSI_RST}"; }
echo_prompt() { echo -e "${ANSI_WHT}${@}${ANSI_RST}"; }
echo_warn()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_debug()  { echo -e "${ANSI_VIO}${@}${ANSI_RST}"; }
echo_fail()   { echo -e "${ANSI_RED}${@}${ANSI_RST}"; }

echo_note "Making backup of /etc/fstab in /etc/fstab.backup for recovery purposes, in case something goes wrong"
sleep 2
#exit 0

#cp /etc/fstab /etc/fstab.backup

mounted_partitions() {
    df | grep -e "/dev/sd" -e "/dev/hd" -e "/dev/vd" -e "/dev/nvme" -e "/dev/mmc" | awk '{ print $1 }'
}

all_partitions() {
   blkid | grep -e "/dev/sd" -e "/dev/hd" -e "/dev/vd" -e "/dev/nvme" -e "/dev/mmc" | awk '{ print $1 }'
}
partition_info() {
    blkid | grep "/dev/*" | awk '{ print $1 $2 $3 $4 $5 }'
}
avail_disks() {
    lsblk | grep disk | awk '{ print $1 }'
}

echo_debug "Available disks/devices: "
avail_disks
sleep 3

echo_debug "Currently mounted partitions: "
mounted_partitions
sleep 3

echo_debug "All partitions"
all_partitions
sleep 3

echo_debug "Partition information: "
partition_info
sleep 5

blkid | grep "/dev/*" | awk '{ print $2 }' > ${HOME}/newPartitionUUID.txt
sed -i 's/\"//g' ${HOME}/newPartitionUUID.txt
cat ${HOME}/newPartitionUUID.txt
sleep 2
NEWFSTAB=$(cat ${HOME}/newhomeUUID.txt)
echo $NEWFSTAB

#echo "$NEWFSTAB     /home    ext4    defaults   0  2" | tee -a /etc/fstab
