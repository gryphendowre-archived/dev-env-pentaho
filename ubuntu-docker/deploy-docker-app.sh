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
	fi
else
	echo "Docker service is not available yet!"
fi
