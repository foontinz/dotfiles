#!/bin/bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

SERVICE_NAME="google-workspace-mcp"
CONTAINER_NAME="foontinz-touch-bistro-registry-google-workspace-mcp"
REPO_PATH="$HOME/dev/nightly/google_workspace_mcp"
SECRET_PATH="$HOME/google-secrets/personal_agent.json"
ORBSTACK_APP="/Applications/OrbStack.app"

if [[ ! -d "$REPO_PATH" ]]; then
  echo "missing repo: $REPO_PATH" >&2
  exit 1
fi

if [[ ! -f "$SECRET_PATH" ]]; then
  echo "missing Google OAuth secret: $SECRET_PATH" >&2
  exit 1
fi

if [[ -d "$ORBSTACK_APP" ]]; then
  open -gj -a "$ORBSTACK_APP" || true
fi

for _ in $(seq 1 60); do
  if docker info >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

docker info >/dev/null 2>&1

if docker inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  docker start "$CONTAINER_NAME" >/dev/null || true
else
  tb up "$SERVICE_NAME" --no-lazydocker --no-registry-pull --no-git-pull --no-remote-pull
fi

docker update --restart unless-stopped "$CONTAINER_NAME" >/dev/null

docker ps --filter "name=^${CONTAINER_NAME}$" --format '{{.Names}}\t{{.Status}}'
