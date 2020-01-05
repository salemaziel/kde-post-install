#!/usr/bin/env bash

echo -e "Not Done Yet"
echo -e "Sorry."
exit 0

sudo apt update
sudo apt -y full-upgrade
#sudo reboot
sudo useradd -m -d /opt/node-red -s /bin/bash -r -U node-red
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install gcc g++ make nodejs -y



sudo -u node-red mkdir /opt/node-red/.npm-nodered
sudo -u node-red npm config set prefix /opt/node-red/.npm-nodered
sudo -u node-red echo 'export PATH="$HOME/.npm-node-red/bin:$PATH"' | sudo -u node-red tee -a /opt/node-red/.profile

cd /opt/node-red 
sudo -i -u node-red npm install -g npm 
sudo -i -u node-red npm install -g npm