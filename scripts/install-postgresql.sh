#!/bin/bash

echo "installing postgresql version $1 on ubuntu $2"

sudo rm /etc/apt/sources.list.d/pgdg.*

if [ "$2" == "14.04" ]; then
	echo deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null 2>&1
fi

if [ "$2" == "16.04" ]; then
	echo deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null 2>&1
fi

# add the public GPG key
wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# update package list
sudo apt-get update > /dev/null 2>&1

# install postgresql

if [ "$1" == "9.4" ]; then
	sudo apt-get -y install postgresql-9.4 postgresql-contrib-9.4 > /dev/null 2>&1
fi

if [ "$1" == "9.5" ]; then
	sudo apt-get -y install postgresql-9.5 postgresql-contrib-9.5 > /dev/null 2>&1
fi

# create a vagrant user - host: localhost, db: postgres, port number: 5432, username: vagrant, password: vagrant
sudo -u postgres psql -c "CREATE USER vagrant WITH SUPERUSER CREATEDB ENCRYPTED PASSWORD 'vagrant'" > /dev/null 2>&1

# restart the db
sudo /etc/init.d/postgresql restart > /dev/null 2>&1

# install pg admin
sudo apt-get -y install pgadmin3 > /dev/null 2>&1
