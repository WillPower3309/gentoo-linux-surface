#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

############################### SETUP ###############################

cd /tmp
git clone git://github.com/linux-surface/linux-surface.git

############################### PATCH ###############################

KERNEL_VER=$(uname -r | cut -d . -f -2)
PATCHES_SRC="$PWD/linux-surface/patches/$KERNEL_VER"
PATCHES_DST='/etc/portage/patches/sys-kernel/gentoo-sources'

if [ -d "$PATCHES_SRC" ]; then
    mkdir -pv "$PATCHES_DST"
    cp -v "$PATCHES_SRC"/* "$PATCHES_DST"
    emerge -av sys-kernel/gentoo-sources
else
    echo "Patches for linux kernel $KERNEL_VER not found"
fi
