#!/bin/sh

# script-uninstall.sh
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


echo "Starting script-uninstall.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""



# Java
# 
# 1 - JDK
sudo rm -rf /Library/Java
# 
# 2 - plugins
sudo rm -rf /Library/PreferencePanes/Java*
sudo rm -rf /Library/Internet\ Plug-Ins/Java*
sudo rm -rf /Library/LaunchAgents/com.oracle*
sudo rm -rf /Library/PrivilegedHelperTools/com.oracle*
sudo rm -rf /Library/LaunchDaemons/com.oracle*
sudo rm -rf /Library/Preferences/com.oracle*
# 
# 3
rm -fr ~/Library/Application\ Support/Oracle



echo " "

echo "Terminating script-uninstall.sh ..."


# ==================================================
# Notes
# ==================================================
