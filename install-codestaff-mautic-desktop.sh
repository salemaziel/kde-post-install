#!/usr/bin/env bash

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
    source $HOME/.profile
    npm install npm -g
fi

npm install npm -g
npm install nativefier -g

mkdir $HOME/Pictures/icons

wget https://res-3.cloudinary.com/toolmuse/image/upload/production_1_mrt7qr -O mautic.png

mv mautic.png $HOME/Pictures/icons/mautic.png

cd ;

nativefier -n 'mautic-codestaff' -p linux -a x64 -i /home/$USER/Pictures/icons/mautic.png --single-instance --counter --bounce --tray "https://codestaff.xyz"

sudo mv mautic-codestaff-linux-x64 /opt/mautic-codestaff-linux-x64

sudo chown -R root:root /opt/mautic-codestaff-linux-x64
sudo rm /usr/local/bin/mautic-codestaff
sudo ln -s /opt/mautic-codestaff-linux-x64/mautic-codestaff /usr/local/bin/mautic-codestaff

echo "[Desktop Entry]
Name=Mautic-Codestaff
Exec='/usr/local/bin/mautic-codestaff' %U
Terminal=false
Icon=/home/$USER/Pictures/icons/mautic.png
Type=Application
Categories=Internet;Utilities;
StartupNotify=false" | sudo tee /usr/share/applications/mautic-codestaff.desktop

sudo chmod ugo+r /usr/share/applications/mautic-codestaff.desktop

echo " ***************************************************** "
echo "                                                       "
echo "      Codestaff-Mautic Desktop is installed; look      "
echo "      look for it in your application menu. It may     "
echo "      be under the Lost&Found category.                "
echo "                                                       "
echo "                                                       "
echo "      You can fix this by right-clicking on the        "
echo "      application menu icon, clicking Edit             "
echo "      Applications and dragging it from under          "
echo "      Lost&Found to whichever category you prefer.      "
echo "                                                       "
echo " ***************************************************** "

sleep 5
exit 0

