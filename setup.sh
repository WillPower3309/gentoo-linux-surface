#!/usr/bin/env bash

# Check if script is being ran as root
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
CONFIG_SRC="$PWD/linux-surface/configs/surface-$KERNEL_VER.config"
KERNEL_PATH='/usr/src/linux'
MAKEFLAGS='-j5'

# Patch kernel if patches exist
if [ -d "$PATCHES_SRC" ]; then
    mkdir -pv "$PATCHES_DST"
    cp -v "$PATCHES_SRC"/* "$PATCHES_DST"
    emerge -av sys-kernel/gentoo-sources
else
    echo "Patches for linux kernel $KERNEL_VER not found"
    exit 1
fi

# Merge relevant config options if they exist
if [ -e "$CONFIG_SRC" ]; then
    echo "Config for kernel $KERNEL_VER found!"
    echo "Merging Configs..."
    sh "$KERNEL_PATH/scripts/kconfig/merge_config.sh" -m "$KERNEL_PATH/.config" "$CONFIG_SRC"
fi

######################### COMPILE & INSTALL #########################

make -C "$KERNEL_PATH" "$MAKEFLAGS"
make -C "$KERNEL_PATH" modules_install
make -C "$KERNEL_PATH" install
