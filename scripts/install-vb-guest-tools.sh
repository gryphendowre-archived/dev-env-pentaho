#!/bin/bash

echo "installing vb guest tools"

sudo apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 > /dev/null 2>&1
