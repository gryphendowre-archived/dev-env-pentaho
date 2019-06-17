#!/bin/bash

# check if the docker service exists
if service --status-all | grep -Fq 'docker'; then
	# Start the docker container
	sudo docker container start pentaho_container_1
	
	# Check that the application containers have been created by executing:
	sudo docker container ls --all

	# Run the startup script
	sudo docker exec pentaho_container_1 /bin/sh /customizations/startup.sh

	# Let's check to see that the application is up. We can get the IP of the pentaho_box container by executing:

	WEB_APP_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' pentaho_container_1)
	echo "Web app available in the IP address $WEB_APP_IP inside vagrant box"
	
	# Give time for the server to start
	sleep 10
else
	echo "Docker service is not available yet!"
fi
