#!/bin/bash

echo "startup script"

if service --status-all | grep -Fq 'postgresql'; then
	service=postgresql

	if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
		echo "$service is running!!!"
	else
		/etc/init.d/$service start
	fi
	
	/etc/init.d/$service status
	
	echo "service verification completed!"
	
	cd /home/pentaho/server/pentaho-server/
	
	printf 'ok\n' | ./start-pentaho.sh
else
	echo "postgresql service is not installed yet!"
fi
