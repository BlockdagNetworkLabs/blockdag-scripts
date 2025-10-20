 #!/bin/bash
 
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: ./node.sh <MINING_ADDRESS> <COMPOSE_FILE>" >&2
  exit 1
fi

mining_address=$1
compose_file=$2

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$compose_file" = /* ]]; then
  compose_path="$compose_file"
else
  compose_path="$SCRIPT_DIR/$compose_file"
fi

if [ ! -f "$compose_path" ]; then
  echo "Compose file not found: $compose_path" >&2
  exit 1
fi

export MINING_ADDRESS="$mining_address"

if docker compose version >/dev/null 2>&1; then
  echo "Using docker compose with file $compose_path"
  docker compose -f "$compose_path" up -d
elif docker-compose version >/dev/null 2>&1; then
  echo "Using docker-compose with file $compose_path"
  docker-compose -f "$compose_path" up -d
else
  echo "Neither 'docker compose' nor 'docker-compose' command is available." >&2
  exit 1
fi
