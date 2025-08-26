# BlockDAG Node Makefile
# Works with existing blockdagnetwork/primordial image versioning

# Variables
IMAGE_NAME=blockdagnetwork/primordial
CURRENT_VERSION=v1.0.1
LATEST_VERSION=latest
LOCAL_TAG=dev
CUSTOM_IMAGE_NAME=mattblockdag/blockdag-dev-node

.PHONY: help pull run stop logs clean build-custom push-custom check-versions wallet wallet-restore wallet-info setup-and-run

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
	@echo "  make wallet         - Create a new wallet"
	@echo "  make wallet-restore SEED='your seed' - Restore wallet from seed"
	@echo "  make wallet-info    - Show wallet information"
	@echo "  make setup-and-run  - Create wallet and run node (one command)"
	@echo ""
	@echo "Custom Development:"
	@echo "  make build-custom   - Build custom development image (requires Dockerfile)"
	@echo "  make push-custom    - Push custom image to DockerHub"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean          - Clean up local images"
	@echo ""
	@echo "Current official version: $(CURRENT_VERSION)"

# Pull the latest official BlockDAG image
pull:
	@echo "Pulling official BlockDAG image: $(IMAGE_NAME):$(CURRENT_VERSION)"
	docker pull $(IMAGE_NAME):$(CURRENT_VERSION)
	@echo "Pulling latest version as well..."
	docker pull $(IMAGE_NAME):latest || echo "Latest tag not available, using $(CURRENT_VERSION)"

# Run the node using docker-compose
run:
	@echo "Starting BlockDAG node with docker-compose..."
	@if [ -f "wallet.txt" ]; then \
		echo "Using existing wallet..."; \
		MINING_ADDRESS=$$(tail -1 wallet.txt) docker-compose up -d; \
	else \
		echo "No wallet found. Please create one first with: ./wallet.sh"; \
		exit 1; \
	fi

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

# Clean up local images
clean:
	@echo "Cleaning up local images..."
	docker rmi $(IMAGE_NAME):$(CURRENT_VERSION) || true
	docker rmi $(IMAGE_NAME):latest || true
	docker rmi $(CUSTOM_IMAGE_NAME):$(LOCAL_TAG) || true
	@echo "Cleanup completed"

# Wallet Management Commands
wallet:
	@echo "Creating a new wallet..."
	./wallet.sh

wallet-restore:
	@if [ -z "$(SEED)" ]; then \
		echo "Usage: make wallet-restore SEED='your-wallet-seed-phrase'"; \
		echo "Example: make wallet-restore SEED='word1 word2 word3...'"; \
		exit 1; \
	fi
	@echo "Restoring wallet from seed..."
	./wallet.sh "$(SEED)"

wallet-info:
	@if [ -f "wallet.txt" ]; then \
		echo "Wallet Information:"; \
		echo "=================="; \
		cat wallet.txt; \
	else \
		echo "No wallet found. Create one with: make wallet"; \
	fi

setup-and-run:
	@echo "Setting up BlockDAG node (wallet + run)..."
	@if [ ! -f "wallet.txt" ]; then \
		echo "Creating new wallet..."; \
		./wallet.sh; \
	else \
		echo "Wallet already exists, skipping creation..."; \
	fi
	@echo "Pulling latest image..."
	make pull
	@echo "Starting node..."
	make run

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