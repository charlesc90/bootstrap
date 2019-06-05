#!/bin/bash

## setup #####################################################################

# URI of a debian mirror
dmir="http://ftp.us.debian.org/debian/"

# check for a zram directory in your home directory
if [ -d $HOME/zram ]; then
    export ZHOME=$HOME/zram
# if there isn't one, make one
else
    sudo mkdir -v $HOME/zram && export ZHOME=$HOME/zram
fi

###############################################################################

# First, probe the zram module. It is unlikely to be in your kernel by default.
# If it's already in there, modprobing it will not cause any problems.
sudo modprobe zram

# This line doesn't need to be this complicated. It writes the name of the
# available zram block device to temp, then zramctl initializes it using temp
# (dependent on a zram block device being available)
echo "$(zramctl -f)" > temp && zramctl -s 2048M -t 8 "$(cat temp)"

export ZBLOCK="$(cat temp)"
diff "$(cat temp)" "$(echo $ZBLOCK)"

blkid --probe $ZBLOCK
mkfs.ext4 -v $ZBLOCK
mount $ZBLOCK -v -t ext4 $ZHOME

debootstrap --arch amd64 --include=build-essential sid $ZHOME ${dmir} 
