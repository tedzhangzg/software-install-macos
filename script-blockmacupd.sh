#!/bin/sh

# script-blockmacupd.sh
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


echo "Starting script-blockmacupd.sh ..."

# include
# source ./functions.sh
# source ./urls.sh
# source ./values.sh

# var
# var=""

echo " "
echo "================================================================================"
echo "Script - Block macOS Software Update"
echo "================================================================================"
echo " "

echo " "
echo "Adding lines to hosts file"
echo "..."
echo " "

echo "" | sudo tee -a /private/etc/hosts
echo "# disable macOS updates and notifications" | sudo tee -a /private/etc/hosts
echo "# " | sudo tee -a /private/etc/hosts
echo "# update scanning and queries" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 swscan.apple.com" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 swquery.apple.com" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 swdist.apple.com" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 mesu.apple.com" | sudo tee -a /private/etc/hosts
echo "# " | sudo tee -a /private/etc/hosts
echo "# update downloads" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 swdownload.apple.com" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 oscdn.apple.com" | sudo tee -a /private/etc/hosts
echo "# " | sudo tee -a /private/etc/hosts
echo "# update notifications" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 courier.push.apple.com" | sudo tee -a /private/etc/hosts
echo "127.0.0.1 0-courier.push.apple.com" | sudo tee -a /private/etc/hosts

echo " "
echo "Added lines to hosts file"
echo " "

echo " "

echo "Terminating script-blockmacupd.sh ..."


# ==================================================
# Notes
# ==================================================
