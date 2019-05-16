#!/bin/bash

# debootm="http://ftp.us.debian.org/debian/"
# jail=/home/charlesc/scripts/strapond/jail

function pause() {
	read -p "Press [ENTER] to continue..." fackEnterKey
}

function setup-env() {
	export BIND=${jail}
	export DEBMIR=${debootm}
	echo $BIND
	echo $DEBMIR
	pause
}

function bind-mount() {
	sudo mount --bind /dev  -v $BIND/dev
	sudo mount --bind /sys  -v $BIND/sys
	sudo mount --bind /proc -v $BIND/proc
	pause
}

function debootstrap() {
	sudo debootstrap --arch amd64 --include=build-essential,vim,bash-completion,clang,ccache,bison,flex sid $BIND $DEBMIR
	pause
}

function menu() {
	echo " "
	echo " +================================================+ "
	echo " | MENU                                           | "
	echo " | 1 setup-env                                    | "
	echo " | 2 debootstrap                                  | "
	echo " | 3 bind-mount                                   | "
	echo " | 4 exit                                         | "
	echo " +================================================+ "
	echo " "
}

function choice() {
    local menu_choice
    read -p "Please select [1-4]: " menu_choice
    case $menu_choice in
        [1]) setup-env ;;
        [2]) debootstrap ;;
        [3]) bind-mount ;;
        [4]) exit 0 ;;
        *) echo -e "ERROR " && sleep 2 ;;
    esac
}

trap ' ' SIGINT SIGQUIT SIGTSTP

while true
do
	menu
	choice
done
