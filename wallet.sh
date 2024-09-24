#!/bin/bash
#bash clean.sh

# Check if a wallet seed was provided as an argument
if [ -z "$1" ]; then
    # Generate a new wallet and capture the output
    output=$(bash generate_wallet.sh)
else
    # Create a wallet with the provided seed and capture the output
    output=$(bash create_wallet.sh "${1}")
fi
# Check if the output contains "db is exist"
if echo "$output" | grep -q "db is exist"; then
    echo "Wallet already exists. Aborting wallet creation."
    exit 1
fi

# Proceed to create the wallet.txt file
echo "$output" > wallet.txt

private_key=$(cat wallet.txt|grep -oP 'pri:\K[^\s]+')

echo "private Key is : $private_key"

cd ./bin/qx
echo "PK Address is : "
pk_addr=$(./qx ec-to-public $private_key | ./qx ec-to-pkaddr -v=testnet)
cd ../..
echo $pk_addr>>wallet.txt
echo "$pk_addr"
# ./blockdag-wallet qc updateblock
