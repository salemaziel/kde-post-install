#!/usr/bin/env bash

ANSI_RED=$'\033[1;31m'
ANSI_YEL=$'\033[1;33m'
ANSI_GRN=$'\033[1;32m'
ANSI_VIO=$'\033[1;35m'
ANSI_BLU=$'\033[1;36m'
ANSI_WHT=$'\033[1;37m'
ANSI_RST=$'\033[0m'

echo_cmd()    { echo -e "${ANSI_BLU}${@}${ANSI_RST}"; }
echo_info()   { echo -e "${ANSI_WHT}${@}${ANSI_RST}"; }
echo_note()   { echo -e "${ANSI_GRN}${@}${ANSI_RST}"; }
echo_prompt() { echo -e "${ANSI_WHT}${@}${ANSI_RST}"; }
echo_warn()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_debug()  { echo -e "${ANSI_VIO}${@}${ANSI_RST}"; }
echo_fail()   { echo -e "${ANSI_RED}${@}${ANSI_RST}"; }



echo_fail "NOT DONE YET"
echo_warn "Sorry."
exit 0
################################

if [ "$(whoami)" != 'root' ]; then
    echo $"Please run with sudo or as root"
        exit 1;
fi

echo -e  
cmd=(dialog --separate-output --checklist "What partition are you wanting to create? \n
\n
Default is to do nothing \n
Navigate with Arrow Keys \n
Select/Unselect with Spacebar. Hit Enter key When Finished To Continue. \n
ESC key/Cancel exits and continues without selecting any options" 22 76 16)
partition_options=(1 "/tmp partition" off
         2 "/home partition" off
         3 "/var partition" off
         4 "/usr/local partition" off
         5 "/opt partition" off
         6 "/boot partition (**DANGEROUS: MAKE SURE YOU KNOW WHAT YOU'RE DOING**)" off
         7 "Skip this, I need to do something else" off)
partition_choices=$("${cmd[@]}" "${partition_options[@]}" 2>&1 >/dev/tty)




read -p "Enter the Device to partition [e.g. sda, sdb, hda, hdb, nvme0n1, etc] \n
Enter idk if you dont know:  " this_device
case $this_device in
    idk) 
        echo -e "Ok, lets check what disks are available" && sleep 1
        fdisk -l



echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Partitioning and formatting disk     "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "

echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdb
mkfs.ext4 -F -O 64bit /dev/sdb1

sleep 2
echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Copying current home to new disk     "
echo  "   mounted on /mnt/home                 "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "
sleep 2

mkdir /mnt/harddrive
mount /dev/sda1 /mnt/harddrive
mount /dev/sdb3
rm -rf /media/ubuntu/home/*
rsync -aXS --info=progress2 --exclude='/*/.gvfs' /mnt/harddrive/old-home. /media/ubuntu/home/.


echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "  Checking that the copying worked...   "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "

diff -r /home /mnt/home -x ".gvfs/*"


echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Mounting to /home to allow manual    "
echo  "   check of new partition. Check /home, "
echo  "   it should look exactly the same.     "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "

mount /dev/sdb1 /home

echo  "                                        "
echo  "                                        "
echo  "                                        "
read -p "Does it look the same? " "looksame"
    case $looksame in
        Y) echo "Cool, continuing";;
        y) echo "Cool, continuing";;
        N) echo "Uh oh, exiting" && exit 1 ;;
        n) echo "Uh oh, exiting" && exit 1 ;;
    esac



echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Saving your new disks UUID in file   "
echo  "   ~/newhomeUUID.txt                    "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "


cp /etc/fstab /etc/fstab.backup

blkid | grep sdb1 | awk '{ print $2 }' > ${HOME}/newhomeUUID.txt
sed -i 's/\"//g' ${HOME}/newhomeUUID.txt

NEWFSTAB=$(cat ${HOME}/newhomeUUID.txt)
echo "$NEWFSTAB     /home    ext4    defaults   0  2" | tee -a /etc/fstab

sudo chown -R $USER:$USER /mnt/home/$USER

echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Your /etc/fstab is updated.          "
echo  "                                        "
echo  "   Backup of /etc/fstab is saved at     "
echo  "   /etc/fstab.backup                    "
echo  "                                        "
echo  "   Unmounting /dev/sdb1                 "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "

umount /dev/sdb1

echo  "                                        "
echo  "                                        "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "   Take one last look around at         "
echo  "   your old Home, move it another       "
echo  "   directory if you'd like, or just     "
echo  "   delete it. Then Reboot, and you      "
echo  "   are done!                           "
echo  "                                        "
echo  "****************************************"
echo  "                                        "
echo  "                                        "
echo  "                                        "

exit 0
