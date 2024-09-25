#!/bin/bash

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
send -- "n\r"

# Display the generated seed and prompt to confirm storage
expect -exact "n\r
Your wallet generation seed is:\r"
expect -re {[a-f0-9]{64}}
set seed \$expect_out(0,string)
puts "Your wallet generation seed is: \$seed"

# Important notice and prompt to confirm
expect -exact "\r
IMPORTANT: Keep the seed in a safe place as you\r
will NOT be able to restore your wallet without it.\r
Please keep in mind that anyone who has access\r
to the seed can also restore your wallet thereby\r
giving them access to all your funds, so it is\r
imperative that you keep it in a secure location.\r
Once you have stored the seed in a safe and secure location, enter \"OK\" to continue: "
send -- "$SEED_CONFIRMATION\r"

expect eof
EOF
