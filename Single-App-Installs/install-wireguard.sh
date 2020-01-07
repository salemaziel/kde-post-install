#!/bin/bash

echo -e "If you're on a version of Ubuntu lower than 19.10, this will fail"
sleep 1

sudo apt update

if [[ -z $(which dialog) ]]; then
    sudo apt install -y dialog
fi
if [[ -z $(which wireguard) ]]; then
    sudo apt install -y wireguard openresolv
fi

WG_CONF=$(dialog --stdout --title "Please choose a file" --fselect $HOME/ 22 76 16)
clear

sudo install -o root -g root -m 600 $WG_CONF /etc/wireguard/wg0.conf

sudo systemctl start wg-quick@wg0
sleep 2

sudo systemctl status wg-quick@wg0
sleep 1

sudo wg
sleep 1

curl https://ipv4.icanhazip.com

sudo systemctl enable wg-quick@wg0

echo 'alias wgstart="sudo systemctl start wg-quick@wg0"
alias wgstop="sudo systemctl stop wg-quick@wg0"
alias wgstatus="sudo systemctl status wg-quick@wg0"
alias wgcheck="sudo wg"' | tee -a $HOME/.bash_aliases

source $HOME/.bashrc

echo -e "Your Wireguard connection is installed, and bash aliases have been added for quick usage"
sleep 1
cat $HOME/.bash_aliases