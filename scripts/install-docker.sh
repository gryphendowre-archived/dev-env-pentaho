#!/bin/bash
echo "installing docker"

# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
# https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=94798094
# https://websiteforstudents.com/how-to-install-docker-and-docker-compose-on-ubuntu-16-04-18-04/

if [ "$1" == "18.04" ] ; then
	# Set up the repository
	sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null 2>&1
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" > /dev/null 2>&1
	sudo apt-get update > /dev/null 2>&1
	
	# Install Docker Community Edition(CE).
	sudo apt-get update > /dev/null 2>&1
	sudo apt-get install -y docker-ce > /dev/null 2>&1
	sudo systemctl status docker
	
	# Verify that Docker CE is installed correctly by running the hello-world image.
	sudo docker run hello-world
	
	# Executing Docker without sudo
	sudo usermod -aG docker ${USER} > /dev/null 2>&1
	su - ${USER} > /dev/null 2>&1
	id -nG > /dev/null 2>&1
	
	docker version
	
	# Installing docker-compose
	sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
	sudo chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1
	docker-compose --version
fi
