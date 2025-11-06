#!/bin/bash

# Build script for Standup Timer native macOS app
# This script automates the build process for creating a standalone .app bundle

set -e  # Exit on error

echo "🏗️  Building Standup Timer for macOS..."
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This script must be run on macOS"
    exit 1
fi

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode is not installed or xcodebuild is not in PATH"
    exit 1
fi

# Step 1: Generate icons if they don't exist
if [ ! -f "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_512x512@2x.png" ]; then
    echo "📱 Generating app icons..."
    if [ -f "generate_icon.sh" ]; then
        ./generate_icon.sh
    else
        echo "⚠️  Warning: generate_icon.sh not found, skipping icon generation"
        echo "   The app will build without a custom icon"
    fi
    echo ""
fi

# Step 2: Build the app
echo "🔨 Building app with xcodebuild..."
xcodebuild -project StandupTimer.xcodeproj \
           -scheme StandupTimer \
           -configuration Release \
           -derivedDataPath build \
           build

echo ""
echo "✅ Build successful!"
echo ""

# Step 3: Locate the built app
APP_PATH="build/Build/Products/Release/StandupTimer.app"

if [ -d "$APP_PATH" ]; then
    echo "📦 App bundle created at: $APP_PATH"
    echo ""

    # Optional: Copy to Applications
    read -p "Would you like to install to /Applications? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📲 Installing to /Applications..."
        cp -r "$APP_PATH" /Applications/
        echo "✅ Installed! You can now launch Standup Timer from your Applications folder"
        echo "   or search for it in Spotlight (Cmd+Space)"
    else
        echo "ℹ️  To install manually, run:"
        echo "   cp -r $APP_PATH /Applications/"
    fi
else
    echo "❌ Error: Could not find built app at $APP_PATH"
    exit 1
fi

echo ""
echo "🎉 All done!"
