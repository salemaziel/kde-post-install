#!/bin/bash
if [[ -z $(which wget) ]]; then
    sudo apt install wget -y
fi

if [[ -z $(ls -al $HOME/.local/bin) ]]; then
    mkdir -p $HOME/.local/bin
fi

wget https://github.com/GitSquared/edex-ui/releases/download/v2.2.2/eDEX-UI.Linux.x86_64.AppImage

chmod +x eDEX-UI.Linux.x86_64.AppImage

mv eDEX-UI.Linux.x86_64.AppImage $HOME/.local/bin/eDEX-UI.Linux.x86_64.AppImage
sudo ln -s /home/$USER/.local/bin/eDEX-UI.Linux.x86_64.AppImage /usr/local/bin/eDEX-UI.Linux.x86_64.AppImage

