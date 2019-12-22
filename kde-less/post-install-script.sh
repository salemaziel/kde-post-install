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


install_etcher() {
echo_info " *********** Installing Etcher: Live USB creator ******** "
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61 --yes
sudo apt update
sudo apt install balena-etcher-electron -y
}

install_youtubedl() {
echo_info " ******* Installing Youtube-DL: internet video downloader ********** "
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
}

install_nixnote() {
echo_info " *********** Installing Nixnote2 (Linux interface for Evernote) ******** "
sudo add-apt-repository ppa:nixnote/nixnote2-stable --yes
sudo apt update
sudo apt -y install nixnote2
}

install_inxi() {
echo_info " ***********installing Inxi (System/Hardware Identifier) ******** "
wget -O inxi https://github.com/smxi/inxi/raw/master/inxi
chmod +x inxi 
sudo mv inxi /usr/local/bin/inxi
sudo chown root:root /usr/local/bin/inxi
}


install_protonvpn() {
echo_info " ****** Installing the new ProtonVPN-CLI : ProtonVPN-CLI-NG ******* "
sudo pip3 install protonvpn-cli
sleep 2
echo_note "To upgrade in the future, run: sudo pip3 install protonvpn-cli --upgrade"
echo_note "I'll save that for you in a note in your home folder"
sleep 2
echo "sudo pip3 install protonvpn-cli --upgrade" > $HOME/command-to-upgrade-proton.txt
echo_info "You can initialize and login while this script is running by opening a separate terminal and running: sudo protonvpn init"
sleep 3
}

   
install_signal() {
echo_info " *** installing signal messenger for desktop *** "
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt install signal-desktop -y
}

install_spotify() {
echo_info " *** installing spotify *** "
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y
}

install_caprine() {
echo_info " *** Installing Caprine:FB messenger for Linux *** "
cd ~/Documents/Zips
curl -s https://api.github.com/repos/sindresorhus/caprine/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -1 | wget -O caprine.deb -qi -
sudo gdebi -n caprine.deb
}

install_teamviewer() {
    echo_info " *** installing Teamviewer for Linux *** "
    cd ~/Documents/Zips
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    sudo gdebi -n teamviewer_amd64.deb
}


install_tor() {
echo_info "Installing Tor"
source /etc/os-release
echo "deb https://deb.torproject.org/torproject.org $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/onions.list
su -c 'curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import'
su -c 'gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -'
sudo apt update
sudo apt install -y tor deb.torproject.org-keyring torsocks
}

install_micahs() {
echo_info " *** Installing Micah F Lee's repository from github.com/micahflee; includes Onionshare and Torbrowser-launcher"
sudo add-apt-repository ppa:micahflee/ppa
sudo apt update
sudo apt install -y onionshare torbrowser-launcher
}

install_chrome() {
echo_info " *** Installing Google Chrome *** "
cd ~/Documents/Zips ;
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable*.deb
}

install_slack() {
echo_info " *** installing slack *** "
cd ~/Documents/Zips ;
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.2.0-amd64.deb
sudo gdebi -n slack-desktop*.deb
}


install_vbox() {
echo_info " *** installing virtualbox *** "
cd ~/Documents/Zips ;
wget https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_amd64.deb
wget https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack
sudo gdebi -n virtualbox-6.0_6.0.14-133895~Ubuntu~bionic_amd64.deb
}

install_vivaldi() {
echo_info " *** Installing Vivaldi Browser *** "
cd ~/Documents/Zips ;
wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.9.1705.41-1_amd64.deb
sudo gdebi -n vivaldi-stable*.deb
}

install_zoom() {
echo_info " *** Installing Zoom *** "
cd ~/Documents/Zips ;
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo gdebi -n zoom_amd64.deb
}

install_brave() {
echo_info " ** Installing Brave Browser ** "
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-browser brave-keyring -y
}

install_skype() {
echo_info " *** Installing Skype *** "
wget https://go.skype.com/skypeforlinux-64.deb
sudo gdebi -n skypeforlinux-64.deb
}

install_basecamp() {
echo_info " *** downloading and installing Basecamp: Unofficial app for Linux *** "
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
}

install_gcpsdk() {
echo_info " ** installing Google Cloud Platform SDK commandline tools ** "
cd ; export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" 
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update 
sudo apt install -y google-cloud-sdk
}

install_node() {
echo_info " ** Installing NodeJS 12 and npm node package manager, along with gatsby, surge, and nativefier ** "
cd ;
sudo apt install gcc g++ make -y
mkdir ~/.npm-global
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt update
sudo apt install -y nodejs
npm config set prefix "$HOME/.npm-global"
echo "export PATH=$HOME/.npm-global/bin:$PATH" | tee -a $HOME/.profile
source $HOME/.profile
npm install npm@latest -g
}

install_gatsbycli() {
npm install -g gatsby-cli
}

install_surge() {
npm install -g surge
}

install_nativefier() {
npm install  -g nativefier
}

install_yarn() {
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install -y yarn
}

install_firejail() {
echo_info "Installing Firejail: Linux SUID Sandbox"
cd ~/Documents/Zips ;
wget https://sourceforge.net/projects/firejail/files/LTS/firejail-apparmor_0.9.56.2-LTS_1_amd64.deb
sudo gdebi -n firejail-apparmor_0.9.56.2-LTS_1_amd64.deb
}

install_stdnotes() {
echo_info "Installing Standard Notes: Encrypted Notebook. Answer Yes if asked about Integrating to Desktop"
cd ~/Documents/Zips ;
https://github.com/standardnotes/desktop/releases/download/v3.0.23/Standard-Notes-3.0.23.AppImage
mkdir -p $HOME/.local/bin
cp -r Standard-Notes-3.0.23.AppImage $HOME/.local/bin/Standard-Notes-3.0.23.AppImage
cd $HOME/.local/bin
chmod a+x Standard-Notes-3.0.23.AppImage
./Standard-Notes-3.0.23.AppImage
}

install_discord() {
echo_info "Installing Discord: Voice & Text Chat"
cd $HOME/Documents/Zips ;
wget https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb
sudo gdebi -n discord-0.0.9.deb
}

install_vscode() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code
}



echo_prompt '
   _____            __                    _                        
  / ___/  ____ _   / /  ___    ____ ___  ( )   _____           
  \__ \  / __ `/  / /  / _ \  / __ `__ \ |/   / ___/               
 ___/ / / /_/ /  / /  /  __/ / / / / / /     (__  )                  
/_______\__,_/  /_/   \___/___/ /_/ /_/  ________/  '  

echo_note '
        __ __    ____     ______
       / //_/   / __ \   / ____/
      / ,<     / / / /  / __/
     / /| |   / /_/ /  / /___   
    /_/ |__  /_____/  /_____/ '

echo_info '
     ____                   __         
    / __ \  ____    _____  / /_        
   / /_/ / / __ \  / ___/ / __/ ______ 
  / ____/ / /_/ / (__  ) / /_  /_____/ 
 /_/      \____/ /____/  \__/  '
                                                                                           
echo_info '
      ____                   __             __    __
     /  _/   ____    _____  / /_  ____ _   / /   / /  ___    _____
     / /    / __ \  / ___/ / __/ / __ `/  / /   / /  / _ \  / __`/
   _/ /    / / / / (__  ) / /_  / /_/ /  / /   / /  /  __/ / /
  /___/   /_/ /_/ /____/  \__/  \__,_/  /_/   /_/   \___/ /_/'




sleep 2


echo "                          "
echo "                          "
echo "                          "
echo_info "Running updates first"
echo "                          "

sleep 1

sudo apt update
#sudo DEBIAN_FRONTEND=noninteractive apt -y full-upgrade


##apt packages to install
echo "                          "
echo "                          "
echo_info "Installing a shitload of Linux packages"
echo "                          "

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install gcc wireguard g++ make magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw gufw eog eog-plugins eog-plugins-common uget rsync curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi mpv wipe bleachbit lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount network-manager-openvpn tar gimp fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils use fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed util-linux wget xdg-utils xterm zip ecryptfs-utils overlayroot whois wikipedia2text secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo git rusers traceroute whereami localepurge skrooge makejail psad hwinfo progress powertop xdiagnose health-check converseen imgp mpv vlc clamav clamav-base clamav-docs clamav-freshclam clamtk redshift apt-listchanges debian-goodies debsecan libpam-passwdqc gufw nikto mumble apparmor apt-transport-https p7zip-full gparted gnome-disk-utility python python3 filelight netcat unzip  ddgr kolourpaint mtpaint  netdiscover acpi tilix inkscape inkscape-open-symbols build-essential gettext apt-transport-https bash-completion unrar latte-dock clamtk clamav-unofficial-sigs kwrite mousepad wmctrl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl openresolv xserver-xorg-input-synaptics xserver-xorg-input-libinput freeipmi-tools menu nodejs-doc ntrack-module-libnl-0 python-crcmod python-dbus python-qt4-dbus python3-aptdaemon python3-defer lsat sni-qt speedtest-cli libbit-vector-perl libcarp-clan-perl libdate-calc-perl libdate-calc-xs-perl libiptables-chainmgr-perl libiptables-parse-perl libnetaddr-ip-perl libunix-syslog-perl python3-ldbus hfsutils hfsutils-tcltk disktype testdisk tmfs apt-transport-https software-properties-common flameshot sweeper urlwatch mwc python-dbus.mainloop.pyqt5 px fssync python-scrapy-doc python3-scrapy python3-w3lib python3-selenium python-selenium mwc python3-requests python3-mechanicalsoup node-autolinker node-axios node-htmlparser2 node-htmlparser python-mechanize python3-html2text python3-vobject wdiff wdiff-doc shellcheck hardinfo -y

sleep 2


mkdir -p $HOME/Documents/Zips

cmd=(dialog --separate-output --checklist "Select Apps To Install. Default is to Install All. Navigate with Up/Down Arrows. Select/Unselect with Spacebar. Hit Enter key When Finished To Continue. ESC key/Cancel exits and continues without installing any options" 22 176 16)
options=(1 "Etcher: Live USB creator" on
         2 "Youtube-DL: Internet Video Downloader" on
         3 "Nixnote2: Linux interface for Evernote" on
         4 "Inxi: System/Hardware Identifier" on
         5 "ProtonVPN-CLI: ProtonVPN-CLI-NG" on
         6 "Signal: Encrypted Messenger for Desktop" on
         7 "Spotify: Music Streaming" on
         8 "Caprine: Facebook Messenger for Linux" on
         9 "TeamViewer: Remote Desktop Sharing" on
         10 "Tor: Onion Routing for (kind of) Anonymous Secure Browsing" on
         11 "OnionShare: Share Files Securely Over Tor Network && TorBrowser-Launcher (Needs Tor)" on
         12 "Google Chrome" on
         13 "Slack Messenger" on
         14 "VirtualBox: Virtual Operating Systems" on
         15 "Vivaldi Browser" on
         16 "Zoom: Video Conferences" on
         17 "Brave Browser" on
         18 "Skype Video Chat" on
         19 "BaseCamp: Unofficial Desktop App" on
         20 "Google Cloud Platform SDK CommandLine Tools" on
         21 "NodeJS 12 && NPM package manager" on
         22 "NPM - Gatsby-CLI" on
         23 "NPM - Surge" on
         24 "NPM - Nativefier" on
         25 "YARN: Additional NodeJS packagemanager" on
         26 "FireJail: Application Sandbox" on
         27 "Standard Notes: Encrypted Device-Syncing Notes" on
         28 "Discord: Voice & Text Chat" on)
         29 "Mozilla Thunderbird: Email Client"
         30 "Visual Studio Code: Advanced Text Editor"
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            install_etcher
            ;;
        2)
            install_youtubedl
            ;;
        3)
            install_nixnote
            ;;
        4)
            install_inxi
            ;;
        5)
            install_protonvpn
            ;;
        6)
            install_signal
            ;;
        7)
            install_spotify
            ;;
        8)
            install_caprine
            ;;
        9)
            install_teamviewer
            ;;
        10)
            install_tor
            ;;
        11)
            install_micahs
            ;;
        12)
            install_chrome
            ;;
        13)
            install_slack
            ;;
        14)
            install_vbox
            ;;
        15)
            install_vivaldi
            ;;
        16)
            install_zoom
            ;;
        17)
            install_brave
            ;;
        18)
            install_skype
            ;;
        19)
            install_basecamp
            ;;
        20)
            install_gcpsdk
            ;;
        21)
            install_node
            ;;
        22)
            install_gatsbycli
            ;;
        23)
            install_surge
            ;;
        24)
            install_nativefier
            ;;
        25)
            install_yarn
            ;;
        26)
            install_firejail
            ;;
        27)
            install_stdnotes
            ;;
        28)
            install_discord
            ;;
        29) sudo apt install -y thunderbird
            ;;
    esac
done


sudo apt update



echo_info "Running updates again"
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y



echo_info "Fixing some things"
#Fixing Tilix
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
echo "if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi"
>> $HOME/.bashrc

echo_info "Removing some unnecessary some things"
sudo apt purge exim4 exim4-daemon-light exim4-config exim4-base mpd postfix apache2 apache2-bin libapache2-mod-php libapache2-mod-php7.* libaprutil1-dbd-sqlite3 -y

sudo modprobe -rv mei_*
echo "blacklist mei" | sudo tee -a /etc/modprobe.d/blacklist.conf
echo "blacklist mei_me" | sudo tee -a /etc/modprobe.d/blacklist.conf
echo "blacklist mei_hdcp" | sudo tee -a /etc/modprobe.d/blacklist.conf



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
    sudo add-apt-repository ppa:kubuntu-ppa/backports --yes
    sudo apt update
    sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
fi


echo_info " ** All done. Please reboot the computer to complete installation ** "

read -p "Restart Now? [y/n] " answer_restart
case $answer_restart in
    Y) echo_warn "Rebooting in 5. Hit ctrl+c to cancel" && sleep 5 && reboot ;;
    y) echo_warn "Rebooting in 5. Hit ctrl+c to cancel" && sleep 5 && reboot ;;
    N) echo_info "Ok. Computer may be buggy until you do" && sleep 2 && exit 0 ;;
    n) echo_info "Ok. Computer may be buggy until you do" && sleep 2 && exit 0 ;;
esac



done



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




