#!/bin/bash

# check if the docker service exists
if service --status-all | grep -Fq 'docker'; then
	echo "Deploy the \"Hello World\" Application"

	# Restart the daemon
	sudo service docker restart > /dev/null 2>&1

	# This line builds our local application image from the Dockerfile file.
	sudo docker-compose -f /vagrant/hello_world/docker-compose.yml build > /dev/null 2>&1

	# Restart the daemon
	sudo service docker restart > /dev/null 2>&1

	# This line runs the web and redis containers in daemon mode (-d), as specified in the docker-compose.yml file.
	sudo docker-compose -f /vagrant/hello_world/docker-compose.yml up -d > /dev/null 2>&1

	# Check that the application containers have been created by executing:
	sudo docker ps

	# Let's check to see that the application is up. We can get the IP of the helloworld_web_1 container by executing:

	WEB_APP_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' helloworld_web_1)
	echo "Web app available in the IP address $WEB_APP_IP"

	# Check that the web application is returning the proper message:
	WEB_APP_CONTENT=$(curl -s http://${WEB_APP_IP}:80)
	echo "web app content: $WEB_APP_CONTENT"

else
	echo "Docker service is not available yet!"
fi
