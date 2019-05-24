#!/bin/bash

echo " ***********installing Inxi (System/Hardware Identifier) ******** "
wget -O inxi https://github.com/smxi/inxi/raw/master/inxi
chmod +x inxi 
sudo mv inxi /usr/local/bin/inxi
