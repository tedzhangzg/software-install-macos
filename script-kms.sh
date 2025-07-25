#!/bin/sh

# script-kms.sh
# ==================================================
# Description
# This script installs the Office VL Serializer for macOS.
# It allows for the activation of Microsoft Office products using a Volume License Key (VLK).
# The script detects the macOS version and installs the appropriate serializer version.
# It also creates a temporary directory for the installation files and cleans up after installation.
# ==================================================
# Usage
# Run this script in a terminal with appropriate permissions.
# Ensure you have the necessary permissions to install software on the system.
# The script will prompt for the macOS version to install the correct serializer.
# ==================================================


echo "Starting script-kms.sh ..."

# include
source ./functions.sh
source ./urls.sh
source ./values.sh

# var
# var=""

echo " "
echo "================================================================================"
echo "Installing Office VL Serializer ..."
echo "================================================================================"
echo " "

# Create temp folder
tmpdir="$HOME/Downloads/tempappinstall"
mkdir "$tmpdir"

# Check macOS Version
# Detect
echo "Detected macOS version: " $(sw_vers -productVersion)
echo " "
# List
echo "macOS Versions"
# this will first display macOS 11-latest
# eg, 11 - macOS 11
# and so on
for (( i=$latest_macos_version ; i>=11 ; i-- ))
do
    echo $i" - macOS "$i
done
echo "10 - macOS 10.15"
echo "9 - macOS 10.13"
echo "8 - OS X 10.11"
echo "7 - Mac OS X 10.7"
echo "6 - Mac OS X 10.6 and earlier"
# Ask
while [[ ! $macos_version =~ ^[0-9]+$ ]] || [[ $macos_version -lt "6" ]] || [[ $macos_version -gt $latest_macos_version ]]
do
    read -p "Enter number - macOS Version : " macos_version
done


# Install

echo "Starting installation ..."

# Point to the correct VLS
case $macos_version in
    15)
        # 15
        # macOS 15
        dir_installer="OfficeVLS/v2024"
        ;;
    14)
        # 14
        # macOS 14
        dir_installer="OfficeVLS/v2024"
        ;;
    13)
        # 13
        # macOS 13
        dir_installer="OfficeVLS/v2024"
        ;;
    12)
        # 12
        # macOS 12
        dir_installer="OfficeVLS/v2024"
        ;;
    11)
        # 11
        # macOS 11
        dir_installer="OfficeVLS/v2021"
        ;;
    10)
        # 10
        # macOS 10.15
        dir_installer="OfficeVLS/v2021"
        ;;
    9)
        # 9
        # macOS 10.13
        dir_installer="OfficeVLS/v2019v1"
        ;;
    8)
        # 8
        # OS X 10.11
        dir_installer="OfficeVLS/v2016"
        ;;
    7)
        # 7
        # Mac OS X 10.7
        dir_installer="OfficeVLS/v2024"
        ;;
    6)
        # 6
        # Mac OS X 10.6 and earlier
        dir_installer="OfficeVLS/v2024"
        ;;
    *)
        # default
        dir_installer="OfficeVLS/v2024"
        ;;
esac

# Extract
tar -xzf "$dir_installer/$(ls $dir_installer | egrep '\.tar.gz$')" -C "$tmpdir"

# Install
sudo installer -pkg "$tmpdir/$(ls $tmpdir | egrep '\.pkg$')" -target /

# Remove temp folder contents
sudo rm -rf $tmpdir/**

echo " "

echo "Terminating script-kms.sh ..."


# ==================================================
# Notes
# ==================================================
