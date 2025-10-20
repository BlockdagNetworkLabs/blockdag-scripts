#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 
cd "$SCRIPT_DIR"
 
usage() {
  cat <<'USAGE'
Usage: ./restartWithCleanup.sh [ROLE]

ROLE matches the options from blockdag.sh (miner, full, relay).
If omitted, the miner template is used. NODE_ROLE environment variable can also
set the default role.
USAGE
}

resolve_compose_file() {
  local role_input="$1"

  case "$role_input" in
    full)
      echo "docker-compose.full.yml"
      ;;
    relay)
      echo "docker-compose.relay.yml"
      ;;
    miner|default)
      echo "docker-compose.yml"
      ;;
    *)
      return 1
      ;;
  esac
}

ROLE_INPUT=${1:-${NODE_ROLE:-miner}}

case "$ROLE_INPUT" in
  -h|--help)
    usage
    exit 0
    ;;
esac

if ! COMPOSE_FILE=$(resolve_compose_file "$ROLE_INPUT"); then
  echo "Unknown node role: $ROLE_INPUT" >&2
  usage >&2
  exit 1
fi

if [[ "$COMPOSE_FILE" = /* ]]; then
  compose_path="$COMPOSE_FILE"
else
  compose_path="$SCRIPT_DIR/$COMPOSE_FILE"
fi

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
 
if docker compose version >/dev/null 2>&1; then
  compose_cmd=(docker compose)
elif docker-compose version >/dev/null 2>&1; then
  compose_cmd=(docker-compose)
else
  echo "Neither 'docker compose' nor 'docker-compose' command is available." >&2
  exit 1
fi

"${compose_cmd[@]}" -f "$compose_path" down || true
 
image_name=$(awk '/^\s*image:/ {print $2; exit}' "$compose_path")
if [ -n "$image_name" ]; then
  docker image rm "$image_name" || true
fi
 
sudo rm -rf ./bin/bdag/*
 
# restart the blockdag node
"$SCRIPT_DIR"/node.sh "$PUB_ETH_ADDR" "$COMPOSE_FILE"