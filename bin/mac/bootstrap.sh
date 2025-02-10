#!/bin/bash

echo #

######################
# Xcode installation #
######################
xcode-select -p  > /dev/null 2> /dev/null

if [ $? -ne 0 ]; then
    echo "[INFO] Xcode doesn't seem to have been installed - launching installer"
    echo ""
    echo "... please look for Xcode installation window (should be visible on screen, or at least in Dock)"
    echo "    when installation is done, run this command again!"
    echo ""

    xcode-select --install
    exit 1
else 
    echo "[INFO] Xcode seems to be installed, moving on to next step!"
fi

###################
# Install Ansible #
###################
pip3 list | grep ansible
if [ $? -ne 0 ]; then
    echo "[INFO] Ansible doesn't seem to have been installed - installing!"
    echo ""
    sudo pip3 install --ignore-installed ansible
else 
    echo "[INFO] Ansible seems to be installed, moving on to next step!"
fi

################################
# Install Ansible requirements #
################################
ansible-galaxy install -r requirements.yml
