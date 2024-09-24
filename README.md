# BlockDAG Node Setup Documentation

## Hardware Requirements

- **CPU**: Minimum 4 cores (4+ cores recommended for mining).
- **Memory (RAM)**: At least 8GB (8GB+ recommended).
- **Disk Space**: Minimum 20GB of free disk space. More storage is recommended depending on the size of the blockchain and logs.
- **Network**: A stable internet connection with sufficient bandwidth.

---

## Setup Process: Running a BlockDAG Node

### Prerequisites

1. **Docker Installation**: Docker should be installed on your system. If it is not installed, follow the steps in the [official Docker documentation](https://docs.docker.com/get-docker/) to install Docker.

2. **System Update and Required Package Installation**: Run the following commands to update your package list and install `expect` (a tool often used for automating interactive tasks in the terminal):

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

After cloning the repository, you need to update the paths in all relevant files to reflect your current repository location.

For example, if you cloned the repository into `/home/yourusername/projects/blockdag/blockdag-scripts`, you should replace all instances of the old path (`/home/ubuntu/blockdag-scripts/`) in the files with your new path (`/home/yourusername/projects/blockdag/blockdag-scripts`).

### Step 3: Running the Node

To run a full BlockDAG node in a testnet environment with mining enabled, follow these commands:

```
./blockdag.sh
```
>**Note**: If the above command does not work as expected, try running it with sudo for elevated permissions:

```
sudo ./blockdag.sh
```

### Step 4: Checking Node Logs

Once the node is running, you can check the logs to monitor its status. Follow these steps:

1. **Get the Docker Container ID**: Run the following command to list all running Docker containers and retrieve the container ID of your BlockDAG node:

    ```bash
    docker ps -a
    ```

   This command will display a list of all Docker containers, including their names and IDs.

2. **View Node Logs**: With the container ID retrieved, use the following command to view the logs of your BlockDAG node:

    ```bash
    docker logs -f CONTAINERID
    ```

   Replace `CONTAINERID` with the actual ID of your BlockDAG node container.

> **Note**: The `-f` flag in the `docker logs` command will follow the logs, allowing you to see real-time output. If the commands do not work as expected, try using `sudo` for elevated permissions:

```bash
sudo docker ps -a
sudo docker logs -f CONTAINERID
```
