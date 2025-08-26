# BlockDAG Makefile Guide

This Makefile provides a simplified interface for managing BlockDAG nodes, working with the actual versioning system used by `blockdagnetwork/primordial`.

## Quick Start

```bash
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

## If You Don't Have a Wallet

**Don't worry!** The Makefile now handles wallet management:

```bash
# Create a new wallet
make wallet

# Or restore from existing seed
make wallet-restore SEED='your twelve word seed phrase here'

# Check your wallet info anytime
make wallet-info

# Or do everything in one command
make setup-and-run
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
- `make wallet` - Create a new wallet
- `make wallet-restore SEED='your seed'` - Restore wallet from seed phrase
- `make wallet-info` - Show current wallet information
- `make setup-and-run` - Create wallet and run node (one command)

### Custom Development (if you have a Dockerfile)
- `make build-custom` - Build custom development image
- `make push-custom` - Push custom image to DockerHub

### Maintenance
- `make clean` - Clean up local images
- `make update-version VERSION=v1.0.2` - Update to specific version

## Version Management

Currently supports:
- **Current Official Version**: `v1.0.1` 
- **Previous Version**: `v1.0.0`
- **Custom Dev Images**: `mattblockdag/blockdag-dev-node:dev`

## Backup

The previous tagging system has been backed up to:
- `backup-tagging-system/Makefile.backup`
- `backup-tagging-system/scripts/`

## Integration with Existing Scripts

This Makefile works alongside your existing BlockDAG scripts:
- Still use `./wallet.sh` to create wallets
- Still use `./blockdag.sh` for quick setup
- This Makefile provides additional Docker management capabilities
