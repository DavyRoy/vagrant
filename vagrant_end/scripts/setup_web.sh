#!/bin/bash
apt update -y
apt install -y nginx
echo "<h1>Vagrant Web Server</h1>" > /var/www/html/index.html
systemctl restart nginx
