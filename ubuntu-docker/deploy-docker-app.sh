#!/bin/bash
echo "Deploy the \"Hello World\" Application"

# Restart the daemon
sudo service docker restart

# This line builds our local application image from the Dockerfile file.
sudo docker-compose -f /vagrant/hello_world/docker-compose.yml build

# Restart the daemon
sudo service docker restart

# This line runs the web and redis containers in daemon mode (-d), as specified in the docker-compose.yml file.
sudo docker-compose -f /vagrant/hello_world/docker-compose.yml up -d

# Check that the application containers have been created by executing:
sudo docker ps

# Let's check to see that the application is up. We can get the IP of the helloworld_web_1 container by executing:

WEB_APP_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' helloworld_web_1)
echo $WEB_APP_IP

# Check that the web application is returning the proper message:
curl http://${WEB_APP_IP}:80
