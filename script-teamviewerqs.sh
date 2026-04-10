#!/bin/sh

# script-teamviewerqs.sh
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


echo "Starting script-teamviewerqs.sh ..."

# include
# source ./functions.sh
# source ./urls.sh
# source ./values.sh

# var
# var=""

# cd
cd ~/Downloads

# constants - pre-code
url_teamviewerqs_13="https://download.teamviewer.com/download/version_13x/TeamViewerQS.dmg"
# app_toinclude_TeamViewer=1

##################################################

# param
# app_num=181
app_shortname="TeamViewerQS"
# app_toinclude=$app_toinclude_TeamViewer

# main

# param
app_hbname="teamviewer"
url_appspecific="$url_teamviewerqs_13"
dir_installer="$app_shortname""_""x64"

# download
if [[ ! -d "$dir_installer" ]]
then
    # url
    url=$url_appspecific
    # 
    # create folder
    mkdir "$dir_installer"
    # 
    # cd
    pushd "$dir_installer"
    # 
    # download
    curl -L -O "$url"
    # 
    # cd
    popd
fi

# install
# 
# get dmg filename
filename_dmg="$(ls $dir_installer | egrep '\.dmg$')"
# 
# mount dmg
hdiutil attach -quiet -nobrowse -noverify "$dir_installer/$filename_dmg"
# 
# get volume name of mounted dmg
name_vol_final="$(ls /Volumes | egrep $app_shortname)"
# 
# get app name in volume
name_app=$(ls "/Volumes/$name_vol_final" | egrep '\.app$')
# 
# delete app in /Applications if app exist
if [[ -d "/Applications/$name_app/Contents" ]]
then
    sudo rm -rf "/Applications/$name_app"
fi
# 
# copy
sudo cp -R "/Volumes/$name_vol_final/$name_app" "/Applications"
# 
# unmount dmg
hdiutil detach -quiet "/Volumes/$name_vol_final"

# done
echo " "
# clear param
# unset app_toinclude

##################################################

echo " "

echo "Terminating script-teamviewerqs.sh ..."


# ==================================================
# Notes
# ==================================================
