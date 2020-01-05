#!/bin/bash

echo " *** downloading Basecamp: Unofficial app for Linux *** "
curl -s https://api.github.com/repos/arturock/basecamp-linux/releases/latest \
| grep "browser_download_url.*x64.tar.xz" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O basecamp-linux-x64.tar.xz -qi -

echo " ** Installing Basecamp ** "
tar -xzvf basecamp-linux-x64.tar.xz
sudo mv basecamp-linux-x64n /opt/basecamp-linux-x64
sudo chown -R root:root /opt/basecamp-linux-x64
sudo find /opt/basecamp-linux-x64 -type d -exec chmod 755 {} \;
sudo find /opt/basecamp-linux-x64 -type f -exec chmod 644 {} \;
sudo chmod +x /opt/basecamp-linux-x64/basecamp
sudo chmod +x /opt/basecamp-linux-x64/libnode.so
sudo chmod +x /opt/basecamp-linux-x64/libffmpeg.so
sudo ln -s /opt/basecamp-linux-x64/basecamp /usr/local/bin/basecamp

echo " ** Basecamp is installed. Find it in the application menu or run it from the terminal with the command: basecamp ** "
