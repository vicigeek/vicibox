#!/bin/bash

set -e  # Exit on any error
set -o pipefail

REPO_URL="https://github.com/vicimikec/ViciPhone.git"
BRANCH="v3.0"
WORKDIR="/var/tmp"
CLONE_DIR="$WORKDIR/ViciPhone"
SRC_DIR="$CLONE_DIR/src"
TARGET1="/srv/www/htdocs/agc/viciphone"
TARGET2="/srv/www/htdocs/vicidial/viciphone"

echo "🔧 Starting ViciPhone v3.0 install to both targets..."
echo "📁 Working directory: $WORKDIR"

# Cleanup any old clone
if [ -d "$CLONE_DIR" ]; then
    echo "🧹 Removing existing clone directory..."
    rm -rf "$CLONE_DIR"
fi

cd "$WORKDIR" || { echo "❌ Failed to enter $WORKDIR"; exit 1; }

echo "⬇️ Cloning branch '$BRANCH' from $REPO_URL..."
git clone --branch "$BRANCH" "$REPO_URL" ViciPhone

if [ ! -d "$SRC_DIR" ]; then
    echo "❌ 'src' directory not found in the cloned repo. Exiting."
    exit 1
fi
echo "✅ Clone successful and 'src' directory found."

# Deploy to TARGET1
echo "📤 Copying contents of 'src/' to $TARGET1..."
rm -rf "$TARGET1"
mkdir -p "$TARGET1"
cp -r "$SRC_DIR/"* "$TARGET1"

# Deploy to TARGET2
echo "📤 Copying contents of 'src/' to $TARGET2..."
rm -rf "$TARGET2"
mkdir -p "$TARGET2"
cp -r "$SRC_DIR/"* "$TARGET2"

# Set permissions
echo "🔐 Setting permissions to 755 on both targets..."
chmod -R 755 "$TARGET1"
chmod -R 755 "$TARGET2"

echo "✅ ViciPhone v3.0 'src' successfully deployed to:"
echo "   - $TARGET1"
echo "   - $TARGET2"
