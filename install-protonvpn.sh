#!/bin/bash

cd ;

echo " ****** installing protonvpn ******* "
wget "https://github.com/ProtonVPN/protonvpn-cli/raw/master/protonvpn-cli.sh" -O "protonvpn-cli.sh" && sudo bash protonvpn-cli.sh --install
echo " *** protonvpn openvpn username: code_vpn *** "
sleep 2
echo " *** text salem or login to protonvpn account in browser for protonvpn/openvpn password *** "
sleep 3
echo " *** choose n for custom dns, y for downgrading openvpn privileges, and choose 4) visionary plan when it tells you to choose which plan you have. The code doesnt actually check which plan you have lol *** "
sleep 3
./protonvpn-cli.sh --init

echo " *** making a few custom aliases for using protonvpn; adding sudo to alias, so you dont have to type it out, just type pvpn and the letter string argument *** "
mkalias new pvpn "sudo pvpn"

echo " *** new custom alias pvpn-rcf = reconnect to fastest. Disconnects you from proton, then reconnects to current fastest available" 
mkalias new pvpn-rcf "pvpn -d && pvpn -f"
sleep 2

echo " *** new custom alias pvpn-rcf = reconnect to fastest. Disconnects you from proton, then reconnects to current fastest available" 
mkalias new pvpn-m "pvpn -d && pvpn -m"
sleep 2

echo " ** making a text file in your Home folder with all protonvpn commands including the custom ones just made ** "
touch ~/protonvpn-commands.txt

echo "
Usage: protonvpn-cli.sh [option]
OR
pvpn [option]

custom:
pvpn = sudo pvpn
pvpn-rcf = disconnect from current protonvpn server and reconnect to fastest
pvpn-m = disconnect from current protonvpn server, and bring up a menu to select your server 


Standard Options:
   --init                              Initialize ProtonVPN profile on the machine.
   -c, --connect                       Select and connect to a ProtonVPN server.
   -c [server-name] [protocol]         Connect to a ProtonVPN server by name.
   -m, --menu                          Select and connect to a ProtonVPN server from a menu.
   -r, --random-connect                Connect to a random ProtonVPN server.
   -l, --last-connect                  Connect to the previously used ProtonVPN server.
   -f, --fastest-connect               Connect to the fastest available ProtonVPN server.
   -p2p, --p2p-connect                 Connect to the fastest available P2P ProtonVPN server.
   -tor, --tor-connect                 Connect to the fastest available ProtonVPN TOR server.
   -sc, --secure-core-connect          Connect to the fastest available ProtonVPN SecureCore server.
   -cc, --country-connect              Select and connect to a ProtonVPN server by country.
   -cc [country-name] [protocol]       Connect to the fastest available server in a specific country.
   -d, --disconnect                    Disconnect the current session.
   --reconnect                         Reconnect to the current ProtonVPN server.
   --ip                                Print the current public IP address.
   --status                            Print connection status.
   --update                            Update protonvpn-cli.
   --install                           Install protonvpn-cli.
   --uninstall                         Uninstall protonvpn-cli.
   -v, --version                       Display version.
   -h, --help                          Show this help message. " >> ~/protonvpn-commands.txt
