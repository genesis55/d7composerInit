#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  errorMessage="Build requires a sitename and port as follows: ./build sitename 8080 volumedirectory (/var/docker_volumes/sitename)"
  echo $errorMessage
  echo "SYNTAX: ./build.sh <sitename> <port> <volumedirectory>"
  exit 1;
fi

rm -rf $3
docker kill $1
docker rm $1
docker build -t httpd .
IPAddress=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' maria)
#$2 is port, $1 is site/database name#
docker run --name $1 -v $3:/var/www/html -e IPADDRESS=$IPAddress -p $2:80 -e DB=$1 -d httpd


