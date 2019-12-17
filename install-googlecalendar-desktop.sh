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
    npm install npm -g
fi

npm install npm -g
npm install nativefier -g

mkdir $HOME/Pictures/icons

wget https://brandslogo.net/wp-content/uploads/2017/03/Google-Calendar-icon.png -O google-calendar.png

mv google-calendar.png $HOME/Pictures/icons/google-calendar.png

cd ;

nativefier -n 'google-calendar' -p linux -a x64 -i /home/$USER/Pictures/icons/google-calendar.png --single-instance --honest --counter --bounce --disable-dev-tools --tray "https://www.google.com/calendar"

sudo mv google-calendar-linux-x64 /opt/google-calendar-linux-x64

sudo chown -R root:root /opt/google-calendar-linux-x64
sudo rm /usr/local/bin/google-calendar
sudo ln -s /opt/google-calendar-linux-x64/google-calendar /usr/local/bin/google-calendar

echo "[Desktop Entry]
Name=GoogleCalendar
Exec='/usr/local/bin/google-calendar' %U
Terminal=false
Icon=/home/$USER/Pictures/icons/google-calendar.png
Type=Application
Categories=Internet;Utilities;
StartupNotify=false" | sudo tee /usr/share/applications/google-calendar.desktop

sudo chmod ugo+r /usr/share/applications/google-calendar.desktop

echo " ***************************************************** "
echo "                                                       "
echo "      Google Calendar is installed; look for it        "
echo "      in your application menu. It may be under        "
echo "      the Lost&Found category.                         "
echo "                                                       "
echo "      You can fix this by right-clicking on the        "
echo "      application menu icon, clicking Edit             "
echo "      Applications and dragging it from under          "
echo "      Lost&Found to whichever category you prefer      "
echo "                                                       "
echo " ***************************************************** "

sleep 5
exit 0
