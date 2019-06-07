#!/bin/bash

if [ ! -d "/vagrant/jar_dependencies/" ]; then
	mkdir /vagrant/jar_dependencies/
fi

# download https://jdbc.postgresql.org/download/postgresql-42.2.5.jar

if [ -e /vagrant/jar_dependencies/postgresql-42.2.5.jar ]; then
	echo "postgresql jar connector already downloaded"
else
	echo "downloading postgresql jar connector"
	
	wget -q https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O /vagrant/jar_dependencies/postgresql-42.2.5.jar
fi
