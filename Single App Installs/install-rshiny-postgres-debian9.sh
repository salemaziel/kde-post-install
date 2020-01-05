#!/bin/bash

if [-z ($EUID) !== "0"]; then
    echo "Please run this as root (type 'su' and enter password)"
    exit 1
fi

apt update
apt -y full-upgrade

apt install nano gdebi gdebi-core git sudo gpgv2 dirmngr gnupg1-curl curl -y

echo "deb http://cran.stat.ucla.edu/bin/linux/debian stretch-cran35/" >> /etc/apt/source.list

apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

apt update
apt install -y r-base

echo 'options(download.file.method = "libcurl")' >> /etc/R/Rprofile.site

sudo su - -c "R -e \"install.packages('shiny')\""

cd /tmp ;
wget https://download2.rstudio.org/server/debian9/x86_64/rstudio-server-1.2.1335-amd64.deb

gdebi -n rstudio-server-1.2.1335-amd64.deb

echo " ** R studio+shiny server installed; open a browser and go to http://server_ipaddress:8787 to verify. Your login is your username and password on the server ** "

sleep 10

read -p "Continue?[y/n] " answer_continue

if $answer_continue == "n"; then
    echo " Quitting."
    exit 1
fi

apt install -y postgresql

read -p "Username for Postgres user? " postgres_username
echo " ** If you make a dedicated user account on the server, don't forget to name it the same thing! You can create the user with this script, which will be saved in the directory you ran this script from. Make sure to change the /path/to/app/root/directory to your desired directory, and username to your chosen username:
sudo useradd -m -d /path/to/app/root/directory -U -r -s /bin/bash username"

echo "sudo useradd -m -d /path/to/app/root/directory -U -r -s /bin/bash username" >> create-dedicated-user.txt
sleep 5

sudo su - postgres -c "createuser -s $postgres_username"

echo " ** Done. Please reboot ** "
