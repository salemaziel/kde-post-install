#!/usr/bin/env bash

if [ "$(whoami)" != 'root' ]; then
    echo $"Please run with sudo"
        exit 1;
fi

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
echo "SHOWING CURRENT AVAILABLE DISKS"
sleep 2
sudo fdisk -l
sleep 3

read -p "Enter the 3 letter id of the disk you want to format and partiton: [e.g. hda, hdb, sda, etc]  " which_disk
read -p "Are you SURE that's the right disk? This will irreversably wipe everything. Choose 'n' for no to show available disks and choose again [y/n]  " usure_disk
	case $usure_disk in
		Y) echo "Cool, continuing" ;;
		y) echo "Cool, continuing" ;;
		n) echo "Let's take another look" && sudo fdisk -l && sleep 3
			read -p "Enter the 3 letter id of the disk you want to format and partiton: [e.g. hda, sda, sdb, etc]  " try2_disk
		N) echo "Let's take another look" && sudo fdisk -l && sleep 3
                        read -p "Enter the 3 letter id of the disk you want to format a$





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
