#!/bin/bash

echo 'Starting Provision: webserver'
sudo apt-get update
sudo service nginx stop
sudo rm -rf /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-enabled/default
echo "upstream testapp {
        server 192.168.33.11;
        server 192.168.33.12;
}
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        root /usr/share/nginx/html;
        index index.html index.htm;
        # Make site accessible from http://localhost/
        server_name localhost;
        location / {
                proxy_pass http://testapp;
        }
}" >> /etc/nginx/sites-enabled/default
sudo service nginx start
echo "<h1>Hello World</h1> <p>Machine: webserver</p>" >> /usr/share/nginx/html/index.html
echo 'Provision webserver complete'