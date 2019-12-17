#!/usr/bin/env bash

if [[ -z $(which node) ]]; then
    echo " ** Installing NodeJS 10 and npm node package manager ** "
    cd ;
    mkdir ~/.npm-global
    curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
    sudo apt update
    sudo apt -y install nodejs
    npm config set prefix "$HOME/.npm-global"
    echo "if [[ -d '$HOME/.npm-global/bin' ]] ; then
        PATH='$HOME/.npm-global/bin:$PATH'
    fi" >> "$HOME/.profile"
    source ~/.profile
    npm install -g npm
fi

npm install -g npm
npm install -g nativefier

#wget -O googlevoice.png

#mv messages.png $HOME/Pictures/icons/googlevoice.png

cd ;

nativefier -n "googlevoice" -p linux -a x64 --counter --bounce -i ~/Pictures/icons/googlevoice.png --honest --disable-dev-tools --single-instance --tray "https://voice.google.com/signup"

sudo mv googlevoice-linux-x64 /opt/googlevoice-linux-x64
sudo chown -R root:root /opt/googlevoice-linux-x64
sudo rm /usr/local/bin/googlevoice
sudo ln -s /opt/googlevoice-linux-x64/googlevoice /usr/local/bin/googlevoice

echo "[Desktop Entry]
Name=Google Voice
Exec='/usr/local/bin/googlevoice' %U
Terminal=false
Icon=/home/$USER/Pictures/icons/googlevoice.png
Type=Application
Categories=Internet;Utilities;
StartupNotify=false" | sudo tee /usr/share/applications/googlevoice.desktop

sudo chmod ugo+r /usr/share/applications/googlevoice.desktop

echo " ***************************************************** "
echo "                                                       "
echo "      GoogleVoice Desktop is installed; look for it    "
echo "      in your application menu. It may be under        "
echo "      the Lost&Found category.                         "
echo "                                                       "
echo "      You can fix this by right-clicking on the        "
echo "      application menu icon, clicking Edit             "
echo "      Applications and dragging it from under          "
echo "      Lost&Found to whichever category you prefer      "
echo "             (APPLIES TO KDE DESKTOP)                  "
echo " ***************************************************** "

sleep 5
exit 0
