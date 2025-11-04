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

#### Option 1: Using Xcode

1. Open the project directory in Terminal
2. Run: `open Package.swift`
3. Xcode will open the project
4. Click the Run button (or press Cmd+R)

#### Option 2: Using Terminal

```bash
# Build the app
swift build

# Run the app
swift run
```

#### Option 3: Create a standalone app

```bash
# Build in release mode
swift build -c release

# The binary will be at:
# .build/release/StandupTimer
```

## Project Structure

```
standup-timer-cc/
├── Package.swift              # Swift package manifest
├── Sources/
│   ├── main.swift            # App entry point
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
