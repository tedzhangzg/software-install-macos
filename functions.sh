#!/bin/sh

# functions.sh
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


# echo "Starting functions.sh ..."



# Download
# curl -L -O "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.sh"
# dot sourced into all scripts
# source ./functions.sh



# Clear Terminal History
# 
# Usage
# clearTerminalHistory
# 
function clearTerminalHistory() {
    sudo rm -rf /var/root/.bash_history
    rm -rf $HOME/.bash_history
    rm -rf $HOME/.zsh_history
}



# Autodetect processor Architecture, even Rosetta emulation
# 
# Usage
# autodetectProcessorArchitecture
# 
function autodetectProcessorArchitecture() {
    
    # Using UNIX uname
    arch_name="$(uname -m)"
    
    if [[ "${arch_name}" = "arm64" ]]
    then
        echo "Auto-detect: Native ARM"
    elif [[ "${arch_name}" = "x86_64" ]]
    then
        # Check if running under Rosetta 2 emulation on ARM
        if [[ "$(sysctl -in sysctl.proc_translated)" = "1" ]]
        then
            echo "Auto-detect: Rosetta 2 emulation on ARM"
        else
            echo "Auto-detect: Native Intel"
        fi
    else
        echo "Unknown architecture: ${arch_name}"
    fi
    
}



# Compare OS / Get OS
# 
# Usage
# meetMinOS "$requiredver"
# 
function meetMinOS() {

    # Get current OS version
    currentver="$(sw_vers -productVersion)"

    # State required minimum OS
    # $requiredver get from parameter $1
    # requiredver="10.13.6"

    # Check
    if [[ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]]
    then
        echo "Greater than or equal to ${requiredver}"
    else
        echo "Less than ${requiredver}"
    fi

}



# Get URL from brew JSON file
# 
# Usage
# getURLFromBrew "$app_brewname" "$archSuffix"
# 
function getURLFromBrew() {

    # URL of brew cask
    url_json_file="https://formulae.brew.sh/api/cask/$1.json"

    # Determine mode and corresponding URL
    if [[ "$2" = "a64x64" ]] || [[ "$2" = "x64" ]]
    then
        url_brew_package=$(curl -s $url_json_file | python3 -c "import sys, json; print(json.load(sys.stdin)['url'])")
    elif [[ "$2" = "a64" ]]
    then
        url_brew_package=$(curl -s $url_json_file | python3 -c "import sys, json; print(json.load(sys.stdin)['variations']['arm64_ventura']['url'])")
    else
        # default to
        url_brew_package=$(curl -s $url_json_file | python3 -c "import sys, json; print(json.load(sys.stdin)['url'])")
    fi

    # Print
    echo $url_brew_package

}



# Create Folder, preventing error if exist
# 
# Usage
# createNewEmptyFolder "$folder_name"
# 
function createNewEmptyFolder() {
    if [[ -d "$1" ]]
    then
        rm -rf "$1"
    fi
    mkdir $1
}



# Download Installer
# 
# Usage
# downloadInstaller "$url" "$dir_installer"
# 
function downloadInstaller() {
    echo "Downloading $2 ..."
    
    # Create new folder
    createNewEmptyFolder "$2"
    
    # Download
    pushd "$2"
    curl -L -O "$1"
    popd
    
    echo "... Done downloading $2"
}



# Install PKG
# 
# Usage
# pkgInstall "$dir_installer"
# 
function pkgInstall() {
    echo "Installing $1 ..."

    # cd
    pushd "$1"

    # Get name
    pkgName="$(ls | egrep '\.pkg$')"

    # Install
    sudo installer -pkg "$pkgName" -target /

    # cd
    popd

    echo "... Done installing $1"
}



# Unzip, Copy .app into /Applications
# 
# Usage
# uncompressFileCopyApp "$dir_installer"
# 
function uncompressFileCopyApp() {
    echo "Installing $1 ..."

    # cd
    pushd "$1"

    # Get name
    compressedFileName="$(ls | egrep '\.zip$')"

    # Install
    unzip -qo $compressedFileName -d /Applications

    # cd
    popd

    echo "... Done installing $1"
}



# Mount .dmg, Install .pkg at root of .dmg, Unmount .dmg
# 
# Usage
# dmgInstallPkgAtRoot "$dir_installer" "$app_name_partial"
# 
function dmgInstallPkgAtRoot() {
    echo "Installing $1 ..."

    # Get dmg filename
    filename_dmg="$(ls $1 | egrep '\.dmg$')"

    # Mount dmg
    hdiutil attach -quiet -nobrowse -noverify "$1/$filename_dmg"

    # Get volume name of mounted dmg
    name_vol_final="$(ls /Volumes | egrep $2)"

    # Install
    pkgInstall "/Volumes/$name_vol_final"

    # Unmount dmg
    hdiutil detach -quiet "/Volumes/$name_vol_final"

    echo "... Done installing $1"
}



# Mount .dmg, Install .pkg at .app/Contents/Resources of .dmg, Unmount .dmg
# 
# Usage
# dmgInstallPkgAtAppcontres "$dir_installer" "$app_name_partial"
# 
function dmgInstallPkgAtAppcontres() {
    echo "Installing $1 ..."

    # Get dmg filename
    filename_dmg="$(ls $1 | egrep '\.dmg$')"

    # Mount dmg
    hdiutil attach -quiet -nobrowse -noverify "$1/$filename_dmg"

    # Get volume name of mounted dmg
    name_vol_final="$(ls /Volumes | egrep $2)"

    # Get app name in volume
    name_app=$(ls "/Volumes/$name_vol_final" | egrep '\.app$')

    # Install
    dir_pkgfile="/Volumes/$name_vol_final/$name_app/Contents/Resources"
    pkgInstall "$dir_pkgfile"

    # Unmount dmg
    hdiutil detach -quiet "/Volumes/$name_vol_final"

    echo "... Done installing $1"
}







# Mount .dmg, Copy .app into /Applications, Unmount .dmg
# 
# Usage
# dmgCopyApp "$dir_installer" "$app_name_partial"
# 
function dmgCopyApp() {
    echo "Installing $1 ..."

    # Get dmg filename
    filename_dmg="$(ls $1 | egrep '\.dmg$')"

    # Mount dmg
    hdiutil attach -quiet -nobrowse -noverify "$1/$filename_dmg"

    # Get volume name of mounted dmg
    name_vol_final="$(ls /Volumes | egrep $2)"

    # Get app name in volume
    name_app=$(ls "/Volumes/$name_vol_final" | egrep '\.app$')

    # Delete app in /Applications if app exist
    if [[ -d "/Applications/$name_app/Contents" ]]
    then
        sudo rm -rf "/Applications/$name_app"
    fi

    # Copy
    sudo cp -R "/Volumes/$name_vol_final/$name_app" "/Applications"

    # Unmount dmg
    hdiutil detach -quiet "/Volumes/$name_vol_final"

    echo "... Done installing $1"
}



# Mount .dmg, Install .app, Unmount .dmg
# 
# Usage
# dmgInstallApp "$dir_installer" "$app_name_partial"
# 
function dmgInstallApp() {
    echo "Installing $1 ..."

    # Get dmg filename
    filename_dmg="$(ls $1 | egrep '\.dmg$')"

    # Mount dmg
    hdiutil attach -quiet -nobrowse -noverify "$1/$filename_dmg"

    # Get volume name of mounted dmg
    name_vol_final="$(ls /Volumes | egrep $2)"

    # Get app name in volume
    name_app=$(ls "/Volumes/$name_vol_final" | egrep '\.app$')

    # Get executable name inside .app/Contents/MacOS
    name_executable="$(ls "/Volumes/$name_vol_final/$name_app/Contents/MacOS" | grep $app_name_partial)"

    # Install
    sudo "/Volumes/$name_vol_final/$name_app/Contents/MacOS/$name_executable"
    # For some apps, install by running .app like in GUI
    # sudo open "/Volumes/$name_vol_final/$name_app"

    # Unmount dmg
    hdiutil detach -quiet "/Volumes/$name_vol_final"

    echo "... Done installing $1"
}

# echo " "

# echo "Terminating functions.sh ..."


# ==================================================
# Notes
# ==================================================
