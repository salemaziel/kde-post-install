#!/bin/bash


echo -e "Creating directory aptReinstalling in Home folder to save files into"
sleep 2
mkdir ~/aptReinstalling

dpkg --get-selections > ~/aptReinstalling/Package.list
echo -e "Saved list of installed packages in Package.list"
sleep 2

echo -e "Copying your /etc/apt/sources.list an sources.list.d/* to current directory"
sleep 2
sudo cp -R /etc/apt/sources.list* ~/aptReinstalling/

echo -e "exporting Repo gpg keys to Repo.keys"
sudo apt-key exportall > ~/aptReinstalling/Repo.keys
sleep 2

echo -e "You can safely ignore the warning about apt-key output"
sleep 2

echo -e "Done! Make sure to save this folder aptReinstalling so you can move it to your fresh installation to get back all your apt packages"

