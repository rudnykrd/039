#!/bin/sh

apt-get remove docker docker-engine docker.io containerd runc
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant
docker network create wpnet
docker run --name db -e MYSQL_DATABASE=wordpress -e MYSQL_USER=username -e MYSQL_PASSWORD=password --network wpnet -d rudnykrd/db:latest
docker run --name wp --link db:dbhost -p 443:443 --network wpnet -d rudnykrd/wp-https:latest