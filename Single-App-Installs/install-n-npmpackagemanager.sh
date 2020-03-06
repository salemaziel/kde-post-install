#!/bin/bash

if [[ -z $(which node) ]]; then
    echo " ** Installing NodeJS 10 and npm node package manager ** "
    cd ;
    mkdir $HOME/.npm-global
    curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
    sudo apt update
    sudo apt -y install nodejs
    npm config set prefix "$HOME/.npm-global"
    echo "export PATH=$HOME/.npm-global/bin:$PATH" | tee -a $HOME/.profile
    source $HOME/.profile
    npm install -g npm
fi

N_PREFIX=$HOME/.npm-global
npm install -g n

echo "export N_PREFIX=$HOME/.npm-global | tee -a $HOME/.profile
source $HOME/.profile

n lts
