#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install -y apache2
cd /var/www/html
rm -rf index.html
echo "<html><h1>Welcome Everyone</h1></html>" > index.html
