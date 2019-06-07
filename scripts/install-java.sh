#!/bin/bash
echo "installing java $1"

if [ "$1" == "8" ] && [ "$2" == "14.04" ] ; then
	sudo add-apt-repository ppa:openjdk-r/ppa
	
	sudo apt-get update
	
	sudo apt-get install -y openjdk-8-jre
	sudo apt-get install -y openjdk-8-jdk
	
	sudo update-alternatives --config java
	sudo update-alternatives --config javac
fi

if [ "$1" == "8" ] && [ "$2" == "16.04" ] ; then
	sudo apt-get install -y debconf-utils python-software-properties software-properties-common > /dev/null 2>&1
	
	sudo add-apt-repository -y ppa:webupd8team/java > /dev/null 2>&1
	
	sudo apt-get update > /dev/null 2>&1
	
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections
	
	sudo apt-get -y install oracle-java8-installer > /dev/null 2>&1
	sudo apt-get -y install oracle-java8-set-default > /dev/null 2>&1
	
	echo "installed java version"
	java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}'
	
	sudo apt-get -y install maven
fi
