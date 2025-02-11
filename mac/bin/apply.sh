#!/bin/bash
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
ansible-playbook -i "localhost," -c local "$SCRIPT_DIR/../main.yml" --ask-become-pass