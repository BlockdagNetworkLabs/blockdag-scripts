#!/bin/bash

minning_address=$1
echo "mining address: $minning_address"
MINNING_ADDRESS=$minning_address docker-compose up -d
