#!/bin/bash

# https://www.smarthomebeginner.com/install-gui-on-ubuntu-server-14-04-gnome/

echo "installing gui"

# 1. MINIMAL GNOME CORE DESKTOP
#sudo apt-get install xorg gnome-core gnome-system-tools gnome-app-install -y

# 2. UNITY BASED UBUNTU SERVER GUI
sudo apt-get install -y --no-install-recommends ubuntu-desktop > /dev/null 2>&1
