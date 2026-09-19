#!/bin/sh

# script-homebrew.sh
# ==================================================
# Description
# This script installs Homebrew on macOS.
# It detects the architecture of the Mac and sets up the environment accordingly.
# It also adds the necessary shell environment variables to the user's profile.
# ==================================================
# Usage
# Run this script in a terminal on macOS to install Homebrew.
# ==================================================


echo "Starting script-homebrew.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""

echo " "
echo "================================================================================"
echo "Script - Install Homebrew"
echo "================================================================================"
echo " "

# install xcode-select
# 
# xcode-select --install 2>/dev/null
# 
# echo "Waiting for Xcode Command Line Tools to install..."
# until xcode-select -p &>/dev/null; do
#     sleep 5
# done
# 
# echo "Installation complete."

# homebrew one-liner script
# 
if [[ $appInstallerArchitecture -eq "1" ]]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
elif [[ $appInstallerArchitecture -eq "2" ]]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/e078684c4a86a34bc1239e1a0ddcb86d7b9c787b^/install.sh)"
else
    echo "Invalid architecture"
fi

# For homebrew on Apple Silicon
# Note: ignore for Intel Mac
if [[ $appInstallerArchitecture -eq "1" ]]
then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $appInstallerArchitecture -eq "2" ]]
then
    if [[ $macos_version -ge "10" ]]
    then
        (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/$(whoami)/.zprofile
    else
        (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/$(whoami)/.bash_profile
    fi
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Invalid architecture"
fi

# Additional taps
# brew tap homebrew/core
# brew tap homebrew/cask

echo " "

echo "Terminating script-homebrew.sh ..."


# ==================================================
# Notes
# ==================================================
