# BlockDAG Node Makefile - macOS Version
# Works with existing abhishek1857/blockdag image versioning

# Variables
IMAGE_NAME=abhishek1857/blockdag
CURRENT_VERSION=preawakening-v0.0.1
LATEST_VERSION=latest
LOCAL_TAG=dev
CUSTOM_IMAGE_NAME="YOUR_CUSTOM_IMAGE_NAME"

# Auto-detect mining address from wallet.txt
MINING_ADDRESS := $(shell if [ -f wallet.txt ]; then cat wallet.txt; fi)

# Debug flag - set DEBUG=1 for verbose output
DEBUG ?= 0

# Helper functions for progress display
define show_progress
	@echo "🔄 Progress: $1% $2"
endef

define show_step
	@echo "  ✓ Step $1/4: $2"
endef

define show_overall_progress
	@echo ""
	@echo "📊 Overall Progress:"
	@echo "┌─────────────────────────────────────────────────────────┐"
	@if [ $1 -ge 100 ]; then echo "│ ████████████████████████████████████████████████████████ │ 100%"; \
	elif [ $1 -ge 75 ]; then echo "│ █████████████████████████████████████████████░░░░░░░░░░░ │ $1%"; \
	elif [ $1 -ge 50 ]; then echo "│ ██████████████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ $1%"; \
	elif [ $1 -ge 25 ]; then echo "│ ███████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ $1%"; \
	else echo "│ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ $1%"; \
	fi
	@echo "└─────────────────────────────────────────────────────────┘"
	@echo ""
endef

define show_debug
	@if [ "$(DEBUG)" = "1" ]; then echo "$1"; fi
endef

.PHONY: help pull run stop logs status clean clean-data build-custom push-custom check-versions wallet wallet-restore wallet-info setup-and-run restart-clean

# Default target - show help
help:
	@echo "BlockDAG Node Makefile Commands (macOS):"
	@echo ""
	@echo "Usage: make [target] [DEBUG=1]"
	@echo "  DEBUG=1 enables verbose logging for debugging"
	@echo ""
	@echo "Using Official Images:"
	@echo "  make pull           - Pull latest official BlockDAG image"
	@echo "  make run            - Run BlockDAG node with docker-compose"
	@echo "  make stop           - Stop running BlockDAG node"
	@echo "  make logs           - Show node logs"
	@echo "  make status         - Show real-time node status dashboard"
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
	@echo "Examples:"
	@echo "  make setup-and-run     # Clean progress display"
	@echo "  make setup-and-run DEBUG=1  # Verbose debug output"
	@echo ""
	@echo "Current official version: $(CURRENT_VERSION)"

# Pull the latest official BlockDAG image
pull:
	@echo "📥 Pulling BlockDAG image..."
	@$(call show_progress,10,"Starting download")
	@if [ "$(DEBUG)" = "1" ]; then echo "Pulling official BlockDAG image: $(IMAGE_NAME):$(CURRENT_VERSION)"; fi
	@if [ "$(DEBUG)" = "1" ]; then echo "This may take a few minutes depending on your internet connection..."; fi
	@$(call show_progress,30,"Downloading image layers")
	docker pull $(IMAGE_NAME):$(CURRENT_VERSION) >/dev/null 2>&1
	@$(call show_progress,60,"Downloading latest version")
	docker pull $(IMAGE_NAME):latest >/dev/null 2>&1 || true
	@$(call show_progress,100,"Download complete")
	@echo "✅ Docker images pulled successfully"

# Run the node using docker-compose
run:
	@echo "🚀 Starting BlockDAG node..."
	@$(call show_progress,20,"Checking wallet")
	@if [ -f "wallet.txt" ]; then \
		if [ "$(DEBUG)" = "1" ]; then echo "Using existing ETH wallet..."; fi; \
		if [ "$(DEBUG)" = "1" ]; then echo "Mining address set: $(MINING_ADDRESS)"; fi; \
		$(call show_progress,50,"Starting container"); \
		if [ "$(DEBUG)" = "1" ]; then echo "Starting Docker container..."; fi; \
		MINING_ADDRESS=$(MINING_ADDRESS) docker-compose up -d >/dev/null 2>&1; \
	else \
		echo "❌ No wallet found. Please create one first with: make wallet"; \
		exit 1; \
	fi
	@$(call show_progress,80,"Initializing node")
	@if [ "$(DEBUG)" = "1" ]; then echo "Node is starting up... This may take a few moments."; fi
	@$(call show_progress,100,"Node started")
	@echo ""
	@echo "✅ Node started successfully"
	@echo "📊 Monitor with: make logs"

# Stop the running node
stop:
	@echo "⏹️  Stopping BlockDAG node..."
	@echo "🔄 Gracefully shutting down container..."
	docker-compose down
	@echo "✅ Node stopped successfully"

# Show real-time node status
status:
	@echo "📊 BlockDAG Node Status Dashboard (macOS)"
	@echo "=========================================="
	@echo "🔄 Checking container status..."
	@if docker ps | grep -q "blockdag-testnet-network"; then \
		echo "✅ Container Status: RUNNING"; \
		echo "🔄 Checking node health..."; \
		echo "📡 RPC Status: $$(curl -s http://localhost:38131/health 2>/dev/null || echo 'Not responding')"; \
		echo "⛏️  Mining Status: $$(docker logs blockdag-testnet-network 2>&1 | tail -5 | grep -i mining || echo 'Checking...')"; \
	else \
		echo "❌ Container Status: STOPPED"; \
	fi
	@echo "📁 Wallet Status: $$(if [ -f wallet.txt ]; then echo "✅ Configured: $$(cat wallet.txt)"; else echo "❌ Not configured"; fi)"
	@echo "🔧 Useful Commands:"
	@echo "  make logs    - View real-time logs"
	@echo "  make stop    - Stop the node"
	@echo "  make run     - Start the node"

# Show node logs
logs:
	@echo "📊 Showing BlockDAG node logs..."
	@echo "🔄 Live monitoring active - Press Ctrl+C to exit"
	@echo "📡 Connecting to container logs..."
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
	@echo "🧹 Starting comprehensive cleanup..."
	@echo "🔄 Progress: [░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 0%"
	@echo "⏹️  Stopping BlockDAG node..."
	make stop
	@echo "🔄 Progress: [████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 20%"
	@echo "🗑️  Cleaning up local images and data..."
	docker rmi $(IMAGE_NAME):$(CURRENT_VERSION) || true
	docker rmi $(IMAGE_NAME):latest || true
	docker rmi $(CUSTOM_IMAGE_NAME):$(LOCAL_TAG) || true
	@echo "🔄 Progress: [████████████████░░░░░░░░░░░░░░░░░░░░░░░░] 40%"
	@echo "💳 Cleaning wallet data..."
	./clean.sh
	@echo "🔄 Progress: [████████████████████████░░░░░░░░░░░░░░░░] 60%"
	@echo "📁 Cleaning blockchain data directories..."
	rm -rf bin/bdag/data/* || true
	rm -rf bin/bdag/logs/* || true
	@echo "🔄 Progress: [████████████████████████████████░░░░░░░░] 80%"
	@echo "🔧 Cleaning blockchain data..."
	@if docker images "$(IMAGE_NAME):$(CURRENT_VERSION)" | grep -q "$(IMAGE_NAME)"; then \
		echo "Running blockchain cleanup..."; \
		docker run --rm $(IMAGE_NAME):$(CURRENT_VERSION) ./bdag --cleanup || echo "Cleanup completed or no data to clean"; \
	else \
		echo "No local image found, skipping blockchain cleanup"; \
	fi
	@echo "🔄 Progress: [████████████████████████████████████████] 100%"
	@echo "✅ Cleanup completed"

# Clean up blockchain data only (keep Docker images)
clean-data:
	@echo "🧹 Cleaning blockchain data..."
	@$(call show_progress,20,"Removing data directories")
	@if [ "$(DEBUG)" = "1" ]; then echo "Cleaning blockchain data directories..."; fi
	rm -rf bin/bdag/data/* >/dev/null 2>&1 || true
	rm -rf bin/bdag/logs/* >/dev/null 2>&1 || true
	@$(call show_progress,60,"Running cleanup")
	@if docker images "$(IMAGE_NAME):$(CURRENT_VERSION)" | grep -q "$(IMAGE_NAME)"; then \
		if [ "$(DEBUG)" = "1" ]; then echo "Running blockchain cleanup..."; fi; \
		docker run --rm $(IMAGE_NAME):$(CURRENT_VERSION) ./bdag --cleanup >/dev/null 2>&1 || true; \
	else \
		if [ "$(DEBUG)" = "1" ]; then echo "No local image found, skipping blockchain cleanup"; fi; \
	fi
	@$(call show_progress,100,"Cleanup complete")
	@echo "✅ Blockchain data cleanup completed"

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
	@echo "🚀 BlockDAG Node Setup (macOS)"
	@echo "==============================="
	@$(call show_overall_progress,0)
	@$(call show_step,1,"Checking ETH wallet configuration")
	@if [ "$(DEBUG)" = "1" ]; then echo "Checking ETH wallet configuration..."; fi
	@if [ ! -f "wallet.txt" ]; then \
		if [ "$(DEBUG)" = "1" ]; then echo "No ETH wallet found, prompting for ETH wallet..."; fi; \
		make wallet; \
		if [ "$(DEBUG)" = "1" ]; then echo "ETH wallet configured"; fi; \
	else \
		if [ "$(DEBUG)" = "1" ]; then echo "ETH wallet already exists"; fi; \
	fi
	@$(call show_overall_progress,25)
	@$(call show_step,2,"Pulling Docker image")
	@if [ "$(DEBUG)" = "1" ]; then echo "Pulling latest Docker image..."; fi
	@make pull
	@$(call show_overall_progress,50)
	@$(call show_step,3,"Cleaning blockchain data")
	@if [ "$(DEBUG)" = "1" ]; then echo "Cleaning blockchain data..."; fi
	@make clean-data
	@$(call show_overall_progress,75)
	@$(call show_step,4,"Starting BlockDAG node")
	@if [ "$(DEBUG)" = "1" ]; then echo "Starting BlockDAG node..."; fi
	@make run
	@$(call show_overall_progress,100)
	@echo ""
	@echo "✅ BlockDAG Node Setup Complete!"
	@echo ""
	@echo "📊 Node Status:"
	@echo "  • Container: blockdag-testnet-network"
	@echo "  • Network: BlockDAG Private Network (Devnet)"
	@echo "  • Mining: Enabled with your ETH wallet"
	@echo "  • Platform: macOS"
	@echo ""
	@echo "🔧 Useful Commands:"
	@echo "  make logs    - View real-time logs"
	@echo "  make stop    - Stop the node"
	@echo "  make status  - Show node status"

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
