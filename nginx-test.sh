#!/bin/bash

# Test whether nginx is listening on port 80...

if sudo netstat -lnp|grep ':80.*nginx' >/dev/null;
then 
echo "Nginx is listening on port 80"; 
else
"Nginx is not running on port 80"
fi

#Ensure Hello World application is available via Nginx instance
if curl -I --silent http://192.168.33.10 | head -n 2| cut -d $' ' -f2 |grep 'nginx' >/dev/null;
then
echo "Hello World is being served by Nginx";
fi