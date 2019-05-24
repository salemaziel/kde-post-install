#!/bin/bash

echo " ** installing Google Cloud Platform SDK commandline tools ** "
cd ; export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" 
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update
sudo apt install google-cloud-sdk
gcloud components update
