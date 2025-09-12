# BlockDAG Node Setup Documentation

## Table of Contents
1. [Hardware Requirements](#hardware-requirements)
2. [Prerequisites](#prerequisites)
3. [Quick Start](#quick-start)
4. [Make Commands Reference](#make-commands-reference)
5. [Troubleshooting](#troubleshooting)

---

## Hardware Requirements

- **CPU**: Minimum 4 cores (4+ cores recommended for mining)
- **Memory (RAM)**: At least 8GB (8GB+ recommended)
- **Disk Space**: Minimum 20GB of free disk space. More storage is recommended depending on the size of the blockchain and logs
- **Network**: A stable internet connection with sufficient bandwidth

---
## Prerequisites

### Supported Operating Systems
- **Ubuntu**: 18.04 LTS or later
- **macOS**: 13 (Ventura) or later

### Required Software

1. **Docker Installation**: Docker should be installed on your system. If it is not installed, follow the steps in the [official Docker documentation](https://docs.docker.com/get-docker/) to install Docker.

2. **Git**: Git is required for version control and managing repositories.
   - For Debian/Ubuntu-based systems:
     ```bash
     sudo apt update
     sudo apt install git
     ```
   - For macOS, install Git using Homebrew:
     ```bash
     brew install git
     ```

3. **Wget**: Used for downloading binaries.
   - For Debian/Ubuntu-based systems:
     ```bash
     sudo apt update
     sudo apt install wget
     
     # Ensure make is installed
     apt install make
     ```
   - For macOS:
     ```bash
     brew install wget
     ```

4. **Make**: Make is required for running the make commands.
  - For Debian/Ubuntu-based systems:
     ```bash
     apt install make
     ```

---


## Quick Start

### Option 1: One Command Setup (Recommended)
```bash
# Clone the repository
git clone https://github.com/BlockdagNetworkLabs/blockdag-scripts

# Ensure wallet and bdagex binaries are downloaded
wget -O "bin/wallet/blockdag-wallet" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/blockdag-wallet" && wget -O "bin/bdagex/bdagex" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/bdagex"

cd blockdag-scripts/linux

# Run everything in one command
make setup-and-run
```

### Option 2: Step by Step
```bash
# Clone the repository
git clone https://github.com/BlockdagNetworkLabs/blockdag-scripts
cd blockdag-scripts/linux

# Ensure wallet and bdagex binaries are downloaded
wget -O "bin/wallet/blockdag-wallet" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/blockdag-wallet" && wget -O "bin/bdagex/bdagex" "https://github.com/BlockdagNetworkLabs/blockdag-scripts/releases/download/v1.0.1/bdagex"

# Create a wallet
make wallet

# Pull the latest Docker image
make pull

# Start the node
make run

# Check logs
make logs

# Stops the node
make stop 
                 
```

---


## Make Commands Reference

### Getting Help
```bash
make help                    # Show all available commands
```

### Wallet Management
```bash
make wallet                  # Create a new wallet
make wallet-restore SEED='your seed phrase'  # Restore wallet from seed
make wallet-info            # Show current wallet information
```

### Node Operations
```bash
make pull                    # Pull latest official BlockDAG image
make run                     # Run BlockDAG node with docker-compose
make stop                    # Stop running BlockDAG node
make logs                    # Show node logs (follow mode)
```

### Maintenance & Cleanup
### BEWARE THIS REMOVES YOUR WALLET FILES. ENSURE YOU HAVE BACKED UP YOUR WALLET GENERATION SEED
make clean  
```bash
make clean                   # Clean up local images and all data
make clean-data              # Clean up blockchain data only (keep images)
make restart-clean           # Restart node with blockchain cleanup
```

### Advanced Operations
```bash
make check-versions          # Check available versions on DockerHub
make update-version VERSION=v1.0.2  # Update to specific version
```

---

## Troubleshooting

### Common Issues

#### 1. Blockchain Corruption Error
If you see the error: `The dag data was damaged (Can't find tip:12302)`

**Solution:**
```bash
make restart-clean
```

#### 2. Wallet Creation Issues
If wallet creation fails with "expect: command not found":

**Solution:**
```bash
sudo apt install expect
make wallet
```

#### 3. Docker Permission Issues
If you get Docker permission errors:

**Solution:**
```bash
# Add your user to docker group
sudo usermod -aG docker $USER
# Log out and log back in, then try again
make setup-and-run
```

#### 4. Node Won't Start
If the node fails to start:

**Solution:**
```bash
# Check if Docker is running
docker --version

# Clean everything and start fresh
make clean
make setup-and-run
```

### Checking Node Status

```bash
# Check if the node is running
docker ps

# View real-time logs
make logs

# Check wallet information
make wallet-info
```

### Stopping the Node

```bash
# Stop the node gracefully
make stop

# Stop and clean up everything
make clean
```

---

## Important Notes

### Security
- **Wallet Seed**: Store your wallet seed phrase securely. If lost, you cannot recover your wallet or funds.
- **Private Key**: Keep your private key safe and never share it.
- **wallet.txt**: This file contains sensitive information. Keep it secure.

### Mining
- Your node will automatically start mining with the created wallet address
- Mining rewards will be sent to your wallet address
- The node runs on the BlockDAG testnet (Chain ID: 1043)

### Data Storage
- Blockchain data is stored in `bin/bdag/data/`
- Logs are stored in `bin/bdag/logs/`
- Wallet information is stored in `wallet.txt`

### Network Information
- **Testnet**: BlockDAG Testnet (Chain ID: 1043)
- **Consensus**: BDAG (Proof-of-Work)
- **RPC Port**: 38131
- **HTTP Port**: 18545
- **WebSocket Port**: 18546

---

## Support

For additional help and support:
- Check the [BlockDAG Network Documentation](https://docs.blockdag.network/)
- Visit the [BlockDAG Community](https://community.blockdag.network/)
- Report issues on [GitHub](https://github.com/BlockdagNetworkLabs/blockdag-scripts/issues)