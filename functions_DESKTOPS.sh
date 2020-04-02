gnome_install() {
    sudo apt update
    sudo -v
    sudo DEBIAN_FRONTEND=noninteractive apt install gdm3 gedit gedit-common zenity zenity-common ubuntu-wallpapers-eoan gnome-applets-data gnome-audio gnome-backgrounds gnome-control-center gnome-control-center-data gnome-disk-utility gnome-extra-icons gnome-mpv gnome-nettool gnome-online-account gnome-gmail gnome-paint gnome-photos gnome-phone-manager gnome-pie gnome-power-manager gnome-screenshot gnome-session gnome-shell-extension-appindicator gnome-shell-extension-autohidetopbar gnome-shell-extension-bluetooth-quick-connect gnome-shell-extension-caffeine gnome-shell-extension-dash-to-panel gnome-shell-extension-dashtodock gnome-shell-extension-disconnect-wifi gnome-shell-extension-easyscreencast gnome-shell-extension-gsconnect gnome-shell-extension-gsconnect-browsers gnome-shell-extension-hard-disk-led gnome-shell-extension-hide-activities gnome-shell-extension-impatience gnome-shell-extension-log-out-button gnome-shell-extension-move-clock gnome-shell-extension-redshift gnome-shell-extension-suspend-button gnome-shell-extension-system-monitor gnome-shell-extension-tilix-dropdown gnome-shell-extension-tilix-shortcut gnome-shell-extension-top-icons-plus gnome-shell-extension-ubuntu-dock gnome-shell-extension-workspaces-to-dock gnome-shell-extensions-gpaste gnome-shell-mailnag gnome-shell-pomodoro gnome-shell-pomodoro-data gnome-shell-timer wireshark wireshark-gtk gnome-todo gnome-system-tools gnome-system-monitor gnome-system-log gnome-tweak-tool gnome-tweaks nautilus-actions nautilus-extension-gnome-terminal nautilus-scripts-manager network-manager-openvpn-gnome   gcc wireguard g++ make magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw gufw eog eog-plugins eog-plugins-common uget rsync curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi mpv wipe bleachbit lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount network-manager-openvpn tar gimp fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils use fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed util-linux wget xdg-utils xterm zip ecryptfs-utils overlayroot whois wikipedia2text secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo view noir git rusers traceroute whereami localepurge makejail psad hwinfo progress powertop xdiagnose health-check converseen imgp mpv vlc clamav clamav-base clamav-docs clamav-freshclam clamtk redshift apt-listchanges debian-goodies debsecan libpam-passwdqc gufw nikto mumble apparmor apt-transport-https p7zip-full gparted gnome-disk-utility python python3 filelight netcat unzip  ddgr kolourpaint mtpaint  netdiscover acpi tilix inkscape inkscape-open-symbols build-essential gettext bash-completion unrar latte-dock clamtk clamav-unofficial-sigs kwrite mousepad wmctrl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl openresolv xserver-xorg-input-synaptics xserver-xorg-input-libinput freeipmi-tools menu nodejs-doc   python-dbus python-qt4-dbus python3-aptdaemon python3-defer speedtest-cli libbit-vector-perl libcarp-clan-perl libdate-calc-perl libdate-calc-xs-perl libiptables-chainmgr-perl libiptables-parse-perl libnetaddr-ip-perl libunix-syslog-perl  hfsutils hfsutils-tcltk disktype testdisk tmfs software-properties-common flameshot sweeper urlwatch mwc python-dbus.mainloop.pyqt5 px fssync python-scrapy-doc python3-scrapy python3-w3lib python3-selenium python-selenium mwc python3-requests python3-mechanicalsoup node-autolinker node-axios node-htmlparser2 node-htmlparser python-mechanize python3-html2text python3-vobject wdiff wdiff-doc ubuntu-restricted-extras shellcheck hardinfo -y
}

kubuntu_install() {
    sudo apt update
    read -p "${ANSI_GRN}Install all the latest from (K)Ubuntu repository? [y/n] ${ANSI_RST}" answer_kubuntuppa
    read -p "${ANSI_GRN} Install all the latest KDE stuff from the Kubuntu backports repository? ${ANSI_RST} ${ANSI_YEL}(This could take 10-20 minutes, depending on internet connection speed) [y/n] $ANSI_RST} " answer_backports
    sudo -v
    sudo DEBIAN_FRONTEND=noninteractive apt install gcc wireguard g++ make magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw kubuntu-restricted-extras gufw eog eog-plugins eog-plugins-common uget rsync curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi ksystemlog mpv wipe kio-gdrive kaccounts-integration plasma-widgets-addons bleachbit lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount network-manager-openvpn tar gimp libreoffice fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils fuse fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed util-linux wget xdg-utils xterm zip ecryptfs-utils overlayroot whois wikipedia2text secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo git rusers traceroute whereami cmake krename localepurge skrooge makejail psad hwinfo progress dolphin-plugins powertop xdiagnose health-check converseen imgp mplayer vlc clamav clamav-base clamav-docs clamav-freshclam clamtk redshift plasma-applet-redshift-control apt-listchanges wireshark wireshark-qt debian-goodies debsecan libpam-passwdqc gufw nikto mumble apparmor apt-transport-https p7zip-full gparted gnome-disk-utility python python3 filelight netcat unzip  ddgr kolourpaint mtpaint qml-module-org-kde-kaccounts  netdiscover kde-config-systemd acpi tilix inkscape inkscape-open-symbols build-essential libkf5config-dev libkdecorations2-dev libqt5x11extras5-dev qtdeclarative5-dev libkf5guiaddons-dev libkf5configwidgets-dev libkf5windowsystem-dev libkf5coreaddons-dev gettext bash-completion unrar latte-dock clamtk clamav-unofficial-sigs kwrite mousepad wmctrl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl libqtwebkit-qmlwebkitplugin libqt5webview5 qml qml-module-org-kde-charts qml-module-org-kde-okular qml-module-qtgstreamer qml-module-qtquick-extras qml-module-qtquick-shapes openresolv kdialog xserver-xorg-input-synaptics xserver-xorg-input-libinput freeipmi-tools qt5-style-plugin-gtk2 gtk3-engines-breeze gtk2-engines-aurora gtk2-engines-murrine gtk2-engines-sugar gtk2-engines-pixbuf menu nodejs-doc  phonon phonon-backend-gstreamer   python-dbus python-qt4-dbus python3-aptdaemon python3-defer python3-qrcode ttf-ubuntu-font-family speedtest-cli libbit-vector-perl libcarp-clan-perl libdate-calc-perl libdate-calc-xs-perl libiptables-chainmgr-perl libiptables-parse-perl libnetaddr-ip-perl libunix-syslog-perl  hfsutils hfsutils-tcltk disktype testdisk tmfs ca-certificates software-properties-common flameshot extra-xdg-menus kde-config-plymouth sweeper urlwatch mwc python-dbus.mainloop.pyqt5 px fssync python-scrapy-doc python3-scrapy python3-w3lib python3-selenium python-selenium rss-bridge tweeper mwc python3-magic-wormhole-mailbox-server python3-requests python3-mechanicalsoup node-autolinker node-axios node-htmlparser2 node-htmlparser python-mechanize python3-html2text python3-vobject wdiff wdiff-doc elisa k4dirstat kubuntu-docs plymouth-theme-breeze plymouth-theme-kubuntu-logo plymouth-theme-kubuntu-text qml-module-qtquick-controls-styles-breeze qtdeclarative5-kf5solid qtcurve shellcheck hardinfo -y

        case $answer_kubuntuppa in
            Y)
                echo_info " ** installing kubuntu repository/ppa ** "
                sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kubuntu-ppa/ppa
                sudo apt update
                sudo -v
                sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
                    ;;
            y) 
                echo_info " ** installing kubuntu repository/ppa ** "
                sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kubuntu-ppa/ppa
                sudo apt update
                sudo -v
                sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
                    ;;
            N)  echo "OK"
                    ;;
            n)  echo "OK"
                    ;;
        esac

        case $answer_backports in
            Y)
                echo " ** installing kubuntu backports ppa ** "
                sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kubuntu-ppa/backports --yes
                sudo apt update
                sudo -v
                sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
                    ;;
            y) 
                echo " ** installing kubuntu backports ppa ** "
                sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kubuntu-ppa/backports --yes
                sudo apt update
                sudo -v
                sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
                    ;;

            N)  echo "OK"
                    ;;
            n)  echo "OK"
                    ;;
        esac

        
}

lubuntu_install() {
    sudo apt update
    sudo -v
    sudo DEBIAN_FRONTEND=noninteractive apt install gcc wireguard g++ make magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw gufw eog eog-plugins eog-plugins-common uget rsync curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi mpv wipe bleachbit lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount network-manager-openvpn tar gimp fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils use fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed util-linux wget xdg-utils xterm zip ecryptfs-utils overlayroot whois wikipedia2text secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo git rusers traceroute whereami localepurge skrooge makejail psad hwinfo progress powertop xdiagnose health-check converseen imgp mpv vlc clamav clamav-base clamav-docs clamav-freshclam clamtk redshift apt-listchanges debian-goodies debsecan libpam-passwdqc gufw nikto mumble apparmor apt-transport-https p7zip-full gparted gnome-disk-utility python python3 filelight netcat unzip  ddgr kolourpaint mtpaint  netdiscover acpi tilix inkscape inkscape-open-symbols build-essential gettext bash-completion unrar latte-dock clamtk clamav-unofficial-sigs kwrite mousepad wmctrl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl openresolv xserver-xorg-input-synaptics xserver-xorg-input-libinput freeipmi-tools menu nodejs-doc   python-dbus python-qt4-dbus python3-aptdaemon python3-defer speedtest-cli libbit-vector-perl libcarp-clan-perl libdate-calc-perl libdate-calc-xs-perl libiptables-chainmgr-perl libiptables-parse-perl libnetaddr-ip-perl libunix-syslog-perl  hfsutils hfsutils-tcltk disktype testdisk tmfs software-properties-common flameshot sweeper urlwatch mwc python-dbus.mainloop.pyqt5 px fssync python-scrapy-doc python3-scrapy python3-w3lib python3-selenium python-selenium mwc python3-requests python3-mechanicalsoup node-autolinker node-axios node-htmlparser2 node-htmlparser python-mechanize python3-html2text python3-vobject wdiff wdiff-doc shellcheck hardinfo lxappearance wireshark wireshark-gtk lxappearance-obconf lxtask lxterminal 
}

xubuntu_install() {
    sudo apt update
    sudo -v
    sudo DEBIAN_FRONTEND=noninteractive apt install gcc wireguard g++ make magic-wormhole openvpn dialog python3-pip python3-setuptools tlp tlp-rdw gufw eog eog-plugins eog-plugins-common uget rsync curl firejail firejail-profiles ufw apparmor-profiles apparmor-profiles-extra apparmor-utils python3-apparmor python3-libapparmor gdebi mpv wipe bleachbit lastpass-cli zulumount-cli zulumount-gui zulucrypt-cli zulucrypt-gui cryptmount network-manager-openvpn tar gimp fatcat fatresize fatsort hfsprogs disktype exfat-utils hfsplus hfsutils network-manager-openvpn-gnome howdoi nmap zenmap harden-doc linssid bash bc bzip2 coreutils diffutils ffmpeg file findutils use fuseiso gawk gnupg gnupg2 htop isomd5sum  mlocate net-tools poppler-utils procps psmisc pv sed util-linux wget xdg-utils xterm zip ecryptfs-utils overlayroot whois wikipedia2text secure-delete debsigs debsums debhelper atop filezilla linssid mat moreutils ndiff ngrep nicstat nield openclipart-png procinfo git rusers traceroute whereami localepurge skrooge makejail psad hwinfo progress powertop xdiagnose health-check converseen imgp mpv vlc clamav clamav-base clamav-docs clamav-freshclam clamtk redshift apt-listchanges debian-goodies debsecan libpam-passwdqc gufw nikto mumble apparmor apt-transport-https p7zip-full gparted gnome-disk-utility python python3 filelight netcat unzip  ddgr kolourpaint mtpaint  netdiscover acpi tilix inkscape inkscape-open-symbols build-essential gettext bash-completion unrar latte-dock clamtk clamav-unofficial-sigs kwrite mousepad wmctrl lm-sensors hddtemp smartmontools libcpanel-json-xs-perl openresolv xserver-xorg-input-synaptics xserver-xorg-input-libinput freeipmi-tools menu nodejs-doc   python-dbus python-qt4-dbus python3-aptdaemon python3-defer speedtest-cli libbit-vector-perl libcarp-clan-perl libdate-calc-perl libdate-calc-xs-perl libiptables-chainmgr-perl libiptables-parse-perl libnetaddr-ip-perl libunix-syslog-perl  hfsutils hfsutils-tcltk disktype testdisk tmfs software-properties-common flameshot sweeper urlwatch mwc python-dbus.mainloop.pyqt5 px fssync python-scrapy-doc python3-scrapy python3-w3lib python3-selenium python-selenium mwc python3-requests python3-mechanicalsoup node-autolinker node-axios node-htmlparser2 node-htmlparser python-mechanize python3-html2text python3-vobject wdiff wdiff-doc shellcheck hardinfo wireshark xfdashboard-plugins xfdashboard xfce4-screensaver xfce4-screenshooter xfce4-places-plugin xfce4-panel-profilesxfce4-notes-plugin xfce4-goodies xfce4-fsguard-plugin thunar xfwm4 xfwm4-theme-breze xubuntu-artwork xubuntu-community-wallpapers-bionic xubuntu-restricted-addons xubuntu-wallpapers -y
}

galliumosx_install() {
	echo "gallium osx"
}

galliumoskde_install() {
    echo "gallium oskde"
}