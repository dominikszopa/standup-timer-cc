#!/bin/bash

# Build script for creating a standalone macOS app bundle
# This creates a proper .app bundle that can be copied to the Applications folder

set -e

echo "🏗️  Building Standup Timer..."

# Build the app in release mode
swift build -c release

# Create app bundle structure
APP_NAME="Standup Timer.app"
BUILD_DIR=".build/release"
APP_DIR="$BUILD_DIR/$APP_NAME"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

echo "📦 Creating app bundle structure..."
rm -rf "$APP_DIR"
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# Copy the executable
echo "📋 Copying executable..."
cp "$BUILD_DIR/StandupTimer" "$MACOS_DIR/"

# Copy Info.plist
echo "📋 Copying Info.plist..."
cp "Info.plist" "$CONTENTS_DIR/"

# Create PkgInfo file
echo "📋 Creating PkgInfo..."
echo -n "APPL????" > "$CONTENTS_DIR/PkgInfo"

echo "✅ Build complete!"
echo ""
echo "📍 Your app is ready at: $APP_DIR"
echo ""
echo "To install:"
echo "  1. Copy to Applications: cp -r \"$APP_DIR\" /Applications/"
echo "  2. Or open from here: open \"$APP_DIR\""
echo ""
echo "To create a DMG for distribution, you can use:"
echo "  hdiutil create -volname \"Standup Timer\" -srcfolder \"$APP_DIR\" -ov -format UDZO \"StandupTimer.dmg\""
