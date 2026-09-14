#!/bin/sh

# script-msoffice.sh
# ==================================================
# Description
# This script installs Microsoft Office on macOS.
# It handles different versions of macOS and installs the appropriate version of Office.
# It also includes functionality to disable OneDrive updates if necessary.
# It can install Office via Homebrew or download the installer directly.
# It also includes the option to install a Volume License Service (VLS) for Office.
# ==================================================
# Usage
# Run this script in the terminal with appropriate permissions.
# It will prompt for any necessary user input and handle the installation process.
# Ensure that the required URLs and values are defined in the included files.
# ==================================================


echo "Starting script-msoffice.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""

echo " "
echo "================================================================================"
echo "Script - Install Microsoft Office"
echo "================================================================================"
echo " "

# install vls
if [[ ($app_toinclude_OfficeVLS -eq "1") ]]
then
    source ./script-kms.sh
fi

# Set according to $macos_version
case $macos_version in
    27|26|15)
        # 26|15|14
        # macOS 26,15,14
        app_hbname="microsoft-office"
        dir_installer="Office2024""_""$arch_name"
        url=$(getURLFromBrew "$app_hbname")
        ;;
    14)
        # 14
        # macOS 14
        dir_installer="Office16v16112""_""$arch_name"
        url=$url_microsoft_office_16_v16112
        ;;

    13)
        # 13
        # macOS 13
        dir_installer="Office16v16101""_""$arch_name"
        url=$url_microsoft_office_16_v16101
        ;;
    12)
        # 12
        # macOS 12
        dir_installer="Office16v1689""_""$arch_name"
        url=$url_microsoft_office_16_v1689
        ;;
    11)
        # 11
        # macOS 11
        dir_installer="Office16v1677""_""$arch_name"
        url=$url_microsoft_office_16_v1677
        ;;
    10)
        # 10
        # macOS 10.15
        dir_installer="Office16v1666""_""$arch_name"
        url=$url_microsoft_office_16_v1666
        ;;
    9)
        # 9
        # macOS 10.13
        dir_installer="Office2019v1643""_""x64"
        url=$url_microsoft_office_2019_v1643
        ;;
    8)
        # 8
        # OS X 10.11
        dir_installer="Office2016v1616""_""x64"
        url=$url_microsoft_office_2016_v1616
        ;;
    7)
        # 7
        # Mac OS X 10.7
        dir_installer="Office2011""_""x86"
        url=$url_microsoft_office_2011
        ;;
    6)
        # 6
        # Mac OS X 10.6 and earlier
        dir_installer="Office2011""_""x86"
        url=$url_microsoft_office_2011
        ;;
    *)
        # Default
        echo "Manually download and install Microsoft Office ..."
        read -p "Press Enter to continue...: "
        exit
        ;;
esac


# install office
if [[ ("15" -le $macos_version) && ($macos_version -le "27") ]]
# macOS 27-26,15
then
    # Do case
    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_hbname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi
    # Done case
elif [[ ("6" -le $macos_version) && ($macos_version -le "14") ]]
# macOS 14-11,10.15-10.7
then
    # Do case
    if [[ ! -d "$dir_installer" ]]
    then
        downloadInstaller "$url" "$dir_installer"
    fi
    if [[ $mode_onoffdown != "3" ]]
    then
        # Offline
        pkgInstall "$dir_installer"
    fi
    # Done case
else
    # Do case Default
    echo "Manually download and install Microsoft Office ..."
    read -p "Press Enter to continue...: "
    # Done case Default
fi

echo " "

# final

echo " "

echo "Terminating script-msoffice.sh ..."


# ==================================================
# Notes
# ==================================================
