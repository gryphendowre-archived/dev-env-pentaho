#!/bin/bash
echo "installing java $1"

if [ "$1" == "8" ] ; then
	sudo add-apt-repository -y ppa:openjdk-r/ppa > /dev/null 2>&1
	
	sudo apt-get update > /dev/null 2>&1
	
	sudo apt-get install -y openjdk-8-jre > /dev/null 2>&1
	sudo update-alternatives --config java > /dev/null 2>&1
	java -version
	
	sudo apt-get install -y openjdk-8-jdk > /dev/null 2>&1
	sudo update-alternatives --config javac > /dev/null 2>&1
	javac -version
fi
