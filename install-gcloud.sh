#!/bin/bash

cd ; export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" 

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 

echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

touch ~/connect2zammad.sh
echo "#!/bin/bash" >> ~/connect2zammad.sh
echo "ssh -i /home/$USER/.ssh/google_compute_engine -L 3001:localhost:3001 $USER@calegix.net" >> ~/connect2zammad.sh
echo "google-chrome --new-window http://localhost:3001" >> ~/connect2zammad.sh
chmod +x ~/connect2zammad.sh

sudo apt update

sudo apt -y install google-cloud-sdk

gcloud init
