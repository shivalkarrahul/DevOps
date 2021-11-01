#!/bin/bash

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"

cd /home/ubuntu/nodejs-docker/
$COMPOSE run certbot renew --dry-run && $COMPOSE kill -s SIGHUP webserver
#$COMPOSE run certbot renew && $COMPOSE kill -s SIGHUP webserver
$DOCKER system prune -af
