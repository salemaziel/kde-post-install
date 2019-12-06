#!/bin/bash

ANSI_RED=$'\033[1;31m'
ANSI_YEL=$'\033[1;33m'
ANSI_GRN=$'\033[1;32m'
ANSI_VIO=$'\033[1;35m'
ANSI_BLU=$'\033[1;36m'
ANSI_WHT=$'\033[1;37m'
ANSI_RST=$'\033[0m'

echo_cmd()    { echo -e "${ANSI_BLU}${@}${ANSI_RST}"; }
echo_note()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_info()   { echo -e "${ANSI_GRN}${@}${ANSI_RST}"; }
echo_prompt() { echo -e "${ANSI_WHT}${@}${ANSI_RST}"; }
echo_warn()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_debug()  { echo -e "${ANSI_VIO}${@}${ANSI_RST}"; }
echo_fail()   { echo -e "${ANSI_RED}${@}${ANSI_RST}"; }



echo_info "Running updates first"

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt -y full-upgrade


##apt packages to install

echo_info "Installing a shitload of packages"

sudo DEBIAN_FRONTEND=noninteractive apt install magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw kubuntu-restricted-extras gufw eog eog-plugins eog-plugins-common uget rsync dialog curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi ksystemlog mpv wipe gparted kio-gdrive kaccounts-integration plasma-widgets-addons lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount curl openvpn network-manager-openvpn tar gimp libreoffice fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils fuse fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed tar unrar util-linux wget xdg-utils xterm zip lastpass-cli ecryptfs-utils overlayroot whois wikipedia2text magic-wormhole secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo git rusers traceroute whereami cmake krename localepurge skrooge gimp skrooge makejail psad hwinfo progress dolphin-plugins powertop xdiagnose health-check converseen imgp mplayer vlc clamav clamav-base clamav-daemon clamav-docs clamav-freshclam clamdscan clamtk ffmpeg redshift plasma-applet-redshift-control apt-listchanges debian-goodies debsecan debsums libpam-passwdqc gufw ffmpeg nikto mumble eog eog-plugins apparmor apparmor-utils apparmor-profiles apparmor-profiles-extra apt-transport-https p7zip-full gparted gnome-disk-utility plasma-widgets-addons wget curl dialog python python3 python3-pip git mumble redshift plasma-applet-redshift-control eog eog-plugins eog-plugins-common filelight netdiscover net-tools netcat unzip tar ddgr kolourpaint mtpaint qml-module-org-kde-kaccounts dialog netdiscover kde-config-systemd acpi tilix inkscape inkscape-open-symbols inkscape inkscape-open-symbols thunderbird inkscape inkscape-open-symbols build-essential libkf5config-dev libkdecorations2-dev libqt5x11extras5-dev qtdeclarative5-dev libkf5guiaddons-dev libkf5configwidgets-dev libkf5windowsystem-dev libkf5coreaddons-dev gettext apt-transport-https bash-completion unrar tar unzip kaccounts-integration latte-dock kio-gdrive kaccounts-integration clamav clamtk clamav-freshclam clamav-unofficial-sigs plasma-applet-redshift-control redshift netsniff-ng kwrite mousepad latte-dock kwrite netsniff-ng mesa-utils wmctrl curl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl mkalias libqtwebkit-qmlwebkitplugin libqt5webview5 qml qml-module-org-kde-charts qml-module-org-kde-okular qml-module-qtgstreamer qml-module-qtquick-extras qml-module-qtquick-shapes dialog openresolv tlp tlp-rdw kubuntu-restricted-extras plasma-widgets-addons chromium-browser netsniff-ng gufw eog eog-plugins eog-plugins-common kio-gdrive rsync uget mesa-utils wmctrl wget curl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl -y

sleep 2

read -p "${ANSI_WHT}Were there errors? ${ANSI_RST} ${ANSI_RED}(WARNING: THE REST OF THE SCRIPT WILL NOT WORK IF THERE WERE ERRORS. ANSWER ACCURATELY!) [y/n]${ANSI_RST} "
if test $errors_answer == "y"; then
    echo_warn " ** Quitting, fix errors before running the rest of the script (aka delete the name of the package from this script that is causing your problems ** "
    exit 1
else
    echo_info "Cool, continuing"
fi

echo_info "Purging some stuff I dont need"
sudo apt purge exim4 avahi-autoipd avahi-daemon unattended-upgrades cryptsetup-initramfs -y


## install repos and their keys and their programs


echo_info " *********** Installing Etcher: Live USB creator ******** "
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/etcher.list
sudo DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt update
sudo apt install balena-etcher-electron -y



echo_info " ******* Installing Youtube-DL: internet video downloader ********** "
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl


echo_info " *********** Installing Nixnote2 (Linux interface for Evernote) ******** "
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:nixnote/nixnote2-stable
sudo apt update
sudo apt -y install nixnote2



echo_info " ***********installing Inxi (System/Hardware Identifier) ******** "
wget -O inxi https://github.com/smxi/inxi/raw/master/inxi
chmod +x inxi 
sudo mv inxi /usr/local/bin/inxi
sudo chown root:root /usr/local/bin/inxi


cd ;

echo_info " ****** Installing the new ProtonVPN-CLI : ProtonVPN-CLI-NG ******* "
sudo pip3 install protonvpn-cli
sleep 2
echo_note "To upgrade in the future, run: sudo pip3 install protonvpn-cli --upgrade"
echo_note "I'll save that for you in a note in your home folder"
sleep 2
echo "sudo pip3 install protonvpn-cli --upgrade" > ~/command-to-upgrade-proton.txt
echo_info "You can initialize and login while this script is running by opening a separate terminal and running: sudo protonvpn init"
sleep 3


   
   
echo_info " *** installing signal messenger for desktop *** "
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo DEBIAN_FRONTEND=noninteractive apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt install signal-desktop -y


echo_info " *** installing spotify *** "
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y


if [ -z $(which gdebi) ]; then
    echo_warn " Please install gdebi to continue "
    exit 1;
fi

mkdir -p ~/Documents/Zips

echo_info " *** Installing Caprine:FB messenger for Linux *** "
cd ~/Documents/Zips
curl -s https://api.github.com/repos/sindresorhus/caprine/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O caprine.deb -qi -
sudo gdebi -n caprine.deb


echo_info " *** installing Teamviewer for Linux *** "
cd ~/Documents/Zips
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo gdebi -n teamviewer_amd64.deb


echo_info " *** Installing Micah F Lee's repository from github.com/micahflee; includes Onionshare and Torbrowser-launcher"
sudo add-apt-repository ppa:micahflee/ppa
sudo apt update
sudo apt install -y onionshare torbrowser-launcher



echo_info " *** Installing Google Chrome *** "
cd ~/Documents/Zips ;
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable*.deb


#echo " *** installing protonmail desktop:unofficial *** "
#cd ~/Documents/Zips ;
#wget https://github.com/protonmail-desktop/application/releases/download/v1.0.2/protonmail-desktop-unofficial_1.0.2_amd64.deb
#sudo gdebi -n protonmail-desktop-unofficial*.deb


echo_info " *** installing slack *** "
cd ~/Documents/Zips ;
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.2.0-amd64.deb
sudo gdebi -n slack-desktop*.deb


echo_info " *** installing virtualbox *** "
cd ~/Documents/Zips ;
#wget https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_amd64.deb
#wget https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack
sudo gdebi -n virtualbox-6.0_6.0.14-133895~Ubuntu~bionic_amd64.deb


echo_info " *** Installing Vivaldi Browser *** "
cd ~/Documents/Zips ;
wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.9.1705.41-1_amd64.deb
sudo gdebi -n vivaldi-stable*.deb

echo_info " *** Installing Zoom *** "
cd ~/Documents/Zips ;
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo gdebi -n zoom_amd64.deb


echo_info " ** Installing Brave Browser ** "
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-browser brave-keyring -y

echo_info " *** Installing Skype *** "
wget https://go.skype.com/skypeforlinux-64.deb
sudo gdebi -n skypeforlinux-64.deb

echo_info " *** downloading and installing Basecamp: Unofficial app for Linux *** "
#curl -s https://api.github.com/repos/arturock/basecamp-linux/releases/latest \
#| grep "browser_download_url.*x64.tar.xz" \
#| cut -d : -f 2,3 \
#| tr -d \" \
#| tail -1 | wget -O basecamp-linux-x64.tar.xz -qi -
wget https://github.com/arturock/basecamp-linux/releases/download/v0.1.2/basecamp-0.1.2-linux-x64.tar.xz
cd ~/Documents/Zips
tar -xzvf basecamp-linux-x64.tar.xz
sudo mv basecamp-linux-x64 /opt/basecamp-linux-x64
sudo chown -R root:root /opt/basecamp-linux-x64
sudo find /opt/basecamp-linux-x64 -type d -exec chmod 755 {} \;
sudo find /opt/basecamp-linux-x64 -type f -exec chmod 644 {} \;
sudo chmod +x /opt/basecamp-linux-x64/basecamp
sudo chmod +x /opt/basecamp-linux-x64/libnode.so
sudo chmod +x /opt/basecamp-linux-x64/libffmpeg.so
sudo ln -s /opt/basecamp-linux-x64/basecamp /usr/local/bin/basecamp

#echo " ** Basecamp is installed. Find it in the application menu or run it from the terminal with #the command: basecamp ** "p



echo_info " ** installing Google Cloud Platform SDK commandline tools ** "
cd ; export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" 
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo DEBIAN_FRONTEND=noninteractive apt-key add - 
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update 
sudo apt install google-cloud-sdk
#gcloud components update


## install nodeJS 10
echo_info " ** Installing NodeJS 12 and npm node package manager, along with gatsby, surge, and nativefier ** "
cd ;
sudo apt install gcc g++ make -y
mkdir ~/.npm-global
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt update
sudo apt -y install nodejs
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:$PATH" | tee -a ~/.profile
source ~/.profile
npm install npm@latest -g
npm install -g gatsby-cli
npm install -g surge
npm install  -g nativefier



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
#sudo gdebi -n upwork*.deb
#sudo gdebi -n virtualbox-6.0_6.0.6-130049~Ubuntu~bionic_amd64.deb
#sudo gdebi -n vivaldi-stable_2.3.1440.60-1_amd64.deb
#sudo gdebi -n youtube-music-desktop_0.2.1_amd64.deb
#sudo gdebi -n zoom_amd64.deb


echo_info "Running updates again"
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y



echo_info "Fixing some things"
#Fixing Tilix
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
echo "if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi"
>> ~/.bashrc


echo_info " ** Hardening (K)Ubuntu security a bit with Apparmor ** "
sudo mkdir -p /etc/default/grub.d
echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT apparmor=1 security=apparmor"'  | sudo tee /etc/default/grub.d/apparmor.cfg
sudo update-grub
sudo aa-enforce firejail-default



#read -p "${ANSI_WHT}Install all the latest from the Kubuntu repository? [y/n] ${ANSI_RST}" answer_kubuntuppa
#if test $answer_kubuntuppa == "y" ; then
#    echo_info " ** installing kubuntu repository/ppa ** "
#    sudo add-apt-repository ppa:kubuntu-ppa/ppa
#    sudo apt update
#    sudo apt -y full-upgrade
#fi

read -p "${ANSI_WHT} Install all the latest KDE stuff from the Kubuntu/KDE backports repository? ${ANSI_RST} ${ANSI_RED}(This could take 10-20 minutes, depending on internet connection speed) [y/n] $ANSI_RST} " answer_backports
if test $answer_backports == "y"; then
    echo " ** installing kubuntu backports ppa ** "
    sudo add-apt-repository ppa:kubuntu-ppa/backports
    sudo apt update
    sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
fi


echo_info " ** All done. Please reboot the computer ** "







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





