#!/bin/bash

cd aptReinstalling

echo -e "Reimporting Repo.keys and copying source.list"
sleep 2
sudo DEBIAN_FRONTEND=noninteractive apt-key add Repo.keys
sudo cp -R ~/sources.list* /etc/apt/


echo -e "Running apt update and preparing to import your saved package list"
sleep 2
sudo apt update

sudo DEBIAN_FRONTEND=noninteractive apt-get install dselect -y

echo -e "updating dpkg's list of available packages to include your saved ones"
sleep 2
apt-cache dumpavail > ~/temp_avail
sudo dpkg --merge-avail ~/temp_avail
rm ~/temp_avail

echo -e "importing and installing saved package list"
sudo dpkg --set-selections < Package.list
sudo DEBIAN_FRONTEND=noninteractive apt-get dselect-upgrade -y
