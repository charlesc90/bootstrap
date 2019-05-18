#!/bin/bash

if [ -d $HOME/zram ]; then
    export ZHOME=$HOME/zram
else
    sudo mkdir -v $HOME/zram && export ZHOME=$HOME/zram
fi

sudo modprobe zram
sudo echo "$(zramctl -f)" > zram.tmp
sudo cat zram.tmp | echo | > zram0.tmp
sudo zramctl -s 1024M -t 8 "$(sudo cat zram0.tmp)"
sudo blkid --probe "$(sudo cat zram0.tmp)"
sudo mkfs.ext4 -v "$(sudo cat zram0.tmp)"
sudo mount "$(sudo cat zram0.tmp)" -v -t ext4 $HOME/zram

sudo debootstrap --arch amd64                                \
    --include=build-essential,nano,bash-completion           \
    sid $HOME/zram http://ftp.us.debian.org/debian/ 
