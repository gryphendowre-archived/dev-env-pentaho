#!/bin/bash

# check if the docker service exists
if service --status-all | grep -Fq 'docker'; then
	if [ "$1" == "hello_world" ]; then
		# Start the docker container
		sudo docker container start helloworld_web_1

		# Check that the application containers have been created by executing:
		sudo docker ps

		# Let's check to see that the application is up. We can get the IP of the helloworld_web_1 container by executing:
		WEB_APP_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' helloworld_web_1)
		echo "web app available in the IP address $WEB_APP_IP inside vagrant box"

		# Check that the web application is returning the proper message:
		WEB_APP_CONTENT=$(curl -s http://${WEB_APP_IP}:80)
		echo "web app content: $WEB_APP_CONTENT"
	fi

	if [ "$1" == "ubuntu_bionic" ]; then
		# Start the docker container
		sudo docker container start pentaho_container_1

		# Check that the application containers have been created by executing:
		sudo docker container ls --all

		# Run the startup script
		sudo docker exec pentaho_container_1 /bin/sh /customizations/startup.sh

		# Let's check to see that the application is up. We can get the IP of the pentaho_container_1 container by executing:
		WEB_APP_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' pentaho_container_1)
		echo "web app available in the IP address $WEB_APP_IP inside vagrant box"

		# Give time for the server to start
		sleep 10
	fi
else
	echo "Docker service is not available yet!"
fi
