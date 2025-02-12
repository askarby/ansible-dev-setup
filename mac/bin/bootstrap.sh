#!/bin/bash
#
#  ____   ___   ___  ______  ___________ ____   ____ ____  
# |    \ /   \ /   \|      |/ ___|      |    \ /    |    \ 
# |  o  |     |     |      (   \_|      |  D  |  o  |  o  )
# |     |  O  |  O  |_|  |_|\__  |_|  |_|    /|     |   _/ 
# |  O  |     |     | |  |  /  \ | |  | |    \|  _  |  |   
# |     |     |     | |  |  \    | |  | |  .  |  |  |  |   
# |_____|\___/ \___/  |__|   \___| |__| |__|\_|__|__|__|   
#  Ansible Configuration
#
# ... This installs pre-requirements, clones required repositories
#     to allow for performing the Ansible installation!

# Get absolute path to "bin"-folder
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# Various (script) inclusions
. $SCRIPT_DIR/_util.sh

#################################################
# Configuration (setup variables used in script #
#################################################
# Include configuration script
. $SCRIPT_DIR/_config.sh

# Github repositories
REPO_ANSIBLE=https://github.com/askarby/ansible-dev-setup.git
REPO_DOTFILES=https://github.com/askarby/dotfiles

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
    echo ""
fi

####################################
# Clone ansible (setup) repository #
####################################
if [ -d "$DEV_SETUP_HOME/.git" ]; then
  echo "[INFO] Github repository (with ansible setup) has been cloned, updating it instead!"
  echo ""
  git --git-dir="$DEV_SETUP_HOME/.git" pull origin main
  echo ""
else 
  echo "[INFO] Github repository (with ansible setup) has NOT been cloned, cloning into: $DEV_SETUP_HOME..."
  echo ""
  git clone $REPO_ANSIBLE $DEV_SETUP_HOME
  echo ""
fi

#############################
# Clone dotfiles repository #
#############################
if [ -d "$DOTFILES_STOW" ]; then
  echo "[INFO] Github repository (with dot files) has been cloned, updating it instead!"
  echo ""
  git --git-dir="$REPO_DOTFILES/.git" pull origin main
  echo ""
else 
  echo "[INFO] Github repository (with dot files) has NOT been cloned, cloning into: $DOTFILES_STOW..."
  echo ""
  git clone $REPO_DOTFILES $DOTFILES_STOW
  echo ""
fi

####################
# Install Homebrew #
####################
if [ -d "$HOMEBREW_BIN" ]; then
  echo "[INFO] Homebrew seems to be installed, moving on to next step!"
  echo ""
else
  echo "[INFO] Homebrew does not seem to be installed - installing it!"
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo ""
fi

###################
# Install Ansible # 
###################
pip3 list | grep ansible
if [ $? -ne 0 ]; then
    echo "[INFO] Ansible doesn't seem to have been installed - installing!"
    echo ""
    echo "... you'll be prompted to enter your password to run as superuser"
    echo ""

    sudo pip3 install --ignore-installed ansible
    echo ""
else 
    echo "[INFO] Ansible seems to be installed, moving on to next step!"
    echo ""
fi

######################################
# Install (add) Ansible requirements #
######################################
echo "[INFO] Adding requirements to Ansible Galaxy!"
ansible-galaxy install -r "$DEV_SETUP_HOME/mac/requirements.yml"
echo ""

echo "[INFO] Bootstrap completed!"
echo ""
echo "... you're now ready to install ansible packages, go ahead and invoke: $DEV_SETUP_HOME/mac/bin/apply.sh!"