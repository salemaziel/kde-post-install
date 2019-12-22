# kde-post-install
Post install script first made for KDE, now works for any Ubuntu

## Instructions So It Will Work:
Run the following commands first BEFORE running post-install-script.sh, which is the main script with options to download shit. 

1.
sudo apt install dialog -y

2.
chmod +x post-install-script.sh

3.
./post-install-script.sh


If only downloading one app from single install-*.sh scripts, enter:

1.
chmod +x install-APPNAME.sh

2.
./install-APPNAME.sh


and follow any instructions, obviously switching out APPNAME for the app you want to download

