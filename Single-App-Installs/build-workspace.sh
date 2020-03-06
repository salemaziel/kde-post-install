#!/usr/bin/env bash

echo -e "Codestaff-admin will be the admins account with sudo privileges"
sleep 1
read -p "Enter password for Codestaff-admin: " CS_ADM

echo -e "Codestaff-user is the account the person using workspace will use to login"
sleep 1
read -p "Enter password for Codestaff-user: " CS_USER
read -p "Enter password for accessing Teamviewer: " TV_PASS

if [ -z $(which teamviewer) ];then
    sudo apt update 
    sudo apt -y full-upgrade
    sudo useradd -m -U codestaff-user
    sudo useradd -m -U codestaff-admin
    
    sudo usermod -aG sudo,admin,adm,netdev,users codestaff-admin
    sudo echo "codestaff-user:$CS_USER" | chpasswd
    sudo echo "codestaff-admin:$CS_ADM" | chpasswd
    
    echo "                                                                             "
    echo "*****************************************************************************"
    echo "*****************************************************************************"
    echo "           Installing Necessary Packages: Xubuntu-desktop, gdebi, curl,      "
    echo "           wget, git, magic-wormhole, x11-apps, xerver-xorg-video-dummy      "
    echo "                   THIS WILL LIKELY TAKE ATLEAST 5-10 MINS                   "
    echo "*****************************************************************************"
    echo "*****************************************************************************"
    echo "                                                                             "

    sleep 3

    sudo apt install xubuntu-desktop gdebi curl wget git magic-wormhole x11-apps xserver-xorg-video-dummy -y

    echo '# This xorg configuration file is meant to be used
    # to start a dummy X11 server.
    # For details, please see:
    # https://www.xpra.org/xorg.conf

    # Here we setup a Virtual Display of 1600x900 pixels

    Section "Device"
            Identifier  "Configured Video Device"
            Driver      "dummy"
            #VideoRam 4096000
            #VideoRam 256000
            VideoRam    16384
    EndSection

    Section "Monitor"
            Identifier  "Configured Monitor"
            HorizSync   5.0 - 1000.0
            VertRefresh 5.0 - 200.0
            Modeline "1600x900" 33.92 1600 1632 1760 1792 900 921 924 946
    EndSection

    Section "Screen"
            Identifier  "Default Screen"
            Monitor     "Configured Monitor"
            Device      "Configured Video Device"
            DefaultDepth 24
            SubSection "Display"
                    Viewport 0 0
                    Depth 24
                    Virtual 1600 900
            EndSubSection
    EndSection ' | sudo tee /etc/X11/xorg.conf

    sudo X :1 -configure

    cd $HOME/Downloads ;
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    sudo gdebi -n teamviewer_amd64.deb
    
    echo " *** REBOOTING IN 10 SECONDS. RUN SCRIPT AGAIN TO CONTINUE AND FINISH, *** "
    echo " *** IT'LL SKIP THE PARTS IT'S ALREADY DONE                            *** "
    
    sleep 10
    sudo reboot
fi

sudo teamviewer daemon stop
sleep 5
sudo teamviewer daemon start
sleep 2
sudo teamviewer passwd $TV_PASS
sudo systemctl enable teamviewerd

sudo teamviewer setup

#sudo deluser codestaff google-sudoers
#sudo deluser codestaff adm
#sudo deluser codestaff sudo
#sudo deluser codestaff pc
#sudo deluser codestaff bitnami

#gsutil cp gs://codestaff-scripts/workspace-bg.png ${HOME}/Pictures
#cd ${HOME}/Pictures

#sudo cp workspace-bg.png /usr/share/backgrounds/xfce/

#sudo -u codestaff -g $( id -g codestaff ) xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set /usr/share/backgrounds/xfce/workspace-bg.png

echo "*****************************************************************************"
echo "                                                                             "
echo "                                                                             "
echo " *** WORKSPACE CREATED. PLEASE REBOOT TO COMPLETE SETUP                      "
echo "      AFTER SAVING THE LOGIN INFO BELOW *** "
echo "                                                                             "
echo "*****************************************************************************"
echo "*****************************************************************************"
echo "                                                                             "
teamviewer info | grep 'TeamViewer ID'
echo "  TeamViewer Password: $TV_PASS                                               "
echo "                                                                             "
echo "*****************************************************************************"
echo "                                                                             "
echo "Workspace Username: codestaff-user                                           "
echo "Workspace password: $CS_USER                                                "
echo "                                                                             "
echo "                                                                             "
echo "Workspace Admin Username: codestaff-admin                                    "
echo "Workspace password: $CS_ADM                                                "
echo "                                                                             "
echo "*****************************************************************************"
echo "*****************************************************************************"
sudo X -config /home/codestaff-admin/xorg.conf.new
sudo X -config /home/codestaff-user/xorg.conf.new














