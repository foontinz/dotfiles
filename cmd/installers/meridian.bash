#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLIST_SRC="$REPO_ROOT/configs/launchd/com.barbos.meridian.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.barbos.meridian.plist"
LABEL="com.barbos.meridian"
UID_="$(id -u)"
DOMAIN="gui/$UID_"

mkdir -p "$HOME/Library/LaunchAgents" "$HOME/Library/Logs"

cp "$PLIST_SRC" "$PLIST_DST"
chmod 644 "$PLIST_DST"

# Stop any existing launchd-managed instance, then any manually-started
# meridian still holding the port (so bootstrap below doesn't race).
launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
kill $(lsof -ti:3456 2>/dev/null) 2>/dev/null || true

launchctl bootstrap "$DOMAIN" "$PLIST_DST"
launchctl enable "$DOMAIN/$LABEL" 2>/dev/null || true
launchctl kickstart -k "$DOMAIN/$LABEL" 2>/dev/null || true

echo "meridian service: $LABEL loaded, binding 0.0.0.0:3456"
echo "logs: ~/Library/Logs/meridian.{out,err}.log"
