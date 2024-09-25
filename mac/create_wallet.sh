#!/bin/bash

# Check if the seed is passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <existing_seed>"
    exit 1
fi

# Assign the passed argument to EXISTING_SEED
EXISTING_SEED="$1"

# Define the wallet passphrase and other inputs
PASSPHRASE="test"
PUBPASS="public"
SEED_CONFIRMATION="OK"

cd ./bin/wallet

# Create the expect script
expect << EOF
set timeout -1
spawn ./blockdag-wallet-mac qc create
match_max 100000

# Enter the private passphrase for the new wallet
expect -exact "Enter the private passphrase for your new wallet: "
send -- "$PASSPHRASE\r"

# Confirm passphrase
expect -exact "\r
Confirm passphrase: "
send -- "$PASSPHRASE\r"

# Choose not to add an additional layer of encryption for public data
expect -exact "\r
Do you want to add an additional layer of encryption for public data? (n/no/y/yes) \[no\]: "
send -- "n\r"

# Set the public passphrase
expect -exact "n\r
pubPass: $PUBPASS\r
Do you have an existing wallet seed you want to use? (n/no/y/yes) \[no\]: "
send -- "y\r"

# Enter the existing wallet seed (passed as an argument)
expect -exact "y\r
Enter existing wallet seed: "
send -- "$EXISTING_SEED\r"

# Wallet creation message and private key extraction
expect -exact "\r
Creating the wallet...\r"
expect -re {pri:[a-f0-9]{64}}
set private_key \$expect_out(0,string)
puts "Private key is: \$private_key"

# Final success message
expect -exact "The wallet has been created successfully.\r
createWallet succ\r"

expect eof
EOF
