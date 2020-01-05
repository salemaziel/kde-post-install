#!/usr/bin/env bash

if [[ -z $(which node) ]]; then
    echo " ** Installing NodeJS 10 and npm node package manager ** "
    cd ;
    mkdir ~/.npm-global
    curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
    sudo apt update
    sudo apt -y install nodejs
    npm config set prefix "$HOME/.npm-global"
    echo "export PATH=$HOME/.npm-global/bin:$PATH" | tee -a $HOME/.profile
    source ~/.profile
    npm install -g npm
fi

npm install -g npm
npm install -g nativefier

wget https://cdn.androidbeat.com/wp-content/uploads/2018/08/Android-messages.png -O messages.png

mv messages.png $HOME/.local/share/icons/messages.png

cd ;

nativefier -n "messages" -p linux -a x64 --counter --bounce -i $HOME/.local/share/icons/messages.png --honest --disable-dev-tools --single-instance --tray https://messages.google.com/web

sudo mv messages-linux-x64 /opt/messages-linux-x64
sudo chown -R root:root /opt/messages-linux-x64
sudo rm /usr/local/bin/messages
sudo ln -s /opt/messages-linux-x64/messages /usr/local/bin/messages

echo "[Desktop Entry]
Name=AndroidMessages
Exec='/usr/local/bin/messages' %U
Terminal=false
Icon=/home/$USER/Pictures/messages.png
Type=Application
Categories=Internet;Utilities;
StartupNotify=false" | sudo tee /usr/share/applications/android-messages.desktop

sudo chmod ugo+r /usr/share/applications/android-messages.desktop

echo " ***************************************************** "
echo "                                                       "
echo "      Android Messages is installed; look for it       "
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
