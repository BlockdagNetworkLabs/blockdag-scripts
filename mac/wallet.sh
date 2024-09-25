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

# Extract and clean the private key
private_key=$(cat wallet.txt | grep -o 'pri:[^ ]*' | sed 's/pri://' | tr -d '\r')

# Debug: Check if the private key is correct
echo "Private Key is: '$private_key'"

# Navigate to the directory containing qx
cd ./bin/qx

# Use the private key to generate the public key address
pk_addr=$(./qx-mac ec-to-public "$private_key" | ./qx-mac ec-to-pkaddr -v=testnet)

# Check for errors in the public key generation process
if [ -z "$pk_addr" ]; then
    echo "Error: Failed to generate PK address"
    exit 1
fi

cd ../..

# Output and save the public key address
echo $pk_addr>>wallet.txt
echo "PK Address is: $pk_addr"
