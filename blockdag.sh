#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'USAGE'
Usage: ./blockdag.sh [ROLE]

ROLE may be one of:
  miner      - use docker-compose.yml (default)
  full       - use docker-compose.full.yml
  relay      - use docker-compose.relay.yml

You can also set NODE_ROLE environment variable instead of passing ROLE.
USAGE
}

ROLE_INPUT=${1:-${NODE_ROLE:-miner}}

case "$ROLE_INPUT" in
  -h|--help)
    usage
    exit 0
    ;;
  full)
    COMPOSE_FILE="docker-compose.full.yml"
    ;;
  relay)
    COMPOSE_FILE="docker-compose.relay.yml"
    ;;
  default|miner)
    COMPOSE_FILE="docker-compose.yml"
    ;;
  *)
    echo "Unknown node role: $ROLE_INPUT" >&2
    usage >&2
    exit 1
    ;;
esac

ENV_FILE="$SCRIPT_DIR/.env"

# load PUB_ETH_ADDR from .env if present
if [ -f "$ENV_FILE" ]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

if [ -z "${PUB_ETH_ADDR:-}" ]; then
  if [ -f "$SCRIPT_DIR/wallet.txt" ]; then
    PUB_ETH_ADDR=$(tail -n 1 "$SCRIPT_DIR/wallet.txt")
  else
    echo "PUB_ETH_ADDR not set. Please create $ENV_FILE or wallet.txt" >&2
    exit 1
  fi
fi

export PUB_ETH_ADDR

# start the blockdag node with the selected compose file
"$SCRIPT_DIR"/node.sh "$PUB_ETH_ADDR" "$COMPOSE_FILE"
