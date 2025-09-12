#!/bin/bash

BINARY_NAME_WALLET="blockdag-wallet"  
DOWNLOAD_URL_WALLET="https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/blockdag-wallet"  
DOWNLOAD_PATH_WALLET="bin/wallet"  
BINARY_NAME="bdagex"  
DOWNLOAD_URL="https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/bdagex"  
DOWNLOAD_PATH="bin/bdagex"  


# Check if the binary exists in the system
if ! command -v "$DOWNLOAD_PATH/$BINARY_NAME" &> /dev/null; then
    echo "$BINARY_NAME not found. Downloading..."

    # Download the binary using curl
    #curl -L "$DOWNLOAD_URL" -o "$DOWNLOAD_PATH/$BINARY_NAME"
    wget -O "$DOWNLOAD_PATH/$BINARY_NAME" "$DOWNLOAD_URL"

    echo "$BINARY_NAME has been downloaded and installed at $DOWNLOAD_PATH."
else
    echo "$BINARY_NAME is already downloaded."
fi

# Make the binary executable
chmod +x "$DOWNLOAD_PATH/$BINARY_NAME"

# Check if the binary exists in the system
if ! command -v "$DOWNLOAD_PATH_WALLET/$BINARY_NAME_WALLET" &> /dev/null; then
    echo "$BINARY_NAME_WALLET not found. Downloading..."

    # Download the binary using curl
    #curl -L "$DOWNLOAD_URL_WALLET" -o "$DOWNLOAD_PATH_WALLET/$BINARY_NAME_WALLET"
    wget -O "$DOWNLOAD_PATH_WALLET/$BINARY_NAME_WALLET" "$DOWNLOAD_URL_WALLET"

    echo "$BINARY_NAME_WALLET has been downloaded and installed at $DOWNLOAD_PATH_WALLET."
else
    echo "$BINARY_NAME_WALLET is already downloaded."
fi

# Make the binary executable
chmod +x "$DOWNLOAD_PATH_WALLET/$BINARY_NAME_WALLET"
