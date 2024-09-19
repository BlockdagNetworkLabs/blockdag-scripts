#!/bin/bash
bash clean.sh
bash generate_wallet.sh >wallet.txt
private_key=$(cat wallet.txt|grep -oP 'pri:\K[^\s]+')

echo "private Key is : $private_key"

pushd /home/ubuntu/blockdag_scripts/bin/qx
echo "PK Address is : "
pk_addr=$(./qx ec-to-public $private_key | ./qx ec-to-pkaddr -v=testnet)
popd
echo $pk_addr>>wallet.txt
echo $pk_addr
# ./blockdag-wallet qc updateblock
