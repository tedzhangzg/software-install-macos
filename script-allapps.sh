#!/bin/sh

# script-allapps.sh
# ==================================================
# Description
# This script installs a set of applications on macOS.
# It includes both online and offline installation modes.
# It allows the user to select the macOS version, app architecture, and installation mode.
# It also provides a list of applications to choose from.
# ==================================================
# Usage
# Run this script in the terminal.
# ==================================================


echo "Starting script-allapps.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""

# create temp folder
tmpdir="$HOME/Downloads/tempappinstall"
mkdir "$tmpdir"

echo " "
echo "================================================================================"
echo "Script - Install all apps"
echo "================================================================================"
echo " "

# processor architecture
echo "Processor architecture"
# autodetect
echo "Autodetect processor architecture: $(autodetectProcessorArchitecture)"
# list
echo "(1) ARM (Apple Silicon)"
echo "(2) Intel"
# ask
while [[ ! $appInstallerArchitecture =~ ^[0-9]+$ ]] || [[ $appInstallerArchitecture -lt "1" ]] || [[ $appInstallerArchitecture -gt "2" ]]
do
    read -p "Enter number : " appInstallerArchitecture
done

# architecture suffix
case $appInstallerArchitecture in
    1)
        # 1
        archSuffix="a64"
        ;;
    2)
        # 2
        archSuffix="x64"
        ;;
    *)
        # Default
        echo "Invalid architecture"
        ;;
esac

echo " "
echo " "

# macOS version
echo "macOS Version"
# autodetect
echo "Autodetect macOS Version: $(sw_vers -productVersion)"
# list
echo "macOS Versions"
# this will first display macOS 11-latest
# eg, 11 - macOS 11
# and so on
for (( i=$latest_macos_version ; i>=26 ; i-- ))
do
    echo $i" - macOS "$i
done
for (( i=15 ; i>=11 ; i-- ))
do
    echo $i" - macOS "$i
done
echo "10 - macOS 10.15"
echo "9 - macOS 10.13"
echo "8 - OS X 10.11"
echo "7 - Mac OS X 10.7"
echo "6 - Mac OS X 10.6 and earlier"
##############################
# ask
while \
      [[ ! $macos_version =~ ^[0-9]+$ ]] || \
      (( $macos_version < 6 )) || \
      (( $macos_version >= 16 && $macos_version <= 25 )) || \
      (( $macos_version > $latest_macos_version ))
do
    read -p "Enter number - macOS Version : " macos_version
done

echo " "
echo " "

# mode
echo "Mode"
# list
echo "1 - Online Install"
echo "2 - Offline Install"
# ask
while [[ ! $mode_onoffdown =~ ^[0-9]+$ ]] || [[ $mode_onoffdown -lt "1" ]] || [[ $mode_onoffdown -gt "3" ]]
do
    read -p "Enter number - (1) Online Install , (2) Offline Install : " mode_onoffdown
done

echo " "
echo " "

# Documentation
##################################################
##################################################
echo "List of Apps"
##################################################
echo "---------- PreReq ----------"
echo "1 Rosetta 2 on Apple Silicon"
echo "2 Homebrew"
echo "3 enable - Developer mode"
##################################################
echo "---------- macOS Components ----------"
echo "11 XQuartz"
##################################################
echo "---------- Dev Env ----------"
echo "81 Python 3"
echo "82 Python 2"
##################################################
echo "---------- Dev IDEs ----------"
echo "91 Sublime Text"
##################################################
##################################################
echo "##############################"
echo "------------------------------"
echo "100 ---------- Restart ----------"
echo "------------------------------"
echo "##############################"
##################################################
##################################################
echo "---------- System Apps ----------"
echo "101 Microsoft PowerShell"
# echo "102 Microsoft Windows Terminal"
echo "103 Microsoft Visual Studio Code"
# echo "104 Microsoft Windows Subsystem for Linux"
echo "105 Microsoft dot NET Latest"
##################################################
echo "---------- Apple Apps ----------"
# echo "111 Apple iTunes"
##################################################
echo "---------- Microsoft Apps ----------"
echo "121 Microsoft Edge"
echo "122 Microsoft Teams"
echo "123 Microsoft Skype"
# echo "124 Microsoft Windows Essentials"
##################################################
echo "---------- Google Apps ----------"
echo "131 Google Chrome"
echo "132 Google Drive"
##################################################
echo "---------- Amazon Apps ----------"
##################################################
echo "---------- Meta Apps ----------"
echo "141 Meta Messenger"
##################################################
echo "---------- Adobe Apps ----------"
echo "151 Adobe Acrobat Reader"
##################################################
echo "---------- Cloud Apps ----------"
echo "161 Dropbox"
##################################################
echo "---------- Communication Apps ----------"
echo "171 Zoom"
echo "172 Discord"
echo "173 Telegram"
echo "174 WhatsApp"
echo "175 WeChat"
##################################################
echo "---------- Utilities Apps ----------"
echo "181 TeamViewer"
echo "182 Archiving - RAR Keka"
echo "183 VLC"
echo "184 Java 8"
echo "185 VPN - OpenVPN WireGuard"
echo "186 Firefox"
echo "187 Thunderbird"
echo "188 OBS"
echo "190 LibreOffice"
##################################################
echo "---------- Office Apps ----------"
echo "200 Microsoft Office"
##################################################
echo "---------- Miscellaneous ----------"
echo ""
##################################################
##################################################

# app numbers to install
# from
while [[ ! $appnum_toinstall_from =~ ^[0-9]+$ ]] || [[ $appnum_toinstall_from < "0" ]] || [[ $appnum_toinstall_from -gt "200" ]]
do
    read -p "Enter number - App number to install from : " appnum_toinstall_from
done
# to
while [[ ! $appnum_toinstall_to =~ ^[0-9]+$ ]]
do
    read -p "Enter number - App number to install to : " appnum_toinstall_to
done
if [[ $appnum_toinstall_to -lt $appnum_toinstall_from ]]
then
    appnum_toinstall_to=200
fi

echo " "
echo " "

# Rosetta 2 for Apple Silicon Macs
# 
# param
app_num=1
appnum_toinclude=$appnum_toinclude_Rosetta2
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then
    if [[ $appInstallerArchitecture -eq "1" ]]
    then
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
        echo " "
    fi
fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Homebrew
# 
# param
app_num=2
appnum_toinclude=$appnum_toinclude_Homebrew
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then
    source ./script-homebrew.sh
    # brew tap homebrew/core
    # brew tap homebrew/cask

    echo " "
    echo " "
    echo "Script will exit."
    echo " "
    echo "Next steps"
    echo "..."
    echo "Close and re-open Terminal"
    echo "cd to script location"
    echo "Launch script"
    echo "Install from next item onwards"
    echo " "
    exit

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# enable - Developer mode
# 
# param
app_num=3
appnum_toinclude=$appnum_toinclude_enableDevMode
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then
    sudo DevToolsSecurity -enable
    echo " "
fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# XQuartz
# 
# param
app_num=11
appnum_toinclude=$appnum_toinclude_XQuartz
app_brewname="xquartz"
dir_installer="XQuartz""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Python 3
# 
# param
app_num=81
appnum_toinclude=$appnum_toinclude_Python3
app_brewname="python"
dir_installer="Python3""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$url_python3
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Python 2
# 
# param
app_num=82
appnum_toinclude=$appnum_toinclude_Python2
app_brewname="python@2"
dir_installer="Python2""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$url_python3
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Sublime Text
# 
# param
app_num=91
appnum_toinclude=$appnum_toinclude_SublimeText
app_brewname="sublime-text"
dir_installer="SublimeText""a64x64"
app_name_partial="Sublime"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Restart
# 
# param
app_num=100
appnum_toinclude=$appnum_toinclude_RestartMidway
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then
    sudo reboot
fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft PowerShell
# 
# param
app_num=101
appnum_toinclude=$appnum_toinclude_PowerShell
app_brewname="powershell"
dir_installer="Powershell""$archSuffix"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft Visual Studio Code
# 
# param
app_num=103
appnum_toinclude=$appnum_toinclude_VSCode
app_brewname="visual-studio-code"
url_appspecific="$url_vscode"
dir_installer="VSCode""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$url_appspecific
            downloadInstaller "$url" "$dir_installer"
            # Rename
            mv "$dir_installer/$(ls $dir_installer)" "$dir_installer/VSCode-darwin-universal.zip"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft dot NET Latest
# 
# param
app_num=105
appnum_toinclude=$appnum_toinclude_dotnetlatest
app_brewname="dotnet"
dir_installer="dotNET""$archSuffix"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft Edge
# 
# param
app_num=121
appnum_toinclude=$appnum_toinclude_Edge
app_brewname="microsoft-edge"
dir_installer="Edge""$archSuffix"
# 
# main Install/Download/Execute

if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft Teams
# 
# param
app_num=122
appnum_toinclude=$appnum_toinclude_Teams
app_brewname="microsoft-teams"
dir_installer="Teams""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft Skype
# 
# param
app_num=123
appnum_toinclude=$appnum_toinclude_Skype
app_brewname="skype"
dir_installer="Skype""a64x64"
app_name_partial="Skype"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Google Chrome
# 
# param
app_num=131
appnum_toinclude=$appnum_toinclude_Chrome
app_brewname="google-chrome"
dir_installer="Chrome""a64x64"
app_name_partial="Chrome"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Google Drive
# 
# param
app_num=132
appnum_toinclude=$appnum_toinclude_Drive
app_brewname="google-drive"
dir_installer="GoogleDrive""a64x64"
app_name_partial="Drive"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgInstallPkgAtRoot "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Meta Messenger
# 
# param
app_num=141
appnum_toinclude=$appnum_toinclude_Messenger
app_brewname="messenger"
dir_installer="Messenger""a64x64"
app_name_partial="Messenger"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgInstallPkgAtRoot "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Adobe Acrobat Reader
# 
# param
app_num=151
appnum_toinclude=$appnum_toinclude_AcrobatReader
app_brewname="adobe-acrobat-reader"
dir_installer="AcrobatReader""a64x64"
app_name_partial="AcroRdr"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgInstallPkgAtRoot "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Dropbox
# 
# param
app_num=161
appnum_toinclude=$appnum_toinclude_Dropbox
app_brewname="dropbox"
dir_installer="Dropbox""$archSuffix"
app_name_partial="Dropbox"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
            # Rename
            mv "$dir_installer/$(ls $dir_installer)" "$dir_installer/Dropbox_ver.dmg"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgInstallApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Zoom
# 
# param
app_num=171
appnum_toinclude=$appnum_toinclude_Zoom
app_brewname="zoom"
dir_installer="Zoom""$archSuffix"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            pkgInstall "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Discord
# 
# param
app_num=172
appnum_toinclude=$appnum_toinclude_Discord
app_brewname="discord"
dir_installer="Discord""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Telegram
# 
# param
app_num=173
appnum_toinclude=$appnum_toinclude_Telegram
app_brewname="telegram"
dir_installer="Telegram""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# WhatsApp
# 
# param
app_num=174
appnum_toinclude=$appnum_toinclude_WhatsApp
app_brewname="whatsapp"
dir_installer="WhatsApp""a64x64"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# WeChat
# 
# param
app_num=175
appnum_toinclude=$appnum_toinclude_WeChat
app_brewname="wechat"
dir_installer="WeChat""a64x64"
app_name_partial="WeChat"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# TeamViewerLatest
# 
# param
app_num=181
appnum_toinclude=$appnum_toinclude_TeamViewer
app_brewname="teamviewer"
dir_installer="TeamViewerLatest""a64x64"
app_name_partial="TeamViewer"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgInstallPkgAtAppcontres "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# TeamViewerQS
# 
# param
app_num=181
appnum_toinclude=$appnum_toinclude_TeamViewer
app_brewname="teamviewer"
url_appspecific="$url_teamviewerqs_13"
dir_installer="TeamViewerQS13""x64"
app_name_partial="TeamViewerQS"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    # Download
    if [[ ! -d "$dir_installer" ]]
    then
        url=$url_appspecific
        downloadInstaller "$url" "$dir_installer"
    fi
    if [[ $mode_onoffdown != "3" ]]
    then
        # Offline
        dmgCopyApp "$dir_installer" "$app_name_partial"
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# RAR
# 
# param
app_num=182
appnum_toinclude=$appnum_toinclude_Keka
app_brewname="rar"
dir_installer="RAR""$archSuffix"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            ########## START OF CODE FOR OFFLINE INSTALL ##################################################
            # Almost same as uncompressFileCopyApp "$dir_installer"

            echo "Installing $dir_installer ..."

            # cd
            pushd "$dir_installer"

            # Get name
            compressedFileName="$(ls | egrep '\.tar.gz$')"

            # Here is where it gets different, as pkg file is located inside some subdirectory

            # Install
            tar -xf $compressedFileName -C /Applications

            # Add to env
            echo 'export PATH="/Applications/rar:$PATH"' >> ~/.zshrc
            echo 'export PATH="/Applications/rar:$PATH"' >> ~/.bash_profile

            # End of Here is where it gets different, as pkg file is located inside some subdirectory

            # cd
            popd

            echo "... Done installing $dir_installer"

            ########## END OF CODE FOR OFFLINE INSTALL ##################################################
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Keka
# 
# param
app_num=182
appnum_toinclude=$appnum_toinclude_Keka
app_brewname="keka"
dir_installer="Keka""a64x64"
app_name_partial="Keka"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# VLC
# 
# param
app_num=183
appnum_toinclude=$appnum_toinclude_VLC
app_brewname="vlc"
dir_installer="VLC""$archSuffix"
app_name_partial="VLC"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Java 8
# 
# param
app_num=184
appnum_toinclude=$appnum_toinclude_Java8
app_brewname="java"
url_appspecific="$url_javajre_8_x64"
dir_installer="Java""x64"
app_name_partial="Java"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    # Download
    if [[ ! -d "$dir_installer" ]]
    then
        url=$url_appspecific
        downloadInstaller "$url" "$dir_installer"
    fi
    if [[ $mode_onoffdown != "3" ]]
    then
        # Offline
        dmgInstallPkgAtAppcontres "$dir_installer" "$app_name_partial"
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# OpenVPN
# 
# param
app_num=185
appnum_toinclude=$appnum_toinclude_OpenVPN
app_brewname="openvpn-connect"
dir_installer="OpenVPN""a64x64"
app_name_partial="OpenVPN"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            ########## START OF CODE FOR OFFLINE INSTALL ##################################################
            # Almost same as dmgInstallPkgAtRoot "$dir_installer" "$app_name_partial"

            echo "Installing $1 ..."

            # Get dmg filename
            filename_dmg="$(ls $dir_installer | egrep '\.dmg$')"

            # Mount dmg
            hdiutil attach -quiet -nobrowse -noverify "$dir_installer/$filename_dmg"

            # Get volume name of mounted dmg
            name_vol_final="$(ls /Volumes | egrep $app_name_partial)"

            # Here is where it gets different, as pkg file is located inside some subdirectory
            # Almost same as pkgInstall "$dir_installer"

            # Install
            # pkgInstall "/Volumes/$name_vol_final"

            # cd
            pushd "/Volumes/$name_vol_final"

            # Get name
            if [[ $appInstallerArchitecture -eq 1 ]]
            then
                pkgName="$(ls | egrep '\.pkg$' | grep 'arm')"
            else
                pkgName="$(ls | egrep '\.pkg$' | grep 'x86')"
            fi

            # Install
            sudo installer -pkg "$pkgName" -target /

            # cd
            popd

            # End of Here is where it gets different, as pkg file is located inside some subdirectory

            # Unmount dmg
            hdiutil detach -quiet "/Volumes/$name_vol_final"

            echo "... Done installing $1"

            ########## END OF CODE FOR OFFLINE INSTALL ##################################################
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# WireGuard
# 
# param
app_num=185
appnum_toinclude=$appnum_toinclude_WireGuard
app_brewname="wireguard-tools"
dir_installer="WireGuard""a64x64"
app_name_partial="WireGuard"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Firefox
# 
# param
app_num=186
appnum_toinclude=$appnum_toinclude_Firefox
app_brewname="firefox"
dir_installer="Firefox""a64x64"
app_name_partial="Firefox"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Thunderbird
# 
# param
app_num=187
appnum_toinclude=$appnum_toinclude_Thunderbird
app_brewname="thunderbird"
dir_installer="Thunderbird""a64x64"
app_name_partial="Thunderbird"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "a64x64")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# OBS
# 
# param
app_num=188
appnum_toinclude=$appnum_toinclude_OBS
app_brewname="obs"
dir_installer="OBS""$archSuffix"
app_name_partial="OBS"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# LibreOffice
# 
# param
app_num=190
appnum_toinclude=$appnum_toinclude_LibreOffice
app_brewname="libreoffice"
dir_installer="LibreOffice""$archSuffix"
app_name_partial="LibreOffice"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then

    if [[ $mode_onoffdown = "1" ]]
    then
        # Online
        brew install --cask $app_brewname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_brewname" "$archSuffix")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # Offline
            dmgCopyApp "$dir_installer" "$app_name_partial"
        fi
    fi

    echo " "

fi
# 
# clear param
# unset appnum_toinclude
# 
# done

# Microsoft Office
# 
# param
app_num=200
appnum_toinclude=$appnum_toinclude_Office
app_brewname="microsoft-office"
dir_installer="Office"
# 
# main Install/Download/Execute
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($appnum_toinclude -eq "1") ]]
then
    source ./script-msoffice.sh
    echo " "
fi
# 
# clear param
# unset appnum_toinclude
# 
# done

echo " "

# final

# unset variables
unset appInstallerArchitecture
unset archSuffix
unset macos_version
unset mode_onoffdown
unset appnum_toinstall_from
unset appnum_toinstall_to

# rm temp folder
sudo rm -rf $tmpdir

# clear trash
# sudo rm -rf /var/root/.Trash
# sudo rm -rf $HOME/.Trash

# clear Terminal history
# clearTerminalHistory

echo " "

read -p "Press Enter to continue...: "

echo " "

echo "Terminating script-allapps.sh ..."


# ==================================================
# Notes
# ==================================================

# install older versions of cask formulae
# 
# get link to raw rb file of specific commit from github
# https://raw.githubusercontent.com/Homebrew/homebrew-cask/<commit-id>/Casks/m/name-of-cask-formula.rb
# 
# crreate new local tap
# brew tap-new local/old-casks
# 
# prep dir
# cd "$(brew --repository)/Library/Taps/local/homebrew-old-casks"
# mkdir -p Casks
# cd ./Casks
# 
# download rb file
# curl -L -O <link-to-rb>
# 
# install
# brew install --cask local/old-casks/name-of-cask-formula
# 
# prevent update
# brew pin name-of-cask-formula
# 
# clean up tap
# brew untap local/old-casks
# rm -rf "$(brew --repository)/Library/Taps/local/homebrew-old-casks"
# 
# done
