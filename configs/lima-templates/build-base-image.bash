#!/bin/bash
set -euo pipefail

IMAGE_DIR="$HOME/.lima/_images"
IMAGE_PATH="$IMAGE_DIR/base-docker.img"
BUILD_VM="build-base-docker"

echo "==> Building base docker image..."

# Clean up any previous build VM
limactl delete -f "$BUILD_VM" 2>/dev/null || true

# Start temp VM with full provisioning
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
limactl start "$SCRIPT_DIR/base-docker-build.yaml" --name "$BUILD_VM" -y

echo "==> Provisioning complete, stopping VM..."
limactl stop "$BUILD_VM"

echo "==> Exporting disk image..."
mkdir -p "$IMAGE_DIR"
cp "$HOME/.lima/$BUILD_VM/disk" "$IMAGE_PATH"

echo "==> Cleaning up build VM..."
limactl delete -f "$BUILD_VM"

echo "==> Done! Image saved to $IMAGE_PATH"
ls -lh "$IMAGE_PATH"
