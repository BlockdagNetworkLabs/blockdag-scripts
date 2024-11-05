#!/bin/bash

minning_address=$1
# Get Docker Compose version
docker_compose_version=$(docker compose version | awk '{print $4}')

# Check the major version of Docker Compose
if [[ "$docker_compose_version" =~ ^v2 ]]; then
    echo "Detected Docker Compose v2. Using the updated command syntax."
    MINING_ADDRESS=$mining_address docker compose up -d
else
    echo "Detected Docker Compose v1. Using the legacy command syntax."
    MINING_ADDRESS=$mining_address docker-compose up -d
fi
