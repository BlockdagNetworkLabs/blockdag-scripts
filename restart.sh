#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR"

ENV_FILE="$SCRIPT_DIR/.env"

if [ -f "$ENV_FILE" ]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

if [ -z "${PUB_ETH_ADDR:-}" ]; then
  if [ -f "$SCRIPT_DIR/wallet.txt" ]; then
    PUB_ETH_ADDR=$(tail -n 1 "$SCRIPT_DIR/wallet.txt")
  else
    echo "PUB_ETH_ADDR not set. Please populate $ENV_FILE or wallet.txt" >&2
    exit 1
  fi
fi

docker-compose down || true

docker rmi blockdagnetwork/awakening || true

# restart the blockdag node
"$SCRIPT_DIR"/node.sh "$PUB_ETH_ADDR"
