#!/bin/bash

echo " ******* installing youtube-dl ********** "
sudo apt purge youtube-dl -y
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
youtube-dl -U
