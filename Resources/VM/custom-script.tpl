#!/bin/bash
apt-get update && apt-get upgrade
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
wget https://rishistorage25d2.blob.core.windows.net/docker-images/Doc
docker build -t wordpress
docker run -d --name wordpress -p 80:80 wordpress