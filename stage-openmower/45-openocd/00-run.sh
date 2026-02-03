#!/bin/bash -e

STAGE_DIR="$(dirname "$0")"

# Install files
install -m 0755 -d "$ROOTFS_DIR/home/openmower/.config/openmower-cli"
install -m 0664 -D "$STAGE_DIR/files/xcore.cfg" "$ROOTFS_DIR/home/openmower/.config/openmower-cli/xcore.cfg"

install -o "root" -m 0755 -d "$ROOTFS_DIR/root/.config/openmower-cli"
install -o "root" -m 0664 -D "$STAGE_DIR/files/xcore.cfg" "$ROOTFS_DIR/root/.config/openmower-cli/xcore.cfg"
