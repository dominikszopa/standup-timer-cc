# Standup Timer

A beautiful, modern macOS standup timer built with SwiftUI. Perfect for keeping daily standup meetings on track!

## Features

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

#### Option 1: Build Standalone App (Recommended)

Create a proper macOS .app bundle that can be installed in your Applications folder:

```bash
# Run the build script
./build_app.sh

# Install to Applications folder
cp -r ".build/release/Standup Timer.app" /Applications/

# Or open directly
open ".build/release/Standup Timer.app"
```

The app will be built as a proper macOS application that you can:
- Copy to `/Applications/` folder
- Launch from Spotlight (Cmd+Space)
- Add to your Dock
- Distribute to others

#### Option 2: Using Xcode

1. Open the project directory in Terminal
2. Run: `open Package.swift`
3. Xcode will open the project
4. Click the Run button (or press Cmd+R)

#### Option 3: Quick Development Run

For quick testing during development:

```bash
# Build and run directly
swift run
```

### Creating a DMG for Distribution

After building the standalone app, you can create a disk image for distribution:

```bash
hdiutil create -volname "Standup Timer" -srcfolder ".build/release/Standup Timer.app" -ov -format UDZO "StandupTimer.dmg"
```

## Project Structure

```
standup-timer-cc/
├── Package.swift              # Swift package manifest
├── Info.plist                # App bundle metadata
├── build_app.sh              # Build script for standalone .app
├── Sources/
│   ├── StandupTimerApp.swift # App entry point
│   ├── ContentView.swift     # Main UI view
│   └── TimerViewModel.swift  # Timer logic and state
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
