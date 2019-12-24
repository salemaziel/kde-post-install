#!/bin/bash

if [ -z $(which gdebi) ]; then
    echo " Please install gdebi to continue "
    exit 1;
fi


curl -s https://api.github.com/repos/sindresorhus/caprine/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O caprine.deb -qi -

sudo gdebi -n caprine.deb
