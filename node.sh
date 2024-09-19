#!/bin/bash

minning_address=$1


docker run --rm -it --name bdag ravin863/bdag:latest ./bdag --testnet --rpclisten=0.0.0.0:38131 --notls --rpcuser=test --rpcpass=test --miner --miningaddr=$minning_address --generate --walletpass=test --evmenv="--http --http.port=18545 --http.addr=0.0.0.0 --http.api=net,web3,eth,bdag --ws --ws.port=18546"  --miningstatesync 
   
