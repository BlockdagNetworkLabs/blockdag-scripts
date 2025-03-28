#!/bin/bash

docker-compose down

docker rmi blockdagnetwork/primordial

sudo rm -rf ./bin/bdag/*

pk_addr=$(tail -n 1 "wallet.txt")

# restart the blockdag node
bash node.sh $pk_addr

