# BlockDAG Node Makefile
# Works with existing blockdagnetwork/primordial image versioning

# Variables
IMAGE_NAME=abhishek1857/blockdag
CURRENT_VERSION=preawakening-v0.0.1
LATEST_VERSION=latest
LOCAL_TAG=dev
CUSTOM_IMAGE_NAME="YOUR_CUSTOM_IMAGE_NAME"

# Auto-detect mining address from wallet.txt
MINING_ADDRESS := $(shell if [ -f wallet.txt ]; then cat wallet.txt; fi)

.PHONY: help pull run stop logs clean clean-data build-custom push-custom check-versions wallet wallet-restore wallet-info setup-and-run restart-clean

# Default target - show help
help:
	@echo "BlockDAG Node Makefile Commands:"
	@echo ""
	@echo "Using Official Images:"
	@echo "  make pull           - Pull latest official BlockDAG image"
	@echo "  make run            - Run BlockDAG node with docker-compose"
	@echo "  make stop           - Stop running BlockDAG node"
	@echo "  make logs           - Show node logs"
	@echo "  make check-versions - Check available versions on DockerHub"
	@echo ""
	@echo "Wallet Management:"
	@echo "  make wallet         - Configure ETH-compatible wallet"
	@echo "  make wallet-restore - Configure ETH-compatible wallet (restore)"
	@echo "  make wallet-info    - Show wallet information"
	@echo "  make setup-and-run  - Complete setup with ETH wallet"
	@echo "  make restart-clean  - Restart node with blockchain cleanup"
	@echo ""
	@echo "Custom Development:"
	@echo "  make build-custom   - Build custom development image (requires Dockerfile)"
	@echo "  make push-custom    - Push custom image to DockerHub"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean          - Clean up local images and all data"
	@echo "  make clean-data     - Clean up blockchain data only (keep images)"
	@echo ""
	@echo "Current official version: $(CURRENT_VERSION)"

# Pull the latest official BlockDAG image
pull:
	@echo "📥 Pulling official BlockDAG image: $(IMAGE_NAME):$(CURRENT_VERSION)"
	@echo "⏳ This may take a few minutes depending on your internet connection..."
	docker pull $(IMAGE_NAME):$(CURRENT_VERSION)
	@echo "📥 Pulling latest version as well..."
	docker pull $(IMAGE_NAME):latest || echo "ℹ️  Latest tag not available, using $(CURRENT_VERSION)"
	@echo "✅ Docker images pulled successfully"

# Run the node using docker-compose
run:
	@echo "🚀 Starting BlockDAG node with docker-compose..."
	@if [ -f "wallet.txt" ]; then \
		echo "✅ Using existing wallet..."; \
		echo "🎯 Mining address set: $(MINING_ADDRESS)"; \
		MINING_ADDRESS=$(MINING_ADDRESS) docker-compose up -d; \
	else \
		echo "❌ No wallet found. Please create one first with: make wallet"; \
		exit 1; \
	fi
	@echo "⏳ Node is starting up... This may take a few moments."
	@echo "📊 You can monitor progress with: make logs"

# Stop the running node
stop:
	@echo "Stopping BlockDAG node..."
	docker-compose down

# Show node logs
logs:
	@echo "Showing BlockDAG node logs..."
	docker logs -f blockdag-testnet-network

# Check what versions are available on DockerHub
check-versions:
	@echo "Checking available versions on DockerHub..."
	@curl -s "https://hub.docker.com/v2/repositories/$(IMAGE_NAME)/tags?page_size=100" | \
		jq -r '.results[]? | .name' 2>/dev/null | sort -V || \
		echo "Unable to fetch versions (jq might not be installed)"

# Build custom development image (only if Dockerfile exists)
build-custom:
	@if [ -f "Dockerfile" ]; then \
		echo "Building custom development image..."; \
		docker build -t $(CUSTOM_IMAGE_NAME):$(LOCAL_TAG) .; \
	else \
		echo "No Dockerfile found. Cannot build custom image."; \
		echo "Create a Dockerfile first or use official images with 'make pull'"; \
		exit 1; \
	fi

# Push custom image to DockerHub
push-custom:
	@if docker images | grep -q "$(CUSTOM_IMAGE_NAME):$(LOCAL_TAG)"; then \
		echo "Pushing custom image to DockerHub..."; \
		docker push $(CUSTOM_IMAGE_NAME):$(LOCAL_TAG); \
	else \
		echo "Custom image not found. Build it first with 'make build-custom'"; \
		exit 1; \
	fi

# Clean up local images and data
clean:
	@echo "Stopping BlockDAG node..."
	make stop
	@echo "Cleaning up local images and data..."
	docker rmi $(IMAGE_NAME):$(CURRENT_VERSION) || true
	docker rmi $(IMAGE_NAME):latest || true
	docker rmi $(CUSTOM_IMAGE_NAME):$(LOCAL_TAG) || true
	@echo "Cleaning wallet data..."
	./clean.sh
	@echo "Cleaning blockchain data directories..."
	rm -rf bin/bdag/data/* || true
	rm -rf bin/bdag/logs/* || true
	@echo "Cleaning blockchain data..."
	@if docker images "$(IMAGE_NAME):$(CURRENT_VERSION)" | grep -q "$(IMAGE_NAME)"; then \
		echo "Running blockchain cleanup..."; \
		docker run --rm $(IMAGE_NAME):$(CURRENT_VERSION) ./bdag --cleanup || echo "Cleanup completed or no data to clean"; \
	else \
		echo "No local image found, skipping blockchain cleanup"; \
	fi
	@echo "Cleanup completed"

# Clean up blockchain data only (keep Docker images)
clean-data:
	@echo "Cleaning up blockchain data..."
	@echo "Cleaning blockchain data directories..."
	rm -rf bin/bdag/data/* || true
	rm -rf bin/bdag/logs/* || true
	@if docker images "$(IMAGE_NAME):$(CURRENT_VERSION)" | grep -q "$(IMAGE_NAME)"; then \
		echo "Running blockchain cleanup..."; \
		docker run --rm $(IMAGE_NAME):$(CURRENT_VERSION) ./bdag --cleanup || echo "Cleanup completed or no data to clean"; \
	else \
		echo "No local image found, skipping blockchain cleanup"; \
	fi
	@echo "Blockchain data cleanup completed"

# Wallet Management Commands
wallet:
	@echo "=========================================="
	@echo "BlockDAG Node Setup - ETH Wallet Integration"
	@echo "=========================================="
	@echo ""
	@echo "Due to UTXO removal, BlockDAG now requires an ETH-compatible wallet."
	@echo "Please provide your ETH wallet public key (address)."
	@echo ""
	@read -p "Enter your ETH wallet public key: " ETH_WALLET; \
	if [ -z "$$ETH_WALLET" ]; then \
		echo "Error: ETH wallet address is required!"; \
		exit 1; \
	fi; \
	echo "$$ETH_WALLET" > wallet.txt; \
	echo ""; \
	echo "✅ ETH wallet address saved: $$ETH_WALLET"; \
	echo "📁 Wallet info stored in: wallet.txt"

wallet-restore:
	@echo "=========================================="
	@echo "BlockDAG Node Setup - ETH Wallet Integration"
	@echo "=========================================="
	@echo ""
	@echo "Due to UTXO removal, BlockDAG now requires an ETH-compatible wallet."
	@echo "Please provide your ETH wallet public key (address)."
	@echo ""
	@read -p "Enter your ETH wallet public key: " ETH_WALLET; \
	if [ -z "$$ETH_WALLET" ]; then \
		echo "Error: ETH wallet address is required!"; \
		exit 1; \
	fi; \
	echo "$$ETH_WALLET" > wallet.txt; \
	echo ""; \
	echo "✅ ETH wallet address saved: $$ETH_WALLET"; \
	echo "📁 Wallet info stored in: wallet.txt"

wallet-info:
	@if [ -f "wallet.txt" ]; then \
		echo "Wallet Information:"; \
		echo "=================="; \
		cat wallet.txt; \
	else \
		echo "No wallet found. Create one with: make wallet"; \
	fi

setup-and-run:
	@echo "=========================================="
	@echo "🚀 BlockDAG Node Setup - Starting..."
	@echo "=========================================="
	@echo ""
	@echo "📋 Setup Progress:"
	@echo "  [1/4] Checking ETH wallet configuration..."
	@if [ ! -f "wallet.txt" ]; then \
		echo "  [1/4] ⚠️  No ETH wallet found, prompting for ETH wallet..."; \
		make wallet; \
		echo "  [1/4] ✅ ETH wallet configured"; \
	else \
		echo "  [1/4] ✅ ETH wallet already exists"; \
	fi
	@echo "  [2/4] 📥 Pulling latest Docker image..."
	@make pull
	@echo "  [3/4] 🧹 Cleaning blockchain data..."
	@make clean-data
	@echo "  [4/4] 🚀 Starting BlockDAG node..."
	@make run
	@echo ""
	@echo "=========================================="
	@echo "✅ BlockDAG Node Setup Complete!"
	@echo "=========================================="
	@echo ""
	@echo "📊 Node Status:"
	@echo "  • Container: blockdag-testnet-network"
	@echo "  • Network: BlockDAG Private Network (Devnet)"
	@echo "  • Mining: Enabled with your ETH wallet"
	@echo ""
	@echo "🔧 Useful Commands:"
	@echo "  make logs    - View real-time logs"
	@echo "  make stop    - Stop the node"
	@echo "  make wallet-info - View wallet information"

# Restart with cleanup (useful when blockchain data is corrupted)
restart-clean:
	@echo "Restarting BlockDAG node with cleanup..."
	make stop
	make clean-data
	make setup-and-run

# Advanced: Update to a specific version
update-version:
	@if [ -z "$(VERSION)" ]; then \
		echo "Usage: make update-version VERSION=v1.0.2"; \
		echo "Available versions:"; \
		make check-versions; \
		exit 1; \
	fi
	@echo "Updating to version $(VERSION)..."
	docker pull $(IMAGE_NAME):$(VERSION)
	@echo "Updated! Remember to restart with: make stop && make run"