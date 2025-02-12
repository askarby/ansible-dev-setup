#!/bin/bash
if [ ${0##*/} == ${BASH_SOURCE[0]##*/} ]; then 
    echo "WARNING"
    echo "This script is not meant to be executed directly!"
    echo "Use this script only by sourcing it."
    echo
    exit 1
fi

assert_directory_exists () {
    local DIRECTORY="$1"
    local MESSAGE="$2" || "[ERROR] Directory '$DIRECTORY' doesn't exist"
    local EXIT_CODE="$3" || -1

    if [ ! -d "${DIRECTORY}" ]; then
        echo MESSAGE
        exit $EXIT_CODE
    fi
}