# BlockDAG Node Setup Documentation

## Table of Contents
1. [Hardware Requirements](#hardware-requirements)
2. [Setup Process](#setup-process)
   - [Prerequisites](#prerequisites)
   - [Step-by-Step Instructions](#step-by-step-instructions)
   - [Stopping the node](#stopping-and-cleaning-up-a-running-blockdag-node)
3. [Script Descriptions](#script-descriptions)
4. [Restart the blockdag network with updated image](#restart-the-blockdag-network-with-updated-image)

---

## Hardware Requirements

- **CPU**: Minimum 4 cores (4+ cores recommended for mining).
- **Memory (RAM)**: At least 8GB (8GB+ recommended).
- **Disk Space**: Minimum 20GB of free disk space. More storage is recommended depending on the size of the blockchain and logs.
- **Network**: A stable internet connection with sufficient bandwidth.
---

## Setup Process: Running a BlockDAG Node
To ensure smooth setup and operation of the BlockDAG node, the following software must be installed and configured on your system:

### Supported Operating Systems

- **Ubuntu**: 18.04 LTS or later
- **macOS**: 13 (Ventura) or later

### Prerequisites

1. **Docker Installation**: Docker should be installed on your system. If it is not installed, follow the steps in the [official Docker documentation](https://docs.docker.com/get-docker/) to install Docker.

2. **Git** : Git is required for version control and managing repositories. You can install Git by following these steps:
 - For Debian/Ubuntu-based systems:
   ```
   sudo apt update
   sudo apt install git
   ```
 - For MacOS, install Git using Homebrew:
   ```
   sudo brew install git
   ```
3. **Wget**
Wget is used to transfer data from or to a server and is often required for HTTP requests. To install Wget, use the following commands based on your operating system:
 - For **Debian/Ubuntu-based** systems:

   ```
   sudo apt update
   sudo apt install wget
   ```
 - For **MacOS**, install cURL using Homebrew:
   ```
   sudo brew install wget
   ```
4. **System Update and Required Package Installation for Linux**: Run the following commands to update your package list and install `expect` (a tool often used for automating interactive tasks in the terminal):

    ```bash
    sudo apt update
    sudo apt install expect
    ```

Once these prerequisites are installed, follow the steps below to run a full BlockDAG node.

---

## Step-by-Step Instructions

### Step 1: Clone the BlockDAG Scripts Repository

First, clone the BlockDAG scripts repository from GitHub using the following command:

```bash
git clone https://github.com/BlockdagNetworkLabs/blockdag-scripts
```
### Step 2: Setup the Repository

If you are a linux distribution user then use the following command:
```
cd blockdag-scripts/linux
```
If you are a mac OS user then use the following command:
```
cd blockdag-scripts/mac
```

### Step 3: Create a new wallet

To create a new wallet, run the following command:
```
./wallet.sh
```

To create a wallet with existing wallet generation seed, run the following command:
```
./wallet.sh YOUR_WALLET_SEED
```
> **NOTE**: 
> - The wallet seed is unique to each wallet. If the seed is lost, the wallet and its contents are permanently lost. Store it somewhere safely.
> - The generated wallet seed will be stored in the `wallet.txt` file. Keep this file secure somewhere, as it contains wallet seed information needed to recover your wallet. 


### Step 4: Running the Node

To run a full BlockDAG node in a testnet environment with mining enabled, follow these commands:

```
./blockdag.sh
```
> **Note**: 
> - This script will generate a new wallet if one does not already exist.
> - If the above command does not execute as expected, try running it with `sudo` to ensure elevated permissions.

>**Note**: Ignore if you see the following warning in MAC `!blockdag-testnet-network The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested 0.0s`

```
sudo ./blockdag.sh
```
if you have a wallet created, and have the public address then run the following command:

```
./node.sh YOUR_PUBLIC_ADDRESS
```
> **Note**: You can find your public address at the end of the `wallet.txt` file, if it was created using the `wallet.sh` script.


### Step 5: Checking Node Logs

Once the node is running, you can check the logs to monitor its status. Follow these steps:

1. **Check the Docker Status**: Run the following command to list all running Docker containers and verify whether your BlockDAG node is running:

    ```bash
    docker ps
    ```

   This command will display a list of all active Docker containers, including their names and IDs. If your BlockDAG node is listed, it indicates that the node is running. Use the container ID to manage the node.

2. **View Node Logs**: Use the following command to view the logs of your BlockDAG node:

    ```bash
    docker logs -f blockdag-testnet-network
    ```

> **Note**: The `-f` flag in the `docker logs` command will follow the logs, allowing you to see real-time output. If the commands do not work as expected, try using `sudo` for elevated permissions:

## Stopping and Cleaning Up a Running BlockDAG Node

To properly manage and maintain the BlockDAG node, follow the steps below to stop the node and clean up any residual data and logs.

### Stopping the Node

To stop a running BlockDAG node, execute the following command in your terminal:

```bash
docker stop blockdag-testnet-network
```

This will stop the node, ensuring all current processes are terminated.

### Cleaning Up Node Data and Logs
Once the node has been stopped, it's important to clean up any leftover data and logs to maintain optimal performance and disk space. To do this, run the following command:
```
docker run blockdagnetwork/bdag:latest ./bdag --cleanup
```
This command will:
 - **Remove residual data**: Clears any unnecessary data stored by the node.
 - **Delete old logs**: Deletes outdated logs to free up disk space and avoid clutter.

## Script Descriptions

### `blockdag.sh` Script 

The `blockdag.sh` script is responsible for the following key tasks:

- **Create a BlockDAG Wallet**: Generates a new wallet specifically for use in the BlockDAG network (if not found).
- **Start and Connect Miner Node**: Initiates the BlockDAG node and connects it to the BlockDAG testnet server.
- **Configure Miner**: Sets the created wallet as the designated miner for the node, enabling mining activities on the BlockDAG network.

> **Note**: Ensure that the wallet generated by this script is securely stored, as it will be used for mining operations.

---

### `clean.sh` Script 

The `clean.sh` script is designed to:

- **Remove Old Wallet**: Cleans up and deletes the existing wallet, including its associated files.
- **Reset Wallet Information**: Useful for scenarios where the wallet needs to be reset or refreshed, allowing the user to start with a clean slate.

> **Note**: Ensure you have backed up any important wallet details before running this script, as the deletion process is irreversible.

---
### `download_wallet.sh` Script

The `download_wallet.sh` script is designed to:
 - Download the required binaries 

---

### `generate_wallet.sh` Script 

The `generate_wallet.sh` script serves the following purposes:

- **Generate a New Wallet**: Creates a new wallet, including a private key and public address, which can be used for transactions and participation in the BlockDAG network.
- **Ready for Transactions or Mining**: The newly generated wallet can be utilized for conducting transactions or for mining operations on the BlockDAG network.

> **Note**: The wallet's private key and seed phrase should be securely stored, as they are required for accessing and managing the wallet.

---


### `install_docker.sh` (Ubuntu)

This script:

- Installs the Docker daemon on a Linux system.
- It ensures that Docker is set up and ready to be used for running the BlockDAG node.
>**Note**: This script is only compatible with `Ubuntu 20.04` or higher.

---

### `node.sh` Script 

The `node.sh` script is responsible for the following tasks:

- **Start the BlockDAG Node**: Initiates the BlockDAG node using Docker Compose, ensuring seamless setup and management of the node within a containerized environment.
- **Miner Address**: Accepts the `miner address` as a parameter, allowing the node to be started with the specified miner's address for participation in the BlockDAG network.

> **Note**: The miner address is crucial for identifying and linking the node to the wallet used for mining operations. Ensure that the correct address is provided during setup.

---

### `wallet.sh` Script 

The `wallet.sh` script provides the following functionalities:

- **Create a New Wallet**: Automatically generates a new wallet and securely stores its details, including the private key and public address, in the `wallet.txt` file.
- **Restore an Existing Wallet**: Allows users to restore a wallet by supplying a previously generated seed phrase as a parameter. This ensures that the wallet and its associated assets can be recovered.

> **Note**: The generated seed phrase and wallet details are sensitive information and are stored in `wallet.txt`. The wallet's private key and seed phrase should be securely stored, as they are required for accessing and managing the wallet.
---

Each of these scripts plays a crucial role in managing your BlockDAG node and wallet operations. Make sure to run them with the appropriate permissions (e.g., using `sudo` if needed) and ensure Docker is correctly installed and running before interacting with the node.



## Restart the blockdag network with updated image

### restart current network

  - To restart the blockdag network without cleanup run the following commands
  - first choose the operating system linux/mac
  - for linux :
  ```bash
      cd linux
      ./restart.sh
  ```
  - for mac :
  ```bash
     cd mac
     ./restart.sh
  ```
### restart with cleanup

  - To restart the blockdag network with cleanup run the following commands
  - first choose the operating system linux/mac
  - for linux :
  ```bash
      cd linux
      ./restartWithCleanup.sh
  ```
  - for mac :
  ```bash
     cd mac
     ./restartWithCleanup.sh
  ```
>**Note:**
> - Both restart scripts update the latest Docker image.
> - The restart.sh script restarts the network from where it was previously stopped, preserving the current state.
> - The restartWithCleanup.sh script removes the old database and begins syncing the node from the genesis block, while retaining the wallet and balance.
