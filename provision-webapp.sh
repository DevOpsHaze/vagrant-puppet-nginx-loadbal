#!/bin/bash

echo 'Starting Provision: webapp'$1
sudo apt-get update
sudo apt-get install -y nginx
echo "<h1>Hello World</h1> <p>Machine: webapp"$1"</p>" >> /usr/share/nginx/html/index.html
echo 'Provision webapp'$1 'complete'