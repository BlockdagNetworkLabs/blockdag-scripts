# BlockDAG Makefile Guide

This Makefile provides a simplified interface for managing BlockDAG nodes, working with the actual versioning system used by `blockdagnetwork/primordial`.

## Quick Start

```bash
# Ensure make is installed
apt install make

# Ensure wallet and bdagex binaries are downloaded
wget -O "bin/wallet/blockdag-wallet" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/blockdag-wallet" && wget -O "bin/bdagex/bdagex" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/bdagex"

# Option 1: One command setup (if you don't have a wallet)
make setup-and-run

# Option 2: Step by step
make help               # See all commands
make wallet             # Create a wallet
make pull               # Pull latest image  
make run                # Run the node
make logs               # Check logs
make stop               # Stop when done
```

## Available Commands

### Using Official Images
- `make help` - Show all available commands
- `make pull` - Pull latest official BlockDAG image 
- `make run` - Run BlockDAG node with docker-compose (requires wallet)
- `make stop` - Stop running BlockDAG node
- `make logs` - Show node logs  
- `make check-versions` - Check available versions on DockerHub

### Wallet Management
- `make wallet` - Create wallet.txt from your supplied wallet public key
- `make wallet-restore SEED='your seed'` - Restore wallet from seed phrase
- `make wallet-info` - Show current wallet information

### Custom Development (if you have a Dockerfile)
- `make build-custom` - Build custom development image
- `make push-custom` - Push custom image to DockerHub

### Maintenance
- `make clean` - Clean up local images
- `make update-version VERSION=v0.0.2` - Update to specific version

## Version Management

Currently supports:
- **Current Official Version**: `v0.0.1`

## Backup

The previous tagging system has been backed up to:
- `backup-tagging-system/Makefile.backup`
- `backup-tagging-system/scripts/`
