# bootstrap
Bash scripts to assist in bootstrapping Debian and openSUSE environments

The Debian scripts use debootstrap, which is included in several package managers' repos. 
The openSUSE scripts use zypper, which must be used in an openSUSE environment.

Debian

The Stage 01 script initializes some local variables, then exports them.
It is important to adjust these variables according to your target environment.

The "${debootm}" variable is the URL of a Debian ftp server. It gets exported to "$DEBMIR".
The "${jail}" variable is the bootstrap target directory. It gets exported to "$BIND".

