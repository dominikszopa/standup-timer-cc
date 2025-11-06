# Standup Timer

A beautiful, modern macOS standup timer built with SwiftUI. Perfect for keeping daily standup meetings on track!

## Features

- **Native macOS Application** - Runs from your Applications folder with a beautiful app icon
- **No Terminal Required** - Launches as a standard macOS app
- **1-minute countdown timer** - Start counting down from 60 seconds
- **Overtime tracking** - When time runs out, the timer turns red and counts up
- **Witty messages** - Random encouraging messages when you go over time
- **Modern macOS design** - Uses the latest SwiftUI design patterns and materials
- **Keyboard shortcuts** - Space to start/pause, Cmd+Return for next person
- **Smooth animations** - Beautiful transitions and visual feedback

## How It Works

1. Click **Start** (or press Space) to begin the 60-second countdown
2. When time reaches 0:
   - Timer turns red
   - A witty message appears (e.g., "Time to wrap it up! ⏰")
   - Timer starts counting up to show overtime
3. Click **Next** (or press Cmd+Return) to reset and start the next person's turn

## Building and Running

### Requirements

- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later
- Swift 5.9 or later

### Build Instructions

#### Step 1: Generate App Icon

First, generate the app icon assets:

```bash
./generate_icon.sh
```

This will create a beautiful blue timer icon at all required sizes.

#### Step 2: Build the Native App

**Option 1: Using the Build Script (Easiest)**

Simply run:

```bash
./build_app.sh
```

This script will:
- Generate the app icon (if not already created)
- Build the app using xcodebuild
- Optionally install it to /Applications

**Option 2: Using Xcode (Recommended for Development)**

1. Open the project in Xcode:
   ```bash
   open StandupTimer.xcodeproj
   ```

2. Build the app (Cmd+B)

3. Run the app (Cmd+R) to test it

4. To create a standalone app bundle:
   - Select **Product** > **Archive**
   - Click **Distribute App** > **Copy App**
   - Choose a location to save the .app bundle
   - Drag **StandupTimer.app** to your Applications folder

**Option 3: Using xcodebuild (Command Line)**

```bash
# Build the app
xcodebuild -project StandupTimer.xcodeproj -scheme StandupTimer -configuration Release

# The app will be in:
# build/Build/Products/Release/StandupTimer.app

# Copy to Applications folder
cp -r build/Build/Products/Release/StandupTimer.app /Applications/
```

### Installing to Applications Folder

Once built, simply drag **StandupTimer.app** to your `/Applications` folder. You can then:
- Launch it from Spotlight (Cmd+Space, type "Standup Timer")
- Pin it to your Dock
- Launch it from Finder > Applications

## Project Structure

```
standup-timer-cc/
├── StandupTimer.xcodeproj/    # Xcode project
├── StandupTimer/              # App resources
│   ├── Assets.xcassets/       # App icon and assets
│   └── Info.plist             # App configuration
├── Sources/                   # Source code
│   ├── StandupTimerApp.swift  # App entry point
│   ├── ContentView.swift      # Main UI view
│   └── TimerViewModel.swift   # Timer logic and state
├── generate_icon.sh           # Icon generation script
├── Package.swift              # Legacy Swift package (deprecated)
└── README.md
```

## Witty Messages

When your minute is up, you'll see one of these randomly selected messages:

- "Time to wrap it up! ⏰"
- "Your minute is showing... 👀"
- "Houston, we have overtime! 🚀"
- "The clock is judging you now ⏱️"
- "Brevity is the soul of wit! 🎭"
- And more!

## Technical Details

- Built with **SwiftUI** for modern, declarative UI
- Uses `@Observable` macro for state management
- Implements smooth animations with `.contentTransition` and `.animation`
- Follows macOS design guidelines with materials and vibrancy
- Keyboard shortcuts for accessibility

## License

MIT
