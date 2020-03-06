#!/usr/bin/env bash

echo -e "Not Done Yet"
echo -e "Sorry."
exit 0


echo -e "This script can setup a domain name with ssl certificate from lets encrypt"
echo -e "If you don't want to set this up, or will be setting it up manually yourself later, enter none or skip"
echo -e "You can also skip this if you're running this locally on your own computer"
sleep 2
echo -e "Do you want to setup domain name with an SSL cert automatically? [y/n] " want_domain
case $want_domain in
    Y)

sleep 1
echo -e "You should have the DNS already setup before running this, with an A record pointing at this server's ip address"
sleep 1
echo -e "If you don't want to set this up, or will be setting it up manually yourself later, enter none or skip"
sleep 1
echo -e "You can also skip this if you're running this locally on your own computer"
sleep 1
read -p "Domain:  " da_domain

sudo apt update
sudo apt -y full-upgrade
#sudo reboot
sudo useradd -m -d /opt/node-red -s /bin/bash -r -U node-red
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install gcc g++ make nodejs certbot -y

bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

sudo -u node-red mkdir /opt/node-red/.npm-nodered
sudo -u node-red npm config set prefix /opt/node-red/.npm-nodered
sudo -u node-red echo 'export PATH="$HOME/.npm-node-red/bin:$PATH"' | sudo -u node-red tee -a /opt/node-red/.profile

cd /opt/node-red 
sudo -i -u node-red npm install -g npm 
sudo -i -u node-red npm install -g npm
echo '# systemd service file to start Node-RED

[Unit]
Description=Node-RED graphical event wiring tool
Wants=network.target
Documentation=http://nodered.org/docs/hardware/raspberrypi.html

[Service]
Type=simple
# Run as normal pi user - change to the user name you wish to run Node-RED as
User=node-red
Group=node-red
WorkingDirectory=/opt/node-red

Nice=5
Environment="NODE_OPTIONS=--max_old_space_size=256"
# uncomment and edit next line if you need an http proxy
#Environment="HTTP_PROXY=my.httpproxy.server.address"
# uncomment the next line for a more verbose log output
#Environment="NODE_RED_OPTIONS=-v"
#ExecStart=/usr/bin/env node $NODE_OPTIONS red.js $NODE_RED_OPTIONS
ExecStart=/usr/bin/env node-red-pi $NODE_OPTIONS $NODE_RED_OPTIONS
# Use SIGINT to stop
KillSignal=SIGINT
# Auto restart on crash
Restart=on-failure
# Tag things in the log
SyslogIdentifier=Node-RED
#StandardOutput=syslog

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/nodered.service
sudo curl -sL -o /usr/bin/node-red-start https://raw.githubusercontent.com/node-red/linux-installers/master/resources/node-red-start
sudo curl -sL -o /usr/bin/node-red-stop https://raw.githubusercontent.com/node-red/linux-installers/master/resources/node-red-stop
sudo curl -sL -o /usr/bin/node-red-restart https://raw.githubusercontent.com/node-red/linux-installers/master/resources/node-red-restart
sudo curl -sL -o /usr/bin/node-red-reload https://raw.githubusercontent.com/node-red/linux-installers/master/resources/node-red-reload
sudo curl -sL -o /usr/bin/node-red-log https://raw.githubusercontent.com/node-red/linux-installers/master/resources/node-red-log
sudo curl -sL -o /etc/logrotate.d/nodered https://raw.githubusercontent.com/node-red/linux-installers/master/resources/nodered.rotate

sudo systemctl daemon-reload
sudo systemctl start nodered
systemctl status nodered

case $da_domain in
cd /opt/node-red/
sudo certbot certonly --standalone -d
sudo certbot certonly --standalone -d 
nano /etc/letsencrypt/renewal-hooks/deploy/renewal_success
chmod u+x /etc/letsencrypt/renewal-hooks/deploy/renewal_success
ll /etc/letsencrypt/renewal-hooks/deploy/renewal_success
/etc/letsencrypt/renewal-hooks/deploy/./renewal_success
exit
crontab -e
