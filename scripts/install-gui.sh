#!/bin/bash

echo "installing $2 ui for ubuntu $1"

if [ "$1" == "14.04" ] ; then
	sudo apt-get install -y ubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "unity" ] ; then
	sudo apt-get install -y ubuntu-desktop > /dev/null 2>&1
fi

if [ "$1" == "18.04" ] && [ "$2" == "kde" ] ; then
	sudo add-apt-repository ppa:kubuntu-ppa/backports
	sudo apt-get install -y kubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "lubuntu" ] ; then
	sudo apt-get install -y lubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "mate" ] ; then
	sudo apt-get install -y mate-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "gnome" ] ; then
	sudo apt-get install -y ubuntu-gnome-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "xubuntu" ] ; then
	sudo apt-get install -y xubuntu-desktop
fi
