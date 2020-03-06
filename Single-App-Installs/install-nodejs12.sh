#!/bin/bash

echo " ** Installing NodeJS 10 and npm node package manager ** "
sudo apt install gcc g++ make -y
mkdir ~/.npm-global
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt update
sudo apt install -y nodejs
npm config set prefix "$HOME/.npm-global"
echo "export PATH=$HOME/.npm-global/bin:$PATH" | tee -a $HOME/.profile
source $HOME/.profile
npm install npm@latest -g

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
