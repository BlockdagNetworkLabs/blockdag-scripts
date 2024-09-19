#!/bin/bash

pushd /home/ubuntu/blockdag_scripts/bin/wallet
./blockdag-wallet qc createnewaccount test4 test 
sleep 2
receiver_addr=$(./blockdag-wallet qc getnewaddress test4)
echo $receiver_addr
echo "utxo :  "
utxo=$(./blockdag-wallet qc sendtoaddress $receiver_addr 0 100 test)
#echo $(./blockdag-wallet qc sendtoaddress $receiver_addr 0 100 test) >utxo.txt
popd

echo $utxo>utxo.txt
sleep 2
