# bootstrap
Bash scripts to assist in bootstrapping Debian and openSUSE environments

The Stage 01 script initializes some local variables. 
It exports them to environmental variables.
It is important to adjust these variables according to your target environment.

The Debian scripts use debootstrap.
It is included in several package managers' repos. 

The openSUSE scripts use zypper.
It must be used in an openSUSE environment.

# Debian
The strapond.sh script initializes some local variables.
It exports them to environmental variables.
It is important to adjust these variables according to your target environment.
Once they are set, select debootstrap to begin bootstrapping Debian
If needed, select the bind-mount option to mount --bind the virtual filesystems
/dev, /sys, and /proc

This is useful for making chroot jail environments, containers,
and dev/testing environments.

The "${debootm}" variable is the URL of a Debian ftp server. 
It gets exported to "$DEBMIR".
The "${jail}" variable is the bootstrap target directory. 
It gets exported to "$BIND".

# ramstrap
The ramstrap.sh script bootstraps a Debian system onto a zram block device.
