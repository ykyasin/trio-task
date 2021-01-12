#!/bin/bash

password=root
docker rm -f $(docker ps -qa)
docker rmi -f $(docker images)
docker network prune


docker network create trio-task
docker volume create trio-task

docker build -t trio-task-mysql db
docker run -d \
       	--network trio-task \
	--name mysql \
	--mount type=volume,source=trio-mysql,target=/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$password \
	trio-task-mysql

docker build -t trio-task-flask-app flask-app
docker run -d \
	--network trio-task \
	--name flask-app \
	-e DATABASE_PASSWORD=$password \
	trio-task-flask-app
docker run -d \
	--network trio-task \
	-p 80:80 \
	--mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
	--name nginx nginx:alpine
