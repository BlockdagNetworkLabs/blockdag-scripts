#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'USAGE'
Usage: ./stop.sh [ROLE]

ROLE may be one of:
  miner      - stop stack defined in docker-compose.yml (default)
  full       - stop stack defined in docker-compose.full.yml
  relay      - stop stack defined in docker-compose.relay.yml
  all        - stop all of the above stacks

You can also set NODE_ROLE to pick the default role instead of passing ROLE.
USAGE
}

resolve_compose_files() {
  local role_input="$1"

  case "$role_input" in
    all)
      echo "docker-compose.yml docker-compose.full.yml docker-compose.relay.yml"
      ;;
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

if ! files_to_stop=$(resolve_compose_files "$ROLE_INPUT"); then
  echo "Unknown node role: $ROLE_INPUT" >&2
  usage >&2
  exit 1
fi

if docker compose version >/dev/null 2>&1; then
  compose_cmd=(docker compose)
elif docker-compose version >/dev/null 2>&1; then
  compose_cmd=(docker-compose)
else
  echo "Neither 'docker compose' nor 'docker-compose' command is available." >&2
  exit 1
fi

IFS=' ' read -r -a compose_files <<< "$files_to_stop"

for compose_file in "${compose_files[@]}"; do
  if [[ "$compose_file" = /* ]]; then
    compose_path="$compose_file"
  else
    compose_path="$SCRIPT_DIR/$compose_file"
  fi

  if [ ! -f "$compose_path" ]; then
    echo "Compose file not found: $compose_path" >&2
    exit 1
  fi

  echo "Stopping stack defined in $compose_path"
  "${compose_cmd[@]}" -f "$compose_path" down
done
