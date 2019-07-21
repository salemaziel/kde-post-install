#!/bin/bash

sudo apt update
sudo apt -y full-upgrade


##apt packages to install


sudo apt install libqtdee3 python-pyside2.qtquick python3-pyside2.qtquick python-pyside2.qtquickwidgets python-pyside2.qtquick python3-pyside2.qtquickwidgets mkalias magic-wormhole tlp tlp-rdw kubuntu-restricted-extras gufw eog eog-plugins eog-plugins-common uget rsync dialog curl ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi ksystemlog mpv wipe gparted kio-gdrive kaccounts-integration plasma-widgets-addons lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount curl openvpn network-manager-openvpn tar gimp libreoffice fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils fuse fuseiso gawk gnupg gnupg2 htop isomd5sum kde-runtime mlocate net-tools poppler-utils procps psmisc pv sed tar unrar util-linux wget xdg-utils xterm zip lastpass-cli ecryptfs-utils overlayroot whois wikipedia2text magic-wormhole secure-delete debsigs debsums debhelper atop filezilla kvpnc linssid lsat mat moreutils ndiff ngrep nicstat nictools-pci nield openclipart-png procinfo git rusers traceroute whereami cmake krename localepurge skrooge gimp skrooge makejail psad hwinfo progress dolphin-plugins powertop xdiagnose health-check converseen imgp mplayer vlc clamav clamav-base clamav-daemon clamav-docs clamav-freshclam clamdscan clamfs clamtk ffmpeg redshift plasma-applet-redshift-control apt-listchanges debian-goodies debsecan debsums libpam-passwdqc gufw ffmpeg nikto mumble eog eog-plugins apparmor apparmor-utils apparmor-profiles apparmor-profiles-extra apt-transport-https p7zip-full gparted gnome-disk-utility plasma-widgets-addons wget curl dialog python python3 python3-pip git mumble redshift plasma-applet-redshift-control eog eog-plugins eog-plugins-common filelight mkalias netdiscover net-tools netcat unzip tar ddgr kolourpaint mtpaint qml-module-org-kde-kaccounts dialog netdiscover kde-config-systemd acpi tilix inkscape inkscape-open-symbols inkscape inkscape-open-symbols thunderbird inkscape inkscape-open-symbols build-essential libkf5config-dev libkdecorations2-dev libqt5x11extras5-dev qtdeclarative5-dev libkf5guiaddons-dev libkf5configwidgets-dev libkf5windowsystem-dev libkf5coreaddons-dev gettext apt-transport-https bash-completion unrar tar unzip kaccounts-integration latte-dock kio-gdrive kaccounts-integration clamav clamtk clamav-freshclam clamav-unofficial-sigs plasma-applet-redshift-control redshift netsniff-ng kwrite mousepad latte-dock kwrite netsniff-ng mesa-utils wmctrl curl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl mkalias libqtwebkit-qmlwebkitplugin libqt5webview5 qml qml-module-org-kde-charts qml-module-org-kde-okular qml-module-qtgstreamer qml-module-qtquick-extras qml-module-qtquick-shapes dialog openresolv tlp tlp-rdw kubuntu-restricted-extras plasma-widgets-addons chromium-browser netsniff-ng gufw eog eog-plugins eog-plugins-common kio-gdrive rsync uget mesa-utils wmctrl wget curl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl libappindicator1 -y

sleep 2

echo "                                                       "
echo "                                                       "
echo " ***************************************************** "
echo "                                                       "
read -p "Were there errors? (WARNING: THE REST OF THE SCRIPT WILL NOT WORK IF THERE WERE ERRORS. ANSWER ACCURATELY)?[y/n] " errors_answer
if test $errors_answer == "y"; then
    echo " ** Quitting, fix errors before running the rest of the script.  ** "
    exit 1
else
    echo " Cool, continuing "
fi

#sudo apt purge exim4 avahi-autoipd avahi-daemon cups cups-browsed unattended-upgrades cryptsetup-initramfs -y


## install repos and their keys and their programs


echo " ***********installing etcher******** "
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt update
sudo apt install balena-etcher-electron -y



echo " ******* installing youtube-dl ********** "
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl


echo " ***********installing Nixnote2 (linux interface for evernote) ******** "
sudo add-apt-repository ppa:nixnote/nixnote2-stable -y
sudo apt update
sudo apt -y install nixnote2



echo " ***********installing Inxi (System/Hardware Identifier) ******** "
wget -O inxi https://github.com/smxi/inxi/raw/master/inxi
chmod +x inxi 
sudo mv inxi /usr/local/bin/inxi


cd ;

echo " ****** installing protonvpn ******* "
wget "https://github.com/ProtonVPN/protonvpn-cli/raw/master/protonvpn-cli.sh" -O "protonvpn-cli.sh" && sudo bash protonvpn-cli.sh --install
#echo " *** protonvpn openvpn username: code_vpn *** "
#sleep 2
#echo " *** text salem or login to protonvpn account in browser for protonvpn/openvpn password *** #"
#sleep 3
#echo " *** choose n for custom dns, y for downgrading openvpn privileges, and choose 4) visionary #plan when it tells you to choose which plan you have. The code doesnt actually check which plan #you have lol *** "
#sleep 3
#./protonvpn-cli.sh --init

#echo " *** making a few custom aliases for using protonvpn; adding sudo to alias, so you dont have #to type it out, just type pvpn and the letter string argument *** "
#mkalias new pvpn "sudo pvpn"

#echo " *** new custom alias pvpn-rcf = reconnect to fastest. Disconnects you from proton, then reconnects to current fastest available" 
#mkalias new pvpn-rcf "pvpn -d && pvpn -f"
#sleep 2

#echo " *** new custom alias pvpn-rcf = reconnect to fastest. Disconnects you from proton, then #reconnects to current fastest available" 
#mkalias new pvpn-m "pvpn -d && pvpn -m"
#sleep 2

#echo " ** making a text file in your Home folder with all protonvpn commands including the custom #ones just made ** "
#touch ~/protonvpn-commands.txt

#echo "
#Usage: protonvpn-cli.sh [option]
#OR
#pvpn [option]

#custom:
#pvpn = sudo pvpn
#pvpn-rcf = disconnect from current protonvpn server and reconnect to fastest
#pvpn-m = disconnect from current protonvpn server, and bring up a menu to select your server 


#Standard Options:
#   --init                              Initialize ProtonVPN profile on the machine.
#   -c, --connect                       Select and connect to a ProtonVPN server.
#   -c [server-name] [protocol]         Connect to a ProtonVPN server by name.
#   -m, --menu                          Select and connect to a ProtonVPN server from a menu.
#   -r, --random-connect                Connect to a random ProtonVPN server.
#   -l, --last-connect                  Connect to the previously used ProtonVPN server.
#   -f, --fastest-connect               Connect to the fastest available ProtonVPN server.
#   -p2p, --p2p-connect                 Connect to the fastest available P2P ProtonVPN server.
#   -tor, --tor-connect                 Connect to the fastest available ProtonVPN TOR server.
#   -sc, --secure-core-connect          Connect to the fastest available ProtonVPN SecureCore #server.
#   -cc, --country-connect              Select and connect to a ProtonVPN server by country.
#   -cc [country-name] [protocol]       Connect to the fastest available server in a specific #country.
#   -d, --disconnect                    Disconnect the current session.
#   --reconnect                         Reconnect to the current ProtonVPN server.
#   --ip                                Print the current public IP address.
#   --status                            Print connection status.
#   --update                            Update protonvpn-cli.
#   --install                           Install protonvpn-cli.
#   --uninstall                         Uninstall protonvpn-cli.
#   -v, --version                       Display version.
#   -h, --help                          Show this help message. " >> ~/protonvpn-commands.txt
#
   
cp -r ~/kde-post-install/icons ~/Pictures/icons   
   
echo " *** installing signal messenger for desktop *** "
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt install signal-desktop -y



echo " *** installing spotify *** "
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y


if [ -z $(which gdebi) ]; then
    echo " Please install gdebi to continue "
    exit 1;
fi


echo " *** installing caprine:fb messenger for linux *** "
cd ~/Documents/Zips
curl -s https://api.github.com/repos/sindresorhus/caprine/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O caprine.deb -qi -
sudo gdebi -n caprine.deb



echo " *** installing teamviewer for linux *** "
cd ~/Documents/Zips
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo gdebi -n teamviewer_amd64.deb


#echo " *** installing pulse-sms *** "
#cd ~/Documents/Zips ;
#wget https://github.com/klinker-apps/messenger-desktop/releases/download/v3.4.3/pulse-sms-3.4.3-amd64.deb
#sudo gdebi -n pulse-sms*.deb


echo " *** installing google chrome *** "
cd ~/Documents/Zips ;
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable*.deb


echo " *** installing protonmail desktop:unofficial *** "
cd ~/Documents/Zips ;
wget https://github.com/protonmail-desktop/application/releases/download/v1.0.2/protonmail-desktop-unofficial_1.0.2_amd64.deb
sudo gdebi -n protonmail-desktop-unofficial*.deb


echo " *** installing slack *** "
cd ~/Documents/Zips ;
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb
sudo gdebi -n slack-desktop*.deb


echo " *** installing virtualbox *** "
cd ~/Documents/Zips ;
wget https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_amd64.deb
wget https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack
sudo gdebi -n virtualbox*.deb

echo " *** installing vivaldi *** "
cd ~/Documents/Zips ;
wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.5.1525.48-1_amd64.deb
sudo gdebi -n vivaldi-stable*.deb

echo " *** installing zoom *** "
cd ~/Documents/Zips ;
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo gdebi -n zoom_amd64.deb


echo " ** Installing Brave Browser ** "
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc |  sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ disco main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-disco.list
sudo apt update
sudo apt -y install brave-browser brave-keyring


echo " *** downloading and installing Basecamp: Unofficial app for Linux *** "
curl -s https://api.github.com/repos/arturock/basecamp-linux/releases/latest \
| grep "browser_download_url.*x64.tar.xz" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O basecamp-linux-x64.tar.xz -qi -

tar -xzvf basecamp-linux-x64.tar.xz
sudo mv basecamp-linux-x64 /opt/basecamp-linux-x64
sudo chown -R root:root /opt/basecamp-linux-x64
sudo find /opt/basecamp-linux-x64 -type d -exec chmod 755 {} \;
sudo find /opt/basecamp-linux-x64 -type f -exec chmod 644 {} \;
sudo chmod +x /opt/basecamp-linux-x64/basecamp
sudo chmod +x /opt/basecamp-linux-x64/libnode.so
sudo chmod +x /opt/basecamp-linux-x64/libffmpeg.so
sudo rm /usr/local/bin/basecamp
sudo ln -s /opt/basecamp-linux-x64/basecamp /usr/local/bin/basecamp
mv ~/kde-post-install/icons/basecamp.png ~/Pictures/icons/basecamp.png
echo "[Desktop Entry]
Name=Basecamp
Exec="/usr/local/bin/basecamp" %U
Terminal=false
Icon=/home/pc/Pictures/icons/basecamp.png
Type=Application
Categories=Internet;Project Management;Utilities
StartupNotify=false" | sudo tee /usr/share/applications/basecamp.desktop




#echo " ** Basecamp is installed. Find it in the application menu or run it from the terminal with #the command: basecamp ** "p



echo " ** installing Google Cloud Platform SDK commandline tools ** "
cd ; export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" 
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update
sudo apt install google-cloud-sdk
gcloud components update


## install nodeJS 10
echo " ** Installing NodeJS 10 and npm node package manager ** "
cd ;
sudo apt install gcc g++ make -y
mkdir ~/.npm-global
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt update
sudo apt -y install nodejs
npm config set prefix '~/.npm-global'
source ~/.profile
npm install -g npm
echo "if [ -d "$HOME/.npm-global/bin" ] ; then
    PATH="$HOME/.npm-global/bin:$PATH"
fi" >> ~/.profile
source ~/.profile
npm install -g nativefier
npm install -g gatsby-cli



#echo " *** Installing from Zips folder ** "

#sudo chown -R $USER:$USER ~/Documents/Zips

#cd ~/Documents/Zips
#sudo gdebi -n bleachbit_2.2_all_ubuntu1810.deb
#sudo gdebi -n caprine_2.30.2_amd64.deb
#sudo gdebi -n discord-0.0.9.deb
#sudo gdebi -n encryptr_2.0.0-1_amd64.deb
#sudo gdebi -n firejail-apparmor_0.9.56-LTS_1_amd64.deb
#sudo gdebi -n firetools_0.9.52_1_amd64.deb
#sudo gdebi -n google-chrome-stable_current_amd64.deb
#sudo gdebi -n protonmail-desktop_0.5.9_amd64.deb
#sudo gdebi -n pulse-sms-3.1.4-amd64.deb
#sudo gdebi -n slack-desktop-3.3.7-amd64.deb
#sudo gdebi -n stacer_1.0.9_amd64.deb
#sudo gdebi -n upwork_5.1.0.647_amd64.deb
#sudo gdebi -n virtualbox-6.0_6.0.6-130049~Ubuntu~bionic_amd64.deb
#sudo gdebi -n vivaldi-stable_2.3.1440.60-1_amd64.deb
#sudo gdebi -n youtube-music-desktop_0.2.1_amd64.deb
#sudo gdebi -n zoom_amd64.deb

sudo apt update
sudo apt -y full-upgrade




#Fixing Tilix
echo "if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi >> ~/.bashrc

sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh



echo " ** Hardening (K)Ubuntu security a bit with apparmor ** "
sudo mkdir -p /etc/default/grub.d
echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT apparmor=1 security=apparmor"'  | sudo tee /etc/default/grub.d/apparmor.cfg
sudo update-grub
cd ;
#sudo aa-enforce firejail-default



read -p "Install all the latest from the Kubuntu repository?[y/n] " answer_kubuntuppa
if test $answer_kubuntuppa == "y" ; then
    echo " ** installing kubuntu repository/ppa ** "
    sudo add-apt-repository ppa:kubuntu-ppa/ppa
    sudo apt update
    sudo apt -y full-upgrade
fi

read -p "Install all the latest KDE stuff from the Kubuntu/KDE backports repository (this could take 10-30 mins depending on internet connection)[y/n]? " answer_backports
if test $answer_backports == "y"; then
    echo " ** installing kubuntu backports ppa ** "
    sudo add-apt-repository ppa:kubuntu-ppa/backports
    sudo apt update
    sudo apt -y full-upgrade
fi


echo " ** All done. Please reboot the computer ** "







# wget https://github.com/sindresorhus/caprine/releases/download/v2.31.0/caprine_2.31.0_amd64.deb
#sudo gdebi -n caprine_2.31.0_amd64.debhelper

#wget https://github.com/arturock/basecamp-linux/releases/download/v0.1.2/basecamp-0.1.2-linux-x64.tar.xz
#tar -xzvf basecamp-0.1.2-linux-x64.tar.xz
#sudo mv basecamp-linux-x64 /opt/basecamp-linux-x64
#sudo chown -R root:root /opt/basecamp-linux-x64
#sudo find /opt/basecamp-linux-x64 -type d -exec chmod 755 {} \;
#sudo find /opt/basecamp-linux-x64 -type f -exec chmod 644 {} \;
#sudo chmod +x /opt/basecamp-linux-x64/libffmpeg.so
#sudo chmod +x /opt/basecamp-linux-x64/libnode.so
#sudo chmod +x /opt/basecamp-linux-x64/basecamp
#sudo ln -s /opt/basecamp-linux-64/basecamp /usr/local/bin/basecamp





## Git packages to install

# git clone https://github.com/CISOfy/Lynis










# sudo sh -c "echo 'deb https://riot.im/packages/debian/ bionic main' >  etc/apt/sources.list.d/matrix-riot-im.list"

# curl -L https://riot.im/packages/debian/repo-key.asc | sudo apt-key add -

# sudo apt-get update && sudo apt-get -y install riot-web





## Gcloud cloud_sql_proxy
# wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O # cloud_sql_proxy

# chmod +x cloud_sql_proxy

# ./cloud_sql_proxy




##################### OTHERS, dont usually install but nice to have ##########

#echo " *** Installing Skype *** "
#wget https://go.skype.com/skypeforlinux-64.deb
#sudo gdebi -n skypeforlinux-64.deb





