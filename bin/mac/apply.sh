#!/bin/bash
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
ansible-playbook -i "localhost," -c local "$SCRIPT_DIR/../../ansible_dev_mac.yml" --ask-become-pass