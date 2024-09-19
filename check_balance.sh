#!/bin/bash 

pk_addr=$(tail -n 1 "wallet.txt")
pushd ./bin/wallet
./blockdag-wallet qc getbalance $pk_addr
popd

