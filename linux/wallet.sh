#!/bin/bash

bash download_wallet.sh
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

cd ./bin/bdagex
echo "PK Address is : "
pk_addr=$(./bdagex ec-to-public $private_key | ./bdagex ec-to-pkaddr -v=testnet)
cd ../..
echo $pk_addr>>wallet.txt
echo "$pk_addr"
