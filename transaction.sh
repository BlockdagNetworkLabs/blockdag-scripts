#!/bin/bash

# get utxo
bash get_utxo.sh

# fetch utxo 
utxo=$(tail -n 1 "utxo.txt")
echo "utxo is"
echo $utxo
#fetch pk_address where we need to transfer money
pk_addr=$(tail -n 1 "wallet.txt")
# fetch private_key for signing transaction
private_key=$(cat wallet.txt|grep -oP 'pri:\K[^\s]+')
# amount we need to transfer
if [ -z "$1" ]; then
    amount=100
else
    amount=$1
fi

# make an unsigned tx for transfer utxo to evm and then sign it
pushd /data/finl_blockdag/test/blockdag/bin/qx
signed_tx_hash=$(./qx tx-encode -v 1 -i $utxo:1:4294967295:pubkey -l 0 -o $pk_addr:$amount:1:pubkey -o $pk_addr:299.99992700:0:pubkey | ./qx tx-sign -k $private_key -n testnet)
popd

sleep 3
echo "signed tx"
echo $signed_tx_hash
# # send a raw tx for transfer
pushd /data/finl_blockdag/test/blockdag/bin/cli
tx_id=$(./blockdag-cli sendRawTransaction $signed_tx_hash true)
sleep 2
echo "transaction id is : $tx_id"
echo "\n transaction data is : "
./blockdag-cli getRawTransaction ${tx_id//\"/}
popd

