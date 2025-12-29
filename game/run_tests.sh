#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OVERRIDE_FILE="$SCRIPT_DIR/override.cfg"
OVERRIDE_BACKUP="$SCRIPT_DIR/override.cfg.bak"

cleanup_override() {
    if [ -f "$OVERRIDE_FILE" ]; then
        rm -f "$OVERRIDE_FILE"
    fi

    if [ -f "$OVERRIDE_BACKUP" ]; then
        mv -f "$OVERRIDE_BACKUP" "$OVERRIDE_FILE"
    fi
}

trap cleanup_override EXIT

# 1. CREATE TEMPORARY OVERRIDE TO DISABLE GIT PLUGIN
if [ -f "$OVERRIDE_FILE" ]; then
    mv -f "$OVERRIDE_FILE" "$OVERRIDE_BACKUP"
fi

echo "[editor]" > "$OVERRIDE_FILE"
echo "version_control/plugin_name=\"\"" >> "$OVERRIDE_FILE"
echo "version_control/autoload_on_startup=false" >> "$OVERRIDE_FILE"

echo "Building project cache..."
godot --headless --path "$SCRIPT_DIR" --editor --quit

echo "Running tests..."
godot --headless --path "$SCRIPT_DIR" -s res://tests/run_tests.gd
