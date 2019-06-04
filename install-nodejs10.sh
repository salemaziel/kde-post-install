#!/bin/bash

echo " ** Installing NodeJS 10 and npm node package manager ** "
sudo apt install gcc g++ make -y
cd ;
mkdir ~/.npm-global
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt update
sudo apt -y install nodejs
npm config set prefix '~/.npm-global'
source ~/.profile
npm install npm@latest -g
