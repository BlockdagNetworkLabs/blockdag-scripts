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
     ```
   - For macOS:
     ```bash
     brew install wget
     ```

4. **Make**: Make is required for running the make commands.
  - For Debian/Ubuntu-based systems:
    ```bash
     sudo apt install make
    ```
  - For macOS:
    ```bash
    brew install make
    ```

5. **Clone the repository**
```bash
  sudo git clone https://github.com/BlockdagNetworkLabs/blockdag-scripts
```
---


## Quick Start

### Option 1: Simple (Recommended)
# Setup

If you are a linux distribution user then use the following command:
```bash
# Ensure docker is installed 
docker -v

cd blockdag-scripts/linux
```

If you are a mac OS user then use the following command:
```bash
# Ensure docker is installed 
docker -v

cd blockdag-scripts/mac
```


# Run everything in one command (will prompt for ETH wallet)
```bash
sudo make setup-and-run

# Please see the Make Commands Reference for cleanup and maintenance commands
```



### Option 2: Step by Step
```bash
# Clone the repository
git clone https://github.com/BlockdagNetworkLabs/blockdag-scripts
cd blockdag-scripts/linux

# Configure ETH-compatible wallet (will prompt for your ETH address)
sudo make wallet

# Pull the latest Docker image
sudo make pull

# Start the node
sudo make run

# Check logs
sudo make logs

# Please see the Make Commands Reference for cleanup and maintenance commands
```

---


## Make Commands Reference

### Getting Help
```bash
sudo make help                    # Show all available commands
```

### Wallet Management
```bash
sudo make wallet                  # Configure ETH-compatible wallet (prompts for address)
sudo make wallet-restore         # Configure ETH-compatible wallet (restore)
sudo make wallet-info            # Show current wallet information
```

### Node Operations
```bash
sudo make pull                    # Pull latest official BlockDAG image
sudo make run                     # Run BlockDAG node with docker-compose
sudo make stop                    # Stop running BlockDAG node
sudo make logs                    # Show node logs (follow mode)
```

### Maintenance & Cleanup
### BEWARE THIS REMOVES YOUR WALLET FILES. ENSURE YOU HAVE BACKED UP YOUR WALLET PUBLIC KEY
#### make clean  
```bash
sudo make clean                   # Clean up local images and all data
sudo make clean-data              # Clean up blockchain data only (keep images)
sudo make restart-clean           # Restart node with blockchain cleanup
```

### Advanced Operations
```bash
sudo make check-versions          # Check available versions on DockerHub
sudo make update-version VERSION=v1.0.2  # Update to specific version
```

---

## Troubleshooting

### Common Issues

#### 1. Blockchain Corruption Error
If you see the error: `The dag data was damaged (Can't find tip:12302)`

**Solution:**
```bash
sudo make restart-clean
```

#### 2. Docker Permission Issues
If you get Docker permission errors:

**Solution:**
```bash
# Add your user to docker group
sudo usermod -aG docker $USER
# Log out and log back in, then try again
make setup-and-run
```

#### 3. Node Won't Start
If the node fails to start:

**Solution:**
```bash
# Check if Docker is running
docker --version

# Clean everything and start fresh
sudo make clean
sudo make setup-and-run
```

### Checking Node Status

```bash
# Check if the node is running
docker ps

# View real-time logs
sudo make logs

# Check wallet information
sudo make wallet-info
```

### Stopping the Node

```bash
# Stop the node gracefully
sudo make stop

# Stop and clean up everything
sudo make clean
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