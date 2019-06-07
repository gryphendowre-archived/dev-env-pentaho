#!/bin/bash

if [ "$1" == "7.1" ]; then
	echo "downloading pentaho tools 7.1"
	NAME="Pentaho Data Integration"
	
	if [ -e /vagrant/tools/pdi-ee-client-7.1.0.23-197-dist.zip ]; then
		echo "$NAME already downloaded"
	else
		echo "downloading $NAME"
		wget -q http://build.pentaho.net/hosted/7.1.0.23/197/pdi-ee-client-7.1.0.23-197-dist.zip -O /vagrant/tools/pdi-ee-client-7.1.0.23-197-dist.zip
	fi
	
	cp /vagrant/tools/pdi-ee-client-7.1.0.23-197-dist.zip /home/vagrant/
	unzip /home/vagrant/pdi-ee-client-7.1.0.23-197-dist.zip
	
	# ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
	
	if [ -e /vagrant/tools/pdi-ee-client-7.1.0.24-198-dist.zip ]; then
		echo "$NAME already downloaded"
	else
		echo "downloading $NAME"
		wget -q http://build.pentaho.net/hosted/7.1.0.24/198/pdi-ee-client-7.1.0.24-198-dist.zip -O /vagrant/tools/pdi-ee-client-7.1.0.24-198-dist.zip
	fi
	
	cp /vagrant/tools/pdi-ee-client-7.1.0.24-198-dist.zip /home/vagrant/
	unzip /home/vagrant/pdi-ee-client-7.1.0.24-198-dist.zip
fi

if [ "$1" == "8.2" ]; then
	echo "downloading pentaho tools 8.2"
	NAME="Pentaho Data Integration"
	
	if [ -e /vagrant/tools/pdi-ee-client-8.2.0.0-342-dist.zip ]; then
		echo "$NAME already downloaded"
	else
		echo "downloading $NAME"
		wget -q http://build.pentaho.com/hosted/8.2.0.0/342/pdi-ee-client-8.2.0.0-342-dist.zip -O /vagrant/tools/pdi-ee-client-8.2.0.0-342-dist.zip
	fi
	
	cp /vagrant/tools/pdi-ee-client-8.2.0.0-342-dist.zip /home/vagrant/
	unzip /home/vagrant/pdi-ee-client-8.2.0.0-342-dist.zip
fi

mkdir /home/vagrant/licenses
cp /vagrant/licenses/*.lic /home/vagrant/licenses

sudo apt-get install -y libwebkitgtk-1.0-0

sudo apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module
