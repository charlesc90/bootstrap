#!/bin/bash

## setup #####################################################################

# URI of a debian mirror
dmir="http://ftp.us.debian.org/debian/"

# check for a zram directory in your home directory
if [ -d $HOME/zram ]; then
    sudo export ZHOME=$HOME/zram
# if there isn't one, make one
else
    sudo mkdir -v $HOME/zram && sudo export ZHOME=$HOME/zram
fi

###############################################################################

# First, probe the zram module. It is unlikely to be in your kernel by default.
# If it's already in there, modprobing it will not cause any problems.
sudo modprobe zram

# This line doesn't need to be this complicated. It writes the name of the
# available zram block device to temp, then zramctl initializes it using temp
# (dependent on a zram block device being available)
sudo echo "$(zramctl -f)" > temp && sudo zramctl -s 2048M -t 8 "$(cat temp)"

# exports the name of the zram block device to $ZBLOCK
sudo export CHECK="$(cat temp)"
sudo export ZBLOCK="$CHECK"

# checks for any irregularities, informs the kernel of the zram device, makes an ext4 fs,
# and mounts it on the $HOME/zram directory. For other architectures, change the --arch
# flag, and you can include packages (seperated by commas) after include. They must be in the 
# Debian main repo for the debootstrap script to run completely.
if [ $ZBLOCK = $CHECK ]; then
    sudo blkid --probe $ZBLOCK
    sudo mkfs.ext4 -v $ZBLOCK
    sudo mount $ZBLOCK -v -t ext4 $ZHOME
    sudo debootstrap --arch amd64 --include=build-essential sid $ZHOME "${dmir}"
else
    echo "ERROR..." && sudo echo "zblock: $ZBLOCK zhome: $ZHOME check: $CHECK"
fi
