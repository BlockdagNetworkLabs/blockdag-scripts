#!/bin/bash

minning_address=$1

MINNING_ADDRESS=$minning_address docker-compose up -d

# docker run -d -p 38131:38131 -p 38130:38130 -p 8130:8130 -p 18545:18545 --name bdag ravin863/bdag:latest ./bdag --testnet --rpclisten=0.0.0.0:38131 --notls --rpcuser=test --rpcpass=test --miner --miningaddr=$minning_address --generate --walletpass=test --evmenv="--http --http.port=18545 --http.addr=0.0.0.0 --http.api=net,web3,eth,bdag --ws --ws.port=18546"  --miningstatesync 
   
