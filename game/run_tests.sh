#!/bin/bash

# 1. Trigger the editor import process (headless) to generate .godot/global_script_class_cache.cfg
echo "Building project cache..."
godot --headless --path . --editor --quit

# 2. Run the actual tests
echo "Running tests..."
godot --headless --path . -s res://tests/run_tests.gd
