#!/bin/bash

# check if the docker service exists
if service --status-all | grep -Fq 'docker'; then
	# Restart the daemon
	sudo service docker restart

	# Istantiate a container based on the image you just built
	sudo docker container run -i -d --name pentaho_container_1 -p 8080:8080 -p 8443:8443 -p 5432:5432 ubuntubionic_web

	# Check that the application containers have been created by executing:
	sudo docker container ls --all

	# Run the startup script
	sudo docker exec pentaho_container_1 /bin/sh /customizations/startup.sh

	# Let's check to see that the application is up. We can get the IP of the pentaho_box container by executing:

	WEB_APP_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' pentaho_container_1)
	echo "Web app available in the IP address $WEB_APP_IP inside vagrant box"
else
	echo "Docker service is not available yet!"
fi
