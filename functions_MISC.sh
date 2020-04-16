make_folders() {
    cd ;
    mkdir -p $HOME/my-sites
    mkdir -p $HOME/testing-code
}

git_scriptsntools() {
    if [[ -z $(which git) ]]; then
        sudo apt update
        sudo apt install -y git
    fi
    cd ;
    git clone https://github.com/salemaziel/scripts-n-tools
}

gitonions_scriptsntools() {
    if [[ -z $(which git) ]]; then
        read -p "Run update? [y/n]" apt_upt
            case $apt_upt in   
                Y) sudo apt update 
                    ;;
                y) sudo apt update
                    ;;
                N) echo "Skipping apt update"
                    ;;
                n) echo "Skipping apt update"
                    ;;
            esac
    
        sudo apt install -y git torsocks
    fi
    cd ;
    . torsocks on
    git clone https://github.com/salemaziel/scripts-n-tools
}

fix_tilix() {
echo_info "Fixing some things"
#Fixing Tilix
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
echo "if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi" >> $HOME/.bashrc
}

remove_crap() {
echo_info "Removing some unnecessary things"
sudo DEBIAN_FRONTEND=noninteractive apt purge exim4 exim4-daemon-light exim4-config exim4-base mpd postfix apache2 apache2-bin libapache2-mod-php libapache2-mod-php7.* libaprutil1-dbd-sqlite3 cups cups-browsed avahi-daemon -y
}

blacklist_me() {
sudo modprobe -rv mei_hdcp
sudo modprobe -rv mei_me
sudo modprobe -rv mei_mii
echo "blacklist mei" | sudo tee -a /etc/modprobe.d/blacklist.conf
echo "blacklist mei_me" | sudo tee -a /etc/modprobe.d/blacklist.conf
echo "blacklist mei_hdcp" | sudo tee -a /etc/modprobe.d/blacklist.conf
}

salems_kconfs() {
    mkdir -p $HOME/.config/latte
    cp conf/Default.layout.latte $HOME/.config/latte/Default.layout.latte
    mkdir -p $HOME/.config/autostart
    cp conf/Flameshot.desktop $HOME/.config/autostart/Flameshot.desktop
    cp conf/org.kde.latte-dock.desktop $HOME/.config/autostart/org.kde.latte-dock.desktop
    cp -r icons/* $HOME/.local/share/icons/
    git_scriptsntools
    remove_crap
}

apparmor_grub() {
echo_info " ** Hardening (K)Ubuntu security a bit with Apparmor ** "
sudo mkdir -p /etc/default/grub.d
echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT apparmor=1 security=apparmor"'  | sudo tee /etc/default/grub.d/apparmor.cfg
sudo update-grub
if [[ -x $(which firejail) ]]; then
    sudo aa-enforce firejail-default
fi
}

usropt_security() {
    sudo useradd -b /opt -s /usr/sbin/nologin -r -U optuser
    sudo chown -R optuser:optuser /opt
    sudo useradd -b /usr/local/bin -s /usr/sbin/nologin -r -U usrlocbin
    sudo chown -R usrlocbin:usrlocbin /usr/local/bin
    sudo usermod -aG optuser,usrlocbin $USER
}

sysctl_conf() {
    echo "# These are to use bbr, to make tcp protocol faster (aka most of the internet):"
    echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
    echo " " | sudo tee -a /etc/sysctl.conf
    echo "This disables WPAD, auto-proxy finding, to fix security issue of malicious websites finding local ip addresses:"
    echo "net.ipv4.tcp_challenge_ack_limit = 999999999" | sudo tee -a /etc/sysctl.conf
    echo " " | sudo tee -a /etc/sysctl.conf
    echo "This makes npm useable along with a code editor like VS Code, trying to use without adding this will get you the warning from VS Code soon enough" | sudo tee -a /etc/sysctl.conf
    echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
    sudo sysctl --system


}


basic_security() {
    apparmor_grub
    usropt_security
    sysctl_conf
}

install_salems() {
            kubuntu_install
            make_folders
            install_etcher
            install_youtubedl
            install_nixnote
            install_inxi
            install_protonvpn
            install_signal
            install_spotify
            install_caprine
            install_teamviewer
            install_tor
            install_micahs
            install_chrome
            install_slack
            install_vbox
            install_vivaldi
            install_zoom
            install_brave
            install_gcpsdk
            install_node
            install_gatsbycli
            install_surge
            install_nativefier
            install_yarn
            install_firejail
            install_stdnotes
            sudo apt install -y thunderbird
            install_vscode
            install_dockerce
            install_dockercompose
            install_postman
            basic_security
            salems_kconfs
            fix_tilix
            blacklist_me
            install_openvpn3
            echo_note "All Done."
            echo_note "Rebooting system in 30 seconds"
            sleep 30
}
