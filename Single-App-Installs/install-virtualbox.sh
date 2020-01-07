#!/bin/sh
echo " ******* installing virtualbox 6.1.0 ********** "

cd $HOME/Downloads ;
wget https://download.virtualbox.org/virtualbox/6.1.0/virtualbox-6.1_6.1.0-135406~Ubuntu~bionic_amd64.deb
wget https://download.virtualbox.org/virtualbox/6.1.0/Oracle_VM_VirtualBox_Extension_Pack-6.1.0.vbox-extpack
sudo gdebi -n virtualbox-6.1_6.1.0-135406~Ubuntu~bionic_amd64.deb
}