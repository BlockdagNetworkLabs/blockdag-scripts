#!/bin/bash

mining_address=$1
echo "mining address: $mining_address"
MINING_ADDRESS=$mining_address docker-compose up -d
