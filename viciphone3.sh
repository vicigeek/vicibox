#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail

REPO_URL="https://github.com/vicimikec/ViciPhone.git"
BRANCH="v3.0"
WORKDIR="/var/tmp"
CLONE_DIR="$WORKDIR/ViciPhone"
TARGET1="/srv/www/htdocs/agc/viciphone"
TARGET2="/srv/www/htdocs/vicidial/viciphone"

echo "Starting ViciPhone v3.0 installation..."
echo "Working in: $WORKDIR"

# Cleanup any old clone
if [ -d "$CLONE_DIR" ]; then
    echo "Removing old ViciPhone directory..."
    rm -rf "$CLONE_DIR"
fi

cd "$WORKDIR" || { echo "Failed to change to $WORKDIR"; exit 1; }

echo "Cloning branch '$BRANCH' from $REPO_URL..."
git clone --branch "$BRANCH" "$REPO_URL" ViciPhone

if [ ! -d "$CLONE_DIR" ]; then
    echo "❌ Clone failed. Exiting."
    exit 1
fi
echo "✅ Repository cloned successfully."

# Copy to target 1
echo "Copying to $TARGET1..."
rm -rf "$TARGET1"
cp -r "$CLONE_DIR" "$TARGET1"

# Copy to target 2
echo "Copying to $TARGET2..."
rm -rf "$TARGET2"
cp -r "$CLONE_DIR" "$TARGET2"

# Set permissions
echo "Setting permissions to 755 on both targets..."
chmod -R 755 "$TARGET1"
chmod -R 755 "$TARGET2"

echo "✅ ViciPhone v3.0 successfully deployed to:"
echo "   - $TARGET1"
echo "   - $TARGET2"
