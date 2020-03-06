#!/bin/bash
 
 sudo dpkg --add-architecture i386
 if [[ -z $(which wget) ]]; then
    if [[ -z $(which curl) ]]; then
        echo "Failed to download package. Install curl or wget"
        sleep 2
        exit 1
    fi
    curl -L https://dl.winehq.org/wine-builds/winehq.key -o winehq.key
    else
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
fi

sudo DEBIAN_FRONTEND=noninteractive apt-key add winehq.key

source /etc/os-release

case $VERSION_ID in
    "19.10")
            sudo DEBIAN_FRONTEND=noninteractive apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main'
                ;;
    "19.04")
            sudo DEBIAN_FRONTEND=noninteractive apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
                ;;
    "18.10")
            sudo DEBIAN_FRONTEND=noninteractive apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
                ;;
    "18.04")
            sudo DEBIAN_FRONTEND=noninteractive apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
                ;;
          *)
            echo -e "This only works on Ubuntu and Mint. This script only checks for Ubuntu. If you're using Mint, run the script to add the bionic repo manually"
            exit     
                ;;
esac

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install --install-recommends wine-stable winehq-stable wine-stable-i386 libasound2-plugins:i386
