#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# start the blockdag node
"$SCRIPT_DIR"/node.sh "$PUB_ETH_ADDR"
