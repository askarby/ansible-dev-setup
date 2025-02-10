#!/bin/bash
SCRIPT_DIR =$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
ansible-playbook -i "localhost," -c local d "$BASH_SOURCE/../../ansible_dev_mac.yml" --ask-become-pass