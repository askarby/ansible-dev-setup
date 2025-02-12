#!/bin/bash
if [ ${0##*/} == ${BASH_SOURCE[0]##*/} ]; then 
    echo "WARNING"
    echo "This script is not meant to be executed directly!"
    echo "Use this script only by sourcing it."
    echo
    exit 1
fi

# Home directories
export DEV_SETUP_HOME="$HOME/.ansible-dev-setup"
export DOTFILES_STOW="$HOME/.dotfiles"

# Homebrew bin folder
export HOMEBREW_BIN="/opt/homebrew/bin"