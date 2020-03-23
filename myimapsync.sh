#!/bin/bash

#!/bin/sh
# $Id: imapsync_example.sh,v 1.6 2016/01/21 03:35:15 gilles Exp gilles $

# imapsync example shell for Unix users
# lines beginning with # are just comments 

# See http://imapsync.lamiral.info/#doc
# for more details on how to use imapsync.

# Replace below the 6 parameters  
# "test1.lamiral.info"  "test1"  "secret1"  "test2.lamiral.info"  "test2"  "secret2"
# with your own values
# Double quotes are necessary if a value contain one or more blanks.

# value for --host1 is the IMAP source server hostname or IP address
# value for --user1 is the IMAP source user login
# value for --password1 is the IMAP source user password

# value for --host2 is the IMAP destination server hostname or IP address
# value for --user2 is the IMAP destination user login
# value for --password2 is the IMAP destination user password

# Character \ at the end of the first line is essential and means
# "this command continues on the next line". You can add other lines
# but don't forget \ character lasting each line, except the last one.

# Three other options are in this example because they are good to start with
#
# --dry makes imapsync doing nothing, just print what would be done without --dry.
# 
# --justfolders does only things about folders (ignore messages). It is good
# to verify the folder mapping is good for you.
#
# --automap guesses folders mapping, for folders like 
#           "Sent", "Junk", "Drafts", "All", "Archive", "Flagged".
#
# I suggest to start with --automap --justfolders --dry.
# If the folder mapping is not good then add some --f1f2 fold1=fold2
# to fix it.
# Then remove --dry and have a run to create folders on host2.
# If everything goes well so far then remove --justfolders to
# start syncing messages.
# Check FAQs at http://imapsync.lamiral.info/FAQ.d


read -p "IMAP source server hostname or IP address? " source_host
read -p "Source Account Email Address? " source_email
read -p "Source Account Email Password? " source_pass
read -p "Destination IMAP server hostname or IP address? " dest_host
read -p "Destination Account Email Address? " dest_email
read -p "Destination Account Email Password? " dest_pass

echo " ** Doing a Trial run first; folders only ** "
imapsync --host1 $source_host --user1 $source_email --password1 $source_pass \
           --host2 $dest_host --user2 $dest_email --password2 $dest_pass \
           --automap --justfolders --dry "$@"

sleep 3
echo " ** Trial done: Folders will have been mapped ** "
sleep 3

read -p "Have the folders been mapped correctly?[y/n] " fmap_correct
if test $fmap_correct == "n"; then
    echo " ** Please remove --justfolders parameter and add --f1f2 fold1=fold2 parameter manually in order to map your Email folders correctly ** "
    exit 1
else
    echo " ** Ok, creating and mapping folders for real this time. Still folders only, no messages **"
fi

imapsync --host1 $source_host --user1 $source_email --password1 $source_pass \
           --host2 $dest_host --user2 $dest_email --password2 $dest_pass \
           --automap --justfolders "$@"

echo " ** Check the Destination email host to verify your folders were made correctly ** "
sleep 5

read -p " ** Have the folders been mapped correctly?[y/n] ** " fmap_correct_real
if test $fmap_correct_real == "n"; then
    echo " ** Please remove --justfolders parameter and add --f1f2 fold1=fold2 parameter manually in order to map your Email folders correctly ** "
    exit 1
else
    echo " ** Ok, now lets sync your messages! ** "
fi

imapsync --host1 $source_host --user1 $source_email --password1 $source_pass \
           --host2 $dest_host --user2 $dest_email --password2 $dest_pass \
           --automap "$@"


