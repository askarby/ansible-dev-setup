#!/bin/bash

echo #

######################
# Xcode installation #
######################
xcode-select -p  > /dev/null 2> /dev/null

if [ $? -ne 0 ]; then
    echo "[INFO] Xcode (command line developer tools) doesn't seem to have been installed - launching installer"
    echo ""
    echo "... please look for Xcode installation window (should be visible on screen, or at least in Dock)"
    echo "    when installation is done, run this command again!"
    echo ""

    xcode-select --install
    exit 1
else 
    echo "[INFO] Xcode seems to be installed, moving on to next step!"
fi

####################
# Clone repository #
####################
DEV_SETUP_HOME="$HOME/.ansible-dev-setup"
if [ -d "$DEV_SETUP_HOME/.git" ]; then
  echo "[INFO] Github repository has been cloned, updating it instead!"
  git --git-dir="$DEV_SETUP_HOME/.git" pull origin main

else 
  echo "[INFO] Github repository has NOT been cloned, cloning into: $DEV_SETUP_HOME..."
  git clone https://github.com/askarby/ansible-dev-setup.git $DEV_SETUP_HOME
fi

###################
# Install Ansible #cd 
###################
pip3 list | grep ansible
if [ $? -ne 0 ]; then
    echo "[INFO] Ansible doesn't seem to have been installed - installing!"
    echo ""
    echo "... you'll be prompted to enter your password to run as superuser"
    echo ""

    sudo pip3 install --ignore-installed ansible
else 
    echo "[INFO] Ansible seems to be installed, moving on to next step!"
fi

################################
# Install Ansible requirements #
################################
echo "[INFO] Adding requirements to Ansible Galaxy!"
ansible-galaxy install -r "$DEV_SETUP_HOME/requirements.yml"

echo "[INFO] Bootstrap completed!"
echo ""
echo "... you're now ready to install ansible packages, go ahead and invoke: $DEV_SETUP_HOME/bin/mac/apply.sh!"