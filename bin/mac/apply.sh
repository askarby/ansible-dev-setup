#!/bin/sh
ansible-playbook -i "localhost," -c local ansible_dev_mac.yml --ask-become-pass