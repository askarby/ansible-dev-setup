#!/bin/bash
#
#   ____ ____  ____  _     __ __ 
#  /    |    \|    \| |   |  |  |
# |  o  |  o  |  o  | |   |  |  |
# |     |   _/|   _/| |___|  ~  |
# |  _  |  |  |  |  |     |___, |
# |  |  |  |  |  |  |     |     |
# |__|__|__|  |__|  |_____|____/    
# Ansible Configuration
#
# ... This installs performs the actual Ansible execution!

# Get absolute path to "bin"-folder
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# Various (script) inclusions
. $SCRIPT_DIR/_util.sh

#################################################
# Configuration (setup variables used in script #
#################################################
# Include configuration script
. $SCRIPT_DIR/_config.sh

#########################################
# Update path (required to run dockutil #
#########################################
export PATH=$HOMEBREW_BIN:$PATH

############################################
# Check Repositories have been checked out #
############################################
assert_directory_exists "$DEV_SETUP_HOME" "[ERROR] Ansible repository has not been checked out, consider running bootstrap.sh first!"
assert_directory_exists "$DOTFILES_STOW" "[ERROR] .dotfiles repository has not been checked out, consider running bootstrap.sh first!"

################
# Run playbook #
################
ansible-playbook -i "localhost," -c local "$SCRIPT_DIR/../main.yml" --ask-become-pass