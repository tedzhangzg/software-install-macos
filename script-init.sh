#!/bin/sh

# script-init.sh
# ==================================================
# Description
# This script initializes the environment for the macOS scripts.
# It downloads necessary files from GitHub, sets permissions,
# and sources the required scripts.
# ==================================================
# Usage
# Run this script to set up the environment before using other scripts.
# ==================================================


echo "Starting script-init.sh ..."

# define ordered hash table of filenames and GitHub links
declare -a array_filenames
declare -a array_ghlinks
# populate
array_filenames[0]="functions.sh"
array_ghlinks[0]="https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.sh"
array_filenames[1]="urls.sh"
array_ghlinks[1]="https://raw.githubusercontent.com/tedzhangzg/scripts/main/urls.sh"

# loop over all key value pairs
for i in "${!array_filenames[@]}"
do
    filename="${array_filenames[$i]}"
    ghlink="${array_ghlinks[$i]}"
    # check, download
    if ! [ -f "$filename" ]
    then
        curl -L -O "$ghlink"
    fi
done

# make executable
chmod +x *

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# clear screen
clear

# run main menu script
source ./script-mainmenu.sh

echo " "

echo "Terminating script-init.sh ..."


# ==================================================
# Notes
# ==================================================
