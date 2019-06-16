#!/bin/bash

# check if the docker service exists
if service --status-all | grep -Fq 'docker'; then
	# Remove all stopped containers (-f = Do not prompt for confirmation)
	sudo docker system prune -a -f
	
	if [ "$1" == "hello_world" ]; then
		echo "Deploy the \"Hello World\" Application"

		# Restart the daemon
		sudo service docker restart > /dev/null 2>&1

		# This line builds our local application image from the Dockerfile file
		sudo docker-compose -f /vagrant/hello_world/docker-compose.yml build > /dev/null 2>&1

		# Restart the daemon
		sudo service docker restart > /dev/null 2>&1

		# This line runs the web and redis containers in daemon mode (-d), as specified in the docker-compose.yml file
		sudo docker-compose -f /vagrant/hello_world/docker-compose.yml up -d > /dev/null 2>&1

		# Check that the application containers have been created by executing:
		sudo docker ps

		# Let's check to see that the application is up. We can get the IP of the helloworld_web_1 container by executing:

		WEB_APP_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' helloworld_web_1)
		echo "Web app available in the IP address $WEB_APP_IP"

		# Check that the web application is returning the proper message:
		WEB_APP_CONTENT=$(curl -s http://${WEB_APP_IP}:80)
		echo "web app content: $WEB_APP_CONTENT"
	fi
	
	if [ "$1" == "ubuntu_bionic" ]; then
		echo "Deploy the \"Ubuntu Bionic\" Application"
		
		# Restart the daemon
		sudo service docker restart
		
		# This line builds our local application image from the Dockerfile file
		sudo docker-compose -f /vagrant/ubuntu_bionic/docker-compose.yml build

		# Restart the daemon
		sudo service docker restart

		# Istantiate a container based on the image you just built
		sudo docker container run -i -d --name pentaho_container_1 -p 8080:8080 -p 8443:8443 -p 5432:5432 ubuntubionic_web

		# Check that the application containers have been created by executing:
		# sudo docker ps
		# sudo docker container ls
		sudo docker container ls --all
		
		# Run the startup script
		sudo docker exec pentaho_container_1 /bin/sh /customizations/startup.sh
		
		# Let's check to see that the application is up. We can get the IP of the pentaho_box container by executing:

		WEB_APP_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' pentaho_container_1)
		echo "Web app available in the IP address $WEB_APP_IP"
	fi
else
	echo "Docker service is not available yet!"
fi
