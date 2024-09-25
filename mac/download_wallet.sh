#!/bin/bash

BINARY_NAME_WALLET="blockdag-wallet-mac"  
DOWNLOAD_URL_WALLET="https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/latest/download/blockdag-wallet-mac"  
DOWNLOAD_PATH_WALLET="bin/wallet"  
BINARY_NAME="qx-mac"  
DOWNLOAD_URL="https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/latest/download/qx-mac"  
DOWNLOAD_PATH="bin/qx"  


# Check if the binary exists in the system
if ! command -v "$DOWNLOAD_PATH/$BINARY_NAME" &> /dev/null; then
    echo "$BINARY_NAME not found. Downloading..."

    # Download the binary using curl
    wget "$DOWNLOAD_URL" -P "$DOWNLOAD_PATH"

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
    wget "$DOWNLOAD_URL_WALLET" -P "$DOWNLOAD_PATH_WALLET"

    echo "$BINARY_NAME_WALLET has been downloaded and installed at $DOWNLOAD_PATH_WALLET."
else
    echo "$BINARY_NAME_WALLET is already downloaded."
fi

# Make the binary executable
chmod +x "$DOWNLOAD_PATH_WALLET/$BINARY_NAME_WALLET"
