#!/bin/sh

# script-mainmenu.sh
# ==================================================
# Description
# This script provides a main menu for selecting various scripts related to macOS applications and configurations.
# It allows users to run scripts for installing applications, editing configurations, and accessing documentation.
# ==================================================
# Usage
# Run this script from script-init.sh
# ==================================================


echo "Starting script-mainmenu.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""

# function to show the menu
function show_menu() {
    echo " "
    echo "  ================================================================================"
    echo "                                   Select Script"
    echo "  ================================================================================"
    echo " "
    echo "    1) All apps"
    echo "    2) Edit list of apps for Script1"
    echo " "
    # echo "    3) Microsoft Office"
    echo " "
    echo "    4) All config"
    echo " "
    echo "    7) VLS"
    echo " "
    echo "    8) Readme"
    echo "    9) Exit"
    echo " "
    echo "    Others"
    echo "    11) Install Homebrew"
    echo " "
}

# main loop
until [[ $selection -eq 9 ]]
do

    # show the menu
    show_menu
    read -p "  Enter number to select an option: " selection

    # clear screen
    clear

    # do
    case $selection in
        1)
            source ./script-allapps.sh
            ;;
        2)
            open -a TextEdit.app values.sh
            ;;
        3)
            # source ./script-msoffice.sh
            ;;
        4)
            source ./script-endusersettings.sh
            ;;
        5)
            # source ./script5.sh
            ;;
        6)
            # source ./script6.sh
            ;;
        7)
            source ./script-kms.sh
            ;;
        8)
            source ./script-readme.sh
            ;;
        9)
            # exit
            ;;
        11)
            source ./script-homebrew.sh
            ;;
        *)
            # default
            read -p "Press Enter to continue...: "
            ;;
    esac

done

echo " "

echo "Terminating script-mainmenu.sh ..."


# ==================================================
# Notes
# ==================================================
