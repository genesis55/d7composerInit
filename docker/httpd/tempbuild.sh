#!/bin/bash
DOCKERNAME=$1
docker kill $1
docker rm $1
docker build -t $1 .
#sudo rm -rf /Users/einolfs/docker_volumes/metastatic/*
docker run --name $1 -p 80:80 -d httpd

