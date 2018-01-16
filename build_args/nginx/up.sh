#!/bin/bash

echo "killing all project containers:"
docker rmi -f $(docker images)

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$WORKER_PROCESSES'
envsubst "$NGINX_VARS" < ./nginx-template.conf > nginx.conf

sudo docker-compose up -d
