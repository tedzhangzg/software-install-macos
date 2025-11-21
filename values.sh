#!/bin/sh

# values.sh
# ==================================================
# Description
# This script contains the values for the installation of various applications on macOS.
# It allows toggling the inclusion of specific applications during the installation process.
# ==================================================
# Usage
# This script is sourced by other scripts to determine which applications to include in the installation.
# To modify the applications included, change the values after the equals sign.
# Do not modify the structure of the script.
# Save changes and close the editor after making modifications.
# ==================================================


# echo "Starting values.sh ..."

# Instructions
##################################################
# ONLY change values after = sign
# Do not tamper with other words / symbols
# Save changes and close notepad
##################################################



# Toggle app to be included during installation
# Note: These will only affect installation if app is in range of "from" and "to" in Script1
# 1 -> include
# 0 -> exclude
##################################################
# Try not to touch these few important apps
##################################################
appnum_toinclude_Rosetta2=1
appnum_toinclude_Homebrew=1
appnum_toinclude_enableDevMode=1
# 
appnum_toinclude_XQuartz=1
# 
appnum_toinclude_Python3=1
appnum_toinclude_Python2=0
# 
appnum_toinclude_SublimeText=0
##################################################
appnum_toinclude_RestartMidway=0
##################################################
appnum_toinclude_PowerShell=1
appnum_toinclude_VSCode=1
appnum_toinclude_dotnetlatest=1
# 
appnum_toinclude_Edge=1
appnum_toinclude_Teams=1
appnum_toinclude_Skype=0
# 
appnum_toinclude_Chrome=1
appnum_toinclude_Drive=1
# 
appnum_toinclude_Messenger=0
# 
appnum_toinclude_AcrobatReader=1
# 
appnum_toinclude_Dropbox=0
# 
appnum_toinclude_Zoom=1
appnum_toinclude_Discord=0
appnum_toinclude_Telegram=1
appnum_toinclude_WhatsApp=1
appnum_toinclude_WeChat=0
# 
appnum_toinclude_TeamViewer=1
appnum_toinclude_Keka=1
appnum_toinclude_VLC=1
appnum_toinclude_Java8=0
appnum_toinclude_OpenVPN=0
appnum_toinclude_WireGuard=0
appnum_toinclude_Firefox=1
appnum_toinclude_Thunderbird=0
appnum_toinclude_OBS=0
appnum_toinclude_LibreOffice=0
# 
appnum_toinclude_Office=1
appnum_toinclude_OfficeVLS=1
##################################################



##################################################
# Do not touch
##################################################
latest_macos_version=26


# echo " "

# echo "Terminating values.sh ..."


# ==================================================
# Notes
# ==================================================
