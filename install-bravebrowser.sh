#!/bin/bash


echo " ** Installing Brave Browser ** "
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc |  sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ disco main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-disco.list
sudo apt update
sudo apt -y install brave-browser brave-keyring
