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
# 
# array
# 
# 0
array_filenames[0]="script-mainmenu.sh"
array_ghlinks[0]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-mainmenu.sh"
# 
# 1
array_filenames[1]="urls.sh"
array_ghlinks[1]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/urls.sh"
# 
# 2
array_filenames[2]="values.sh"
array_ghlinks[2]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/values.sh"
# 
# 3
array_filenames[3]="script-homebrew.sh"
array_ghlinks[3]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-homebrew.sh"
# 
# 4
array_filenames[4]="script-allapps.sh"
array_ghlinks[4]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-allapps.sh"
# 
# 5
array_filenames[5]="script-msoffice.sh"
array_ghlinks[5]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-msoffice.sh"
# 
# 6
array_filenames[6]="script-kms.sh"
array_ghlinks[6]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-kms.sh"
# 
# 7
array_filenames[7]="script-endusersettings.sh"
array_ghlinks[7]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-endusersettings.sh"
# 
# 8
array_filenames[8]="script-uninstall.sh"
array_ghlinks[8]="https://raw.githubusercontent.com/tedzhangzg/software-install-macos/main/script-uninstall.sh"

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
