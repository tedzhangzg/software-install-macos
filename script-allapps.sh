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
echo "(1) arm64"
echo "(2) x86_64"
# echo "(3) i386"
# echo "(4) ppc64"
# echo "(5) ppc"
# ask
while [[ ! $appInstallerArchitecture =~ ^[0-9]+$ ]] || [[ $appInstallerArchitecture -lt "1" ]] || [[ $appInstallerArchitecture -gt "2" ]]
do
    read -p "Enter number : " appInstallerArchitecture
done

# architecture suffix
case $appInstallerArchitecture in
    1)
        # 1
        arch_name="a64"
        ;;
    2)
        # 2
        arch_name="x64"
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
echo "List of macOS Versions"
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
    # read -p "Enter number - (1) Online Install , (2) Offline Install : " mode_onoffdown
    echo "Enter number - (1) Online Install , (2) Offline Install : "
    mode_onoffdown=1
done
echo "CONFIRMED - mode: $mode_onoffdown"

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
# echo "123 Microsoft Windows Essentials"
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
app_toinclude=$app_toinclude_Rosetta2
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then
    if [[ $appInstallerArchitecture -eq "1" ]]
    then
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
        echo " "
    fi
fi
# 
# clear param
# unset app_toinclude
# 
# done

# Homebrew
# 
# param
app_num=2
app_toinclude=$app_toinclude_Homebrew
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
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
# unset app_toinclude
# 
# done

# enable - Developer mode
# 
# param
app_num=3
app_toinclude=$app_toinclude_enableDevMode
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then
    sudo DevToolsSecurity -enable
    echo " "
fi
# 
# clear param
# unset app_toinclude
# 
# done

# XQuartz
# 
# param
app_num=11
app_shortname="XQuartz"
app_toinclude=$app_toinclude_XQuartz
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="xquartz"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Python 3
# 
# param
app_num=81
app_shortname="Python3"
app_toinclude=$app_toinclude_Python3
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    # param
    app_hbname="python"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$url_python3
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        # install
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Python 2
# 
# param
app_num=82
app_shortname="Python2"
app_toinclude=$app_toinclude_Python2
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    # param
    app_hbname="python@2"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$url_python3
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Sublime Text
# 
# param
app_num=91
app_shortname="SublimeText"
app_toinclude=$app_toinclude_SublimeText
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="sublime-text"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Restart
# 
# param
app_num=100
app_shortname="RestartMidway"
app_toinclude=$app_toinclude_RestartMidway
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # restart
    sudo reboot

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft PowerShell
# 
# param
app_num=101
app_shortname="PowerShell"
app_toinclude=$app_toinclude_PowerShell
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") && ($macos_version -ge "11") ]]
then

    # param
    app_hbname="powershell"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft Visual Studio Code
# 
# param
app_num=103
app_shortname="VSCode"
app_toinclude=$app_toinclude_VSCode
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="visual-studio-code"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
            # rename
            mv "$dir_installer/$(ls $dir_installer)" "$dir_installer/VSCode-darwin-arm64.zip"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft dot NET Latest
# 
# param
app_num=105
app_shortname="dotNETlatest"
app_toinclude=$app_toinclude_dotNETlatest
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="dotnet"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft Edge
# 
# param
app_num=121
app_shortname="Edge"
app_toinclude=$app_toinclude_Edge
# 
# main

if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="microsoft-edge"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft Teams
# 
# param
app_num=122
app_shortname="Teams"
app_toinclude=$app_toinclude_Teams
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="microsoft-teams"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Google Chrome
# 
# param
app_num=131
app_shortname="Chrome"
app_toinclude=$app_toinclude_Chrome
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="google-chrome"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Google Drive
# 
# param
app_num=132
app_shortname="Drive"
app_toinclude=$app_toinclude_Drive
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="google-drive"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgInstallPkgAtRoot "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Meta Messenger
# 
# param
app_num=141
app_shortname="Messenger"
app_toinclude=$app_toinclude_Messenger
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="messenger"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
        # Rename
        mv "$dir_installer/$(ls $dir_installer)" "$dir_installer/Messenger_ver.dmg"
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Adobe Acrobat Reader
# 
# param
app_num=151
app_shortname="AcroRdr"
app_toinclude=$app_toinclude_AcrobatReader
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="adobe-acrobat-reader"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgInstallPkgAtRoot "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Dropbox
# 
# param
app_num=161
app_shortname="Dropbox"
app_toinclude=$app_toinclude_Dropbox
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="dropbox"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
            # Rename
            mv "$dir_installer/$(ls $dir_installer)" "$dir_installer/Dropbox_ver.dmg"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgInstallApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Zoom
# 
# param
app_num=171
app_shortname="Zoom"
app_toinclude=$app_toinclude_Zoom
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="zoom"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            pkgInstall "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Discord
# 
# param
app_num=172
app_shortname="Discord"
app_toinclude=$app_toinclude_Discord
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="discord"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Telegram
# 
# param
app_num=173
app_shortname="Telegram"
app_toinclude=$app_toinclude_Telegram
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="telegram"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# WhatsApp
# 
# param
app_num=174
app_shortname="WhatsApp"
app_toinclude=$app_toinclude_WhatsApp
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="whatsapp"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            uncompressFileCopyApp "$dir_installer"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# WeChat
# 
# param
app_num=175
app_shortname="WeChat"
app_toinclude=$app_toinclude_WeChat
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="wechat"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# TeamViewerLatest
# 
# param
app_num=181
app_shortname="TeamViewer"
app_toinclude=$app_toinclude_TeamViewer
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="teamviewer"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgInstallPkgAtAppcontres "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# TeamViewerQS
# 
# param
app_num=181
app_shortname="TeamViewerQS"
app_toinclude=$app_toinclude_TeamViewer
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="teamviewer"
    url_appspecific="$url_teamviewerqs_13"
    dir_installer="$app_shortname""_""x64"

    # download
    if [[ ! -d "$dir_installer" ]]
    then
        url=$url_appspecific
        downloadInstaller "$url" "$dir_installer"
    fi
    # install
    if [[ $mode_onoffdown != "3" ]]
    then
        dmgCopyApp "$dir_installer" "$app_shortname"
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# RAR
# 
# param
app_num=182
app_shortname="RAR"
app_toinclude=$app_toinclude_RAR
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="rar"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # install
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

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Keka
# 
# param
app_num=182
app_shortname="Keka"
app_toinclude=$app_toinclude_Keka
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="keka"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# VLC
# 
# param
app_num=183
app_shortname="VLC"
app_toinclude=$app_toinclude_VLC
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="vlc"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Java 8
# 
# param
app_num=184
app_shortname="Java"
app_toinclude=$app_toinclude_Java
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="java"
    url_appspecific="$url_javajre_8_x64"
    dir_installer="$app_shortname""_""$arch_name"

    # download
    if [[ ! -d "$dir_installer" ]]
    then
        url=$url_appspecific
        downloadInstaller "$url" "$dir_installer"
    fi
    # install
    if [[ $mode_onoffdown != "3" ]]
    then
        dmgInstallPkgAtAppcontres "$dir_installer" "$app_shortname"
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# OpenVPN
# 
# param
app_num=185
app_shortname="OpenVPN"
app_toinclude=$app_toinclude_OpenVPN
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="openvpn-connect"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        if [[ $mode_onoffdown != "3" ]]
        then
            # install
            ########## START OF CODE FOR OFFLINE INSTALL ##################################################
            # Almost same as dmgInstallPkgAtRoot "$dir_installer" "$app_shortname"

            echo "Installing $1 ..."

            # Get dmg filename
            filename_dmg="$(ls $dir_installer | egrep '\.dmg$')"

            # Mount dmg
            hdiutil attach -quiet -nobrowse -noverify "$dir_installer/$filename_dmg"

            # Get volume name of mounted dmg
            name_vol_final="$(ls /Volumes | egrep $app_shortname)"

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

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# WireGuard
# 
# param
app_num=185
app_shortname="WireGuard"
app_toinclude=$app_toinclude_WireGuard
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="wireguard-tools"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Firefox
# 
# param
app_num=186
app_shortname="Firefox"
app_toinclude=$app_toinclude_Firefox
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="firefox"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Thunderbird
# 
# param
app_num=187
app_shortname="Thunderbird"
app_toinclude=$app_toinclude_Thunderbird
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="thunderbird"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# OBS
# 
# param
app_num=188
app_shortname="OBS"
app_toinclude=$app_toinclude_OBS
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="obs"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# LibreOffice
# 
# param
app_num=190
app_shortname="LibreOffice"
app_toinclude=$app_toinclude_LibreOffice
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="libreoffice"
    dir_installer="$app_shortname""_""$arch_name"

    if [[ $mode_onoffdown = "1" ]]
    then
        # pkgmgr
        brew install --cask $app_hbname
    else
        # download
        if [[ ! -d "$dir_installer" ]]
        then
            url=$(getURLFromBrew "$app_hbname")
            downloadInstaller "$url" "$dir_installer"
        fi
        # install
        if [[ $mode_onoffdown != "3" ]]
        then
            dmgCopyApp "$dir_installer" "$app_shortname"
        fi
    fi

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

# Microsoft Office
# 
# param
app_num=200
app_shortname="Office"
app_toinclude=$app_toinclude_Office
# 
# main
if [[ ($appnum_toinstall_from -le $app_num) && ($app_num -le $appnum_toinstall_to) && ($app_toinclude -eq "1") ]]
then

    # param
    app_hbname="microsoft-office"
    dir_installer="$app_shortname""_""$arch_name"

    # run
    source ./script-msoffice.sh

    # done
    echo " "
    # clear param
    # unset app_toinclude

fi
# 
# done

echo " "

# final

# unset variables
unset appInstallerArchitecture
unset arch_name
unset macos_version
unset mode_onoffdown
unset appnum_toinstall_from
unset appnum_toinstall_to

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
