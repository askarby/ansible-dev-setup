#!/bin/bash
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# Update path
HOMEBREW_BIN="/opt/homebrew/bin"
export PATH=$HOMEBREW_BIN:$PATH

# Run playbook
ansible-playbook -i "localhost," -c local "$SCRIPT_DIR/../main.yml" --ask-become-pass