#!/bin/bash

cd ;

echo -e " ****** Installing the new ProtonVPN-CLI : ProtonVPN-CLI-NG ******* "
sudo pip3 install protonvpn-cli
sleep 2
echo -e "To upgrade in the future, run: sudo pip3 install protonvpn-cli --upgrade"
echo -e "I'll save that for you in a note in your home folder"
sleep 2
echo "sudo pip3 install protonvpn-cli --upgrade" > $HOME/command-to-upgrade-proton.txt
echo -e"You can initialize and login while this script is running by opening a separate terminal and running: sudo protonvpn init"

exit 0