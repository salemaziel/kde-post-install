#!/bin/bash

if [[ -z $(ls /etc/os-release) ]]; then
    echo -e "Sorry, this only works on Ubuntu"
    sleep 1
    exit 0
fi

if [[ -z $(which wg) ]]; then
	source /etc/os-release
	UB_VERSION=$(echo VERSION | awk '{ print $1 }' )

	case $UB_VERSION in
		'19.10')
            		echo -e "Installing Wireguard"
                		;;
			*)
            		echo -e "Installing Wireguard PPA"
            		sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:wireguard/wireguard
                		;;
	esac
else
	echo -e "Installing Wireguard"
fi

sudo apt update

if [[ -z $(which dialog) ]]; then
#    DIALOG="dialog"
    sudo apt install -y dialog
fi
if [[ -z $(which zenity) ]]; then
    sudo apt install -y zenity
fi

if [[ -z $(which wg) ]]; then
    sudo apt install -y wireguard 
fi

#WG_CONF=$(dialog --stdout --title "Please choose a file" --fselect $HOME/ 22 76 16)
WG_CONF=$(zenity --file-selection)

#clear

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