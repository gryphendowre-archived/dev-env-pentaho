#!/bin/bash

echo "installing $2 ui for ubuntu $1"

if [ "$1" == "14.04" ] ; then
	sudo apt-get install -y --no-install-recommends ubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "unity" ] ; then
	sudo apt-get install -y --no-install-recommends ubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "kde" ] ; then
	sudo add-apt-repository ppa:kubuntu-ppa/backports
	sudo apt-get install -y --no-install-recommends kubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "lubuntu" ] ; then
	sudo apt-get install -y --no-install-recommends lubuntu-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "mate" ] ; then
	sudo apt-get install -y --no-install-recommends mate-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "gnome" ] ; then
	sudo apt-get install -y --no-install-recommends ubuntu-gnome-desktop
fi

if [ "$1" == "18.04" ] && [ "$2" == "xubuntu" ] ; then
	sudo apt-get install -y --no-install-recommends xubuntu-desktop
fi

# todo: move this to another file
sudo apt-get install -y --no-install-recommends firefox
