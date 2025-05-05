#!/bin/bash
# Install Docker & Docker Compose with log rotation config

set -e

echo "[+] Updating and installing Docker dependencies..."
apt update -y
apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "[+] Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

echo "[+] Adding Docker repository..."
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

echo "[+] Installing Docker..."
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io

echo "[+] Adding current user to docker group..."
usermod -aG docker ubuntu
chmod 666 /var/run/docker.sock

echo "[+] Installing Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "[+] Creating /etc/docker/daemon.json with log rotation config..."
mkdir -p /etc/docker
cat <<EOF > /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF

echo "[+] Restarting Docker to apply logging configuration..."
systemctl restart docker

echo "[✓] Docker & Compose installed and log rotation enabled."
