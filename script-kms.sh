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
dir_extracted_vls="extracted_VLS""
mkdir -p "$dir_extracted_vls"

echo " "
echo "================================================================================"
echo "Installing Office VL Serializer ..."
echo "================================================================================"
echo " "

# Check macOS Version
while \
      [[ ! $macos_version =~ ^[0-9]+$ ]] || \
      (( $macos_version < 6 )) || \
      (( $macos_version >= 16 && $macos_version <= 25 )) || \
      (( $macos_version > $latest_macos_version ))
do
    read -p "Enter number - macOS Version : " macos_version
done
echo "CONFIRMED - macos_version: $macos_version"


# Install

echo "Starting installation ..."

# Point to the correct VLS
case $macos_version in
    26)
        # 26
        # macOS 26
        dir_installer="OfficeVLS/v2024"
        ;;
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
tar -xzf "$dir_installer/$(ls $dir_installer | egrep '\.tar.gz$')" -C "$dir_extracted_vls"

# Install
sudo installer -pkg "$dir_extracted_vls/$(ls $dir_extracted_vls | egrep '\.pkg$')" -target /

echo " "

echo "Terminating script-kms.sh ..."


# ==================================================
# Notes
# ==================================================
