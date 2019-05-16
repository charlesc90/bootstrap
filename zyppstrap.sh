#!/bin/bash

# export ZTARGET=/home/

mkdir $ZTARGET
zypper --installroot $ZTARGET --non-interactive install pattern\:basesystem
zypper --installroot $ZTARGET --non-interactive install --type pattern yast2_basis
zypper --installroot $ZTARGET --non-interactive install bash-completion vim nano mc
