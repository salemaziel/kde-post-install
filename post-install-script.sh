#!/bin/bash

ANSI_RED=$'\033[1;31m'
ANSI_YEL=$'\033[1;33m'
ANSI_GRN=$'\033[1;32m'
ANSI_VIO=$'\033[1;35m'
ANSI_BLU=$'\033[1;36m'
ANSI_WHT=$'\033[1;37m'
ANSI_RST=$'\033[0m'


echo_cmd()    { echo -e "${ANSI_BLU}${@}${ANSI_RST}"; }
echo_prompt() { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_note()   { echo -e "${ANSI_GRN}${@}${ANSI_RST}"; }
echo_info()   { echo -e "${ANSI_WHT}${@}${ANSI_RST}"; }
echo_warn()   { echo -e "${ANSI_YEL}${@}${ANSI_RST}"; }
echo_debug()  { echo -e "${ANSI_VIO}${@}${ANSI_RST}"; }
echo_fail()   { echo -e "${ANSI_RED}${@}${ANSI_RST}"; }



source ./functions_APPs.sh
source ./functions_DESKTOPS.sh
source ./functions_MISC.sh






############################## Script starts ###########################################

echo_prompt '
   _____         __                _      
  / ___/ ____ _ / /___   ____ ___ ( )_____
  \__ \ / __ `// // _ \ / __ `__ \|// ___/
 ___/ // /_/ // //  __// / / / / / (__  ) 
/____/ \__,_//_/ \___//_/ /_/ /_/ /____/  '

echo_note '
   __  __ __                   __        
  / / / // /_   __  __ ____   / /_ __  __
 / / / // __ \ / / / // __ \ / __// / / /
/ /_/ // /_/ // /_/ // / / // /_ / /_/ / 
\____//_.___/ \__,_//_/ /_/ \__/ \__,_/  '
                                    

echo_info '
    ____                __       
   / __ \ ____   _____ / /_      
  / /_/ // __ \ / ___// __/______
 / ____// /_/ /(__  )/ /_ /_____/
/_/     \____//____/ \__/        
                                 '
                                                                                           
echo_info '
    ____              __          __ __           
   /  _/____   _____ / /_ ____ _ / // /___   _____
   / / / __ \ / ___// __// __ `// // // _ \ / ___/
 _/ / / / / /(__  )/ /_ / /_/ // // //  __// /    
/___//_/ /_//____/ \__/ \__,_//_//_/ \___//_/  '




sleep 3

sudo apt-get install --install-recommends dialog -y



read -p "Are you Salem? [y/n]" ru_salem
case $ru_salem in
    Y) 
        echo_warn "No mames guey, no you're not. Nice try. Skipping."
        sleep 3
        echo_info "..on your bitch ass.."
            ;;
    y)
        echo_warn "No mames guey, no you're not. Nice try. Skipping."
        sleep 3
        echo_info "..on your bitch ass.."
            ;;
    N) 
        echo_note "Atleast you're honest. Continuing"
        sleep 3
            ;;
    n) 
        echo_note "Atleast you're honest. Continuing"
        sleep 3
            ;;
    "la neta") 
        echo_note "Whats good Salem"
        read -p "The usual? [y/n]  " USUAL_APPS
        case $USUAL_APPS in
            y)
                echo_note "Fasho. Auto-install starting"
                sleep 2
                install_salems
                reboot
                ;;
            n)
                echo_note "Fasho. Starting regular install process"
                sleep 2
                ;;
        *)
            echo_info "Lol. That wasnt an answer, bro. Continuing"
                ;;
    esac
    ;;
esac



command=(dialog --radiolist "Select Your Ubuntu Flavor" 22 76 16)
os_options=(1 "Ubuntu: Gnome" off
         2 "Kubuntu: KDE" on
         3 "Lubuntu: LXDM" off
         4 "Xubuntu: XFCE" off
         5 "GalliumOS: XFCE" off
         6 "GalliumOS: KDE" off
         7 "Skip this, continue to App List for Installing" off)
os_choices=$("${command[@]}" "${os_options[@]}" 2>&1 >/dev/tty)
clear


cmd=(dialog --separate-output --checklist "Select Extra Apps To Install. Default is to Install All. Navigate with Up/Down Arrows. Select/Unselect with Spacebar. Hit Enter key When Finished To Continue. ESC key/Cancel exits and continues without installing any options" 22 176 16)
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
         28 "Discord: Voice & Text Chat" on
         29 "Mozilla Thunderbird: Email Client" on
         30 "Visual Studio Code: Advanced Text Editor" on
         31 "Docker: Run Apps in Isolated Containers" on
         32 "Docker-Compose: Simplified Docker Container configuration" on
         33 "Syncthing: Sync files across ypur devices" on
         34 "Postman: API Testing" on)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

echo "                          "
echo "                          "
echo "                          "
echo_info "Running updates first"
echo "                          "

sudo apt update

for os_choice in $os_choices
    do
    case $os_choice in
        1)
            gnome_install
            ;;
        2)
            kubuntu_install
            ;;
        3)
            lubuntu_install
            ;;
        4)
            xubuntu_install
            ;;
        5)
            echo_note "Gallium XFCE not finished. Run again and pick something else"
            exit 1
            ;;
        6)
            echo_note "Gallium KDE not finished. Run again and pick something else"
            exit 1
            ;;
        7) 
            echo_note "Skipping Distro-specific installs"
            sleep 2
            ;;
    esac
done




make_folders



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
        29)
            sudo apt install -y thunderbird
            ;;
        30)
            install_vscode
            ;;
        31)
            install_dockerce
            ;;
        32)
            install_dockercompose
            ;;
        33)
            install_syncthing
            ;;
    esac
done


echo_info "Running updates again"
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y



fix_tilix

basic_security



echo_info " ** All done. Please reboot the computer to complete installation ** "

read -p "Restart Now? [y/n] " answer_restart
case $answer_restart in
    Y) echo_warn "Rebooting in 5. Hit ctrl+c to cancel" && sleep 5 && reboot ;;
    y) echo_warn "Rebooting in 5. Hit ctrl+c to cancel" && sleep 5 && reboot ;;
    N) echo_info "Ok. Computer may be buggy until you do" && sleep 2 && exit 0 ;;
    n) echo_info "Ok. Computer may be buggy until you do" && sleep 2 && exit 0 ;;
esac



exit 0
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






