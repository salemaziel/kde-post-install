#!/bin/bash

dl_tails() {
    wget https://tails.boum.org/tails-signing.key
    gpg --import < tails-signing.key
    sudo apt install debian-keyring -y
    gpg --keyring=/usr/share/keyrings/debian-keyring.gpg --export zack@upsilon.cc | gpg --import
    gpg --keyid-format 0xlong --check-sigs A490D0F4D311A4153E2BB7CADBB802B258ACD84F | grep 'sig! 0x9C31503C6D866396 2015-02-03  Stefano Zacchiroli <zack@upsilon.cc>'
    read -p "Stefano Zacchiroli's sig! key found? [y/n]" stef_key
    case $stef_key in
        Y) 
            echo_note "Cool, Tails key is trusted. Continuing"
                ;;
        y)
            echo_note "Cool, Tails key is trusted. Continuing"
                ;;
        N)
            echo_warn "Tails key is untrusted. You may have downloaded a corrupted file, or a fake key provided by a malicious actor, or you may have a malicious actor on your network. Quitting."
            exit 1
                ;;
        n)
            echo_warn "Tails key is untrusted. You may have downloaded a corrupted file, or a fake key provided by a malicious actor, or you may have a malicious actor on your network. Quitting."
            exit 1
                ;;
    esac
    wget --continue http://dl.amnesia.boum.org/tails/stable/tails-amd64-4.1.1/tails-amd64-4.1.1.img
    wget https://tails.boum.org/torrents/files/tails-amd64-4.1.1.img.sig
    TZ=UTC gpg --no-options --keyid-format long --verify tails-amd64-4.1.1.img.sig tails-amd64-4.1.1.img | grep 'Good signature from "Tails developers <tails@boum.org>" [full]'
    read -p "Stefano Zacchiroli's sig! key found? [y/n]" stef_key
    case $stef_key in
        Y) 
            echo_note "Cool, Tails key is trusted. Continuing"
                ;;
        y)
            echo_note "Cool, Tails key is trusted. Continuing"
                ;;
        N)
            echo_warn "Tails key is untrusted. You may have downloaded a corrupted file, or a fake key provided by a malicious actor, or you may have a malicious actor on your network. Quitting."
            exit 1
                ;;
        n)
            echo_warn "Tails key is untrusted. You may have downloaded a corrupted file, or a fake key provided by a malicious actor, or you may have a malicious actor on your network. Quitting."
            exit 1
                ;;
    esac

    TZ=UTC gpg --no-options --keyid-format long --verify tails-amd64-4.1.1.img.sig tails-amd64-4.1.1.img | grep 'gpg: Good signature from "Tails developers <tails@boum.org>"'
    
    echo_info "downloading Tails USB installation page from Tails website to local html file"
    wget --no-netrc -p https://tails.boum.org/install/expert/usb/index.en.html
    wget --no-netrc -p https://tails.boum.org/install/expert/usb?back=1
}

install_tor() {
echo_info "Installing Tor"
source /etc/os-release
echo "deb https://deb.torproject.org/torproject.org $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/onions.list
sudo bash -c 'curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import'
sudo bash -c 'gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -'
sudo apt update
sudo apt install -y tor deb.torproject.org-keyring torsocks
}

install_micahs() {
echo_info " *** Installing Micah F Lee's repository from github.com/micahflee; includes Onionshare and Torbrowser-launcher"
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:micahflee/ppa --yes
sudo apt update
sudo apt install -y onionshare torbrowser-launcher
}


use_torsocks() {
    if [[ -z $(which torsocks) ]]; then
        read -p "Torsocks shell service is not available on this machine. Safe to download now? [y/n]" dl_now
        case $dl_now in
        y)
            read -p "Are you sure? [y/n] " are_sure
            case $are_sure in 
                y) 
                    echo -e "Ok, downloading from repository"
                    sudo apt update 
                    sudo apt -y install tor torsocks
                        ;;
                n)
                    echo -e "Quitting without downloading or starting Torsocks. Start over by running script again"
                    exit 0
                        ;;
            esac
                ;;
        n) 
            echo -e "Quitting without downloading or starting Torsocks. Start over by running script again"
            exit 0
                    ;;
        esac
    fi
    . torsocks on
    echo -e "This terminal shell is Torified. Everything network-wise done here will go through Tor Network. Does not affect other shells or programs"
    sleep 1
}



dl_gits() {
    echo -e "Downloading useful gits"
     if [[ -z $(which git) ]]; then
        sudo apt install git -y
    fi
    mkdir vpn-stuff
    cd vpn-stuff
    git clone https://github.com/trailofbits/algo.git
    mv algo algo-autovpn-installer
    git clone https://github.com/cbeuw/Cloak.git
    mv Cloak Cloak_pluggable-transport-hide-vpn-usage
    git clone https://github.com/HirbodBehnam/Shadowsocks-Cloak-Installer.git
    git clone https://github.com/angristan/openvpn-install
    git clone https://github.com/l-n-s/wireguard-install
    git clone https://github.com/txthinking/brook.git
    mv brook brook-vpn-client
    git clone https://github.com/HirbodBehnam/MTProtoProxyInstaller
    git clone https://github.com/BrainfuckSec/kalitorify
    git clone https://github.com/mirimir/vpnchains
    git clone https://github.com/TensorTom/VPN-Chain
    mv VPN-Chain TensorTom-VPN-Chain
    git clone https://github.com/unresolvedsymbol/VPN-Chain
}

show_menu1() {
command1=(dialog --separate-output --checklist "What do you want to do?" 22 76 16)
options1=(1 "Start Torsocks (tor shell service) and re-show this menu (for downloading thru Tor purposes)" off
         2 "Download Tor service for shell use (does NOT include Tor Browser)" off
         3 "Download Tor Browser and Tor service for shell use" off
         4 "Install MicahFLee's Repo for Onion Share and TorBrowser-Launcher" off
         5 "Download useful vpn-related gits" off
         6 "Download TailsOS: Amnesiatic Operating System" off)
choices1=$("${command1[@]}" "${options1[@]}" 2>&1 >/dev/tty)
clear
}

run_menu1() {
for choice1 in $choices1
    do
    case $choice1 in
        1)
            use_torsocks
            show_menu2
            run_menu2
            ;;
        2)
            use_torsocks
            ;;
        3)
            install_tor
            ;;
        4)
            install_micahs
            ;;
        5)
            dl_gits
            ;;
        6) 
            dl_tails
            ;;
    esac
done
}

show_menu2() {
command2=(dialog --separate-output --checklist "What do you want to do?" 22 76 16)
options2=(1 "Start Torsocks (tor shell service)" off
         2 "Download Tor Browser and Tor service for shell use" off
         3 "Install MicahFLee's Repo for Onion Share and TorBrowser-Launcher" off
         4 "Download useful vpn-related gits" off
         5 "Download TailsOS: Amnesiatic Operating System" off)
choices2=$("${command2[@]}" "${options2[@]}" 2>&1 >/dev/tty)
clear
}

run_menu2() {
for choice2 in $choices2
    do
    case $choice2 in
        1)
            use_torsocks
            ;;
        2)
            install_tor
            ;;
        3)
            install_micahs
            ;;
        4)
            dl_gits
            ;;
        5)
            dl_tails
            ;;
    esac
done
touch $PWD/.ran-menu2-true
echo "Usage file declaring menu2 was run. Should be auto-deleted, it is safe to delete if it was not" >> $PWD/.ran-menu2-true
}

########################### Start of script ###############
if [[ -z $(which dialog) ]]; then
    echo -e "Sorry, dialog is not installed on this machine. Download dialog first, or run these scripts manually if you need to be quiet"
    sleep 2
    read -p "Download dialog? [y/n] " dl_dialog
    case $dl_dialog in
        Y)
            echo -e "Downloading. Run this script again after its done"
            sleep 1
            sudo apt update && sudo apt install -y dialog
            exit 0
                ;;
        y)
            echo -e "Downloading. Run this script again after its done"
            sleep 1
            sudo apt update && sudo apt install -y dialog
            exit 0
                ;;
        N)
            echo -e "Ok. Run these scripts manually"
            sleep 1
            cat $PWD/privacy-setups.sh
            exit 0
                ;;
        n)
            echo -e "Ok. Run these scripts manually"
            sleep 1
            cat $PWD/privacy-setups.sh
            exit 0
                ;;
    esac
fi

show_menu1

if [[ -z $(ls | grep ".ran-menu2-true") ]]; then
    run_menu1
else
    rm -f .ran-menu2-true
    exit 0
fi