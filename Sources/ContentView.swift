import SwiftUI

struct ContentView: View {
    @State private var viewModel = TimerViewModel()

    var body: some View {
        VStack(spacing: 15) {
            // Analogue Clock Display
            VStack(spacing: 12) {
                AnalogueClockView(
                    timeRemaining: viewModel.timeRemaining,
                    totalTime: 60,
                    isOvertime: viewModel.isOvertime
                )
                .frame(width: 100, height: 100)

                // Witty message when overtime
                if viewModel.isOvertime && !viewModel.currentWittyMessage.isEmpty {
                    Text(viewModel.currentWittyMessage)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(duration: 0.5), value: viewModel.currentWittyMessage)
                }
            }
            .padding(.top, 20)

            // Buttons
            HStack(spacing: 8) {
                Button(action: {
                    if viewModel.isRunning {
                        viewModel.stop()
                    } else {
                        viewModel.start()
                    }
                }) {
                    HStack {
                        Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                        Text(viewModel.isRunning ? "Pause" : "Start")
                    }
                    .frame(minWidth: 50)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .tint(viewModel.isRunning ? .orange : .blue)
                .keyboardShortcut(.space, modifiers: [])

                Button(action: {
                    viewModel.next()
                }) {
                    HStack {
                        Image(systemName: "arrow.forward.circle.fill")
                        Text("Next")
                    }
                    .frame(minWidth: 50)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .keyboardShortcut(.return, modifiers: [.command])
            }
            .padding(.bottom, 20)
        }
        .frame(minWidth: 175, minHeight: 250)
        .background {
            // Modern macOS background with materials
            if viewModel.isOvertime {
                Color.red.opacity(0.05)
                    .transition(.opacity)
            } else {
                Color.clear
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.isOvertime)
    }
}

struct AnalogueClockView: View {
    let timeRemaining: Int
    let totalTime: Int
    let isOvertime: Bool

    var body: some View {
        ZStack {
            // Clock face background
            Circle()
                .stroke(isOvertime ? Color.red.opacity(0.2) : Color.gray.opacity(0.2), lineWidth: 2)

            // Tick marks
            ForEach(0..<60) { second in
                TickMark(second: second, isOvertime: isOvertime)
            }

            // Second numbers (0, 15, 30, 45)
            ForEach([0, 15, 30, 45], id: \.self) { second in
                SecondLabel(second: second, isOvertime: isOvertime)
            }

            // Progress arc (showing remaining time)
            if !isOvertime {
                Circle()
                    .trim(from: 0, to: CGFloat(totalTime - timeRemaining) / CGFloat(totalTime))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.3), value: timeRemaining)
            }

            // Clock hand
            ClockHand(timeRemaining: timeRemaining, totalTime: totalTime, isOvertime: isOvertime)
                .animation(.linear(duration: 0.3), value: timeRemaining)

            // Center dot
            Circle()
                .fill(isOvertime ? Color.red : Color.blue)
                .frame(width: 8, height: 8)
        }
    }
}

struct TickMark: View {
    let second: Int
    let isOvertime: Bool

    var body: some View {
        GeometryReader { geometry in
            let isMajor = second % 5 == 0
            let angle = Double(second) * 6.0 - 90 // Convert to degrees (6° per second, start at top)
            let length = isMajor ? 12.0 : 6.0
            let width = isMajor ? 2.0 : 1.0

            Rectangle()
                .fill(isOvertime ? Color.red.opacity(0.6) : Color.gray.opacity(0.6))
                .frame(width: width, height: length)
                .offset(y: -(geometry.size.height / 2) + length / 2)
                .rotationEffect(.degrees(angle))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

struct SecondLabel: View {
    let second: Int
    let isOvertime: Bool

    var body: some View {
        GeometryReader { geometry in
            let angle = Double(second) * 6.0 - 90 // Same angle calculation
            let radius = geometry.size.width / 2 - 25

            Text("\(second)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(isOvertime ? Color.red : Color.primary)
                .position(
                    x: geometry.size.width / 2 + cos(angle * .pi / 180) * radius,
                    y: geometry.size.height / 2 + sin(angle * .pi / 180) * radius
                )
        }
    }
}

struct ClockHand: View {
    let timeRemaining: Int
    let totalTime: Int
    let isOvertime: Bool

    var body: some View {
        GeometryReader { geometry in
            let elapsed = isOvertime ? 0 : (totalTime - timeRemaining)
            let angle = Double(elapsed) * 6.0 // 6° per second

            // Hand - using ZStack to properly center and rotate
            ZStack {
                Capsule()
                    .fill(isOvertime ? Color.red : Color.blue)
                    .frame(width: 3, height: geometry.size.height / 2 - 20)
                    .offset(y: -(geometry.size.height / 4 - 10)) // Offset upward by half the hand length
            }
            .rotationEffect(.degrees(angle))
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

#Preview {
    ContentView()
}
