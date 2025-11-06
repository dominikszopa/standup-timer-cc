#!/bin/bash

# Script to generate app icon from SVG
# Requires: librsvg (for rsvg-convert) or ImageMagick (for convert)

# Create the SVG icon
cat > icon.svg << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:rgb(59,130,246);stop-opacity:1" />
      <stop offset="100%" style="stop-color:rgb(37,99,235);stop-opacity:1" />
    </linearGradient>
    <filter id="shadow">
      <feGaussianBlur in="SourceAlpha" stdDeviation="8"/>
      <feOffset dx="0" dy="4" result="offsetblur"/>
      <feComponentTransfer>
        <feFuncA type="linear" slope="0.3"/>
      </feComponentTransfer>
      <feMerge>
        <feMergeNode/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <!-- Background rounded square -->
  <rect x="64" y="64" width="896" height="896" rx="180" fill="url(#grad1)" filter="url(#shadow)"/>

  <!-- Clock face circle -->
  <circle cx="512" cy="512" r="320" fill="white" opacity="0.95"/>

  <!-- Clock markers -->
  <g transform="translate(512, 512)">
    <!-- 12 o'clock marker (thicker) -->
    <rect x="-8" y="-300" width="16" height="50" rx="8" fill="#1e40af"/>
    <!-- 3 o'clock marker -->
    <rect x="250" y="-8" width="50" height="16" rx="8" fill="#1e40af"/>
    <!-- 6 o'clock marker -->
    <rect x="-8" y="250" width="16" height="50" rx="8" fill="#1e40af"/>
    <!-- 9 o'clock marker -->
    <rect x="-300" y="-8" width="50" height="16" rx="8" fill="#1e40af"/>

    <!-- Smaller markers for other hours -->
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(30)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(60)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(120)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(150)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(210)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(240)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(300)"/>
    <rect x="-6" y="-280" width="12" height="35" rx="6" fill="#60a5fa" transform="rotate(330)"/>
  </g>

  <!-- Clock hands at 12:00 (standup time!) -->
  <g transform="translate(512, 512)">
    <!-- Hour hand -->
    <rect x="-12" y="-160" width="24" height="180" rx="12" fill="#1e40af" filter="url(#shadow)"/>
    <!-- Minute hand -->
    <rect x="-10" y="-240" width="20" height="260" rx="10" fill="#2563eb" filter="url(#shadow)"/>
    <!-- Center dot -->
    <circle cx="0" cy="0" r="28" fill="#1e40af"/>
    <circle cx="0" cy="0" r="18" fill="white"/>
  </g>

  <!-- Accent: small "60s" indicator at bottom -->
  <g transform="translate(512, 760)">
    <rect x="-80" y="-35" width="160" height="70" rx="35" fill="#ef4444" opacity="0.9"/>
    <text x="0" y="15" font-family="system-ui, -apple-system, sans-serif" font-size="40" font-weight="bold" fill="white" text-anchor="middle">60s</text>
  </g>
</svg>
EOF

# Function to generate PNG using available tool
generate_png() {
    size=$1
    output=$2

    if command -v rsvg-convert &> /dev/null; then
        echo "Using rsvg-convert to generate ${size}x${size} icon..."
        rsvg-convert -w $size -h $size icon.svg -o "$output"
    elif command -v convert &> /dev/null; then
        echo "Using ImageMagick to generate ${size}x${size} icon..."
        convert -background none -resize ${size}x${size} icon.svg "$output"
    elif command -v sips &> /dev/null && command -v qlmanage &> /dev/null; then
        echo "Using macOS native tools to generate ${size}x${size} icon..."
        # First convert SVG to PNG at large size, then resize
        qlmanage -t -s 1024 -o . icon.svg 2>/dev/null
        sips -z $size $size icon.svg.png --out "$output" 2>/dev/null
        rm -f icon.svg.png
    else
        echo "Error: No suitable image converter found."
        echo "Please install one of: librsvg (rsvg-convert), ImageMagick (convert), or run on macOS"
        exit 1
    fi
}

# Create directory for icons
mkdir -p "StandupTimer/Assets.xcassets/AppIcon.appiconset"

# Generate all required icon sizes for macOS
echo "Generating app icons..."
generate_png 16 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_16x16.png"
generate_png 32 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_16x16@2x.png"
generate_png 32 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_32x32.png"
generate_png 64 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_32x32@2x.png"
generate_png 128 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_128x128.png"
generate_png 256 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_128x128@2x.png"
generate_png 256 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_256x256.png"
generate_png 512 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_256x256@2x.png"
generate_png 512 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_512x512.png"
generate_png 1024 "StandupTimer/Assets.xcassets/AppIcon.appiconset/icon_512x512@2x.png"

# Update Contents.json with filenames
cat > "StandupTimer/Assets.xcassets/AppIcon.appiconset/Contents.json" << 'EOF'
{
  "images" : [
    {
      "filename" : "icon_16x16.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_16x16@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_32x32.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_32x32@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_128x128.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_128x128@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_256x256.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_256x256@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_512x512.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "512x512"
    },
    {
      "filename" : "icon_512x512@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "512x512"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

echo "Icon generation complete!"
echo "Icons saved to: StandupTimer/Assets.xcassets/AppIcon.appiconset/"

# Clean up
rm -f icon.svg

echo ""
echo "Next steps:"
echo "1. Open StandupTimer.xcodeproj in Xcode"
echo "2. Build the project (Cmd+B)"
echo "3. The app will be in DerivedData or you can archive it for distribution"
