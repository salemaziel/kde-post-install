#!/bin/sh

echo -e " *** installing slack *** "
cd $HOME/Downloads ;
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.2.0-amd64.deb
sudo gdebi -n slack-desktop*.deb