#!/bin/bash
set -euo pipefail

# Get the directory of the script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# 1. IMPORT ASSETS (Safe Mode)
# --recovery-mode: disables editor plugins and GDExtensions to avoid crashes
# --import: runs the editor import process and automatically quits
echo "Building project cache (Safe Mode)..."
godot --headless --path "$SCRIPT_DIR" --recovery-mode --import

# 2. RUN TESTS
# Cache now exists from the import step
echo "Running tests..."
godot --headless --path "$SCRIPT_DIR" -s res://tests/run_tests.gd
