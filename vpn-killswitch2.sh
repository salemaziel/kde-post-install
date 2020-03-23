#!/bin/bash
 
 ################################################################################################################################
##                                                                                                                             ##
## This script kills the internet connectivity should the VPN connection, once established, drop.                              ##
## To enable networking again using the terminal, use: $ nmcli networking on                                                   ##
##                                                                                                                             ##
## This script relies on the package 'network-manager' to disable the network, and on 'libnotify-bin' to send notifications.   ##
## This script does *not* need root permissions (in common system configurations).                                             ##
##                                                                                                                             ##
## This script was written for and tested on Debian 9 Stretch, but should work on most Debian derivates.                       ##
## It comes without any warranty and you use it on your own risk - you alone are responsible for your actions on the Internet. ##
##                                                                                                                             ##
## Other than that, you can do whatever you like with this script. Enjoy!                                                      ##
##                                                                                                                             ##
################################################################################################################################
 
 
INTERFACE="tun0"            ## default tun0 - the vpn interface that will be monitored.
VPN_EXISTS_CHECK="5"       ## default 30   - the time to wait between scans for an active VPN connection
VPN_DROPPED_CHECK="0.25"    ## default 0.25 - the time to wait for the next check whether the VPN interface still exists
 
ECHO="0"                    ## set to "1" if you want/need terminal output.
 
 
## the script will run in an infinite loop.
while :
do
 
    ## first, the script will check if there's a VPN connection to be monitored.
    if ! [[ $(ip addr | grep $INTERFACE) = "" ]]; then
 
        ## if $INTERFACE exists, there is a VPN connection.
        echo -e "VPN connection was found and will be monitored."
        if [[ $ECHO == "1" ]]; then echo "[$(date +%H:%M:%S)]: VPN found; monitoring."; fi
 
        ## if a VPN connection was detected, it will be watched using an infinite loop.
        while :
        do
            ## let's check if the tun0 interface is still there...
            if [[ $(ip addr | grep $INTERFACE) = "" ]]; then
 
                ## Oops! the $INTERFACE interface vanished, quickly kill networking and notify the user.
                nmcli networking off
                echo "********************************************************************"
                echo -e "VPN interface vanished; Network connectivity has been disabled."
                echo "********************************************************************"
                if [[ $ECHO == "1" ]]; then echo "[$(date +%H:%M:%S)]: VPN died; networking disabled."; fi
 
                ## As the network connection was killed, we can stop looking if the interface still exists
                break
            fi
 
            ## if $INTERFACE is still there... check again after the time specified in $VPN_DROPPED_CHECK passed.
            if [[ $ECHO == "1" ]]; then echo "[$(date +%H:%M:%S)]: VPN is ok."; fi
            sleep $VPN_DROPPED_CHECK
        done
 
    fi
 
    ## if the script reaches this point, there's no VPN connection at the time.
    ## the script will wait the time set in $VPN_EXISTS_CHECK for the next check.
    sleep $VPN_EXISTS_CHECK
 
done
