import SwiftUI

struct ContentView: View {
    @State private var viewModel = TimerViewModel()

    var body: some View {
        VStack(spacing: 30) {
            // Timer Display
            VStack(spacing: 12) {
                Text(viewModel.timeDisplay)
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundStyle(viewModel.isOvertime ? .red : .primary)
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .animation(.spring(duration: 0.3), value: viewModel.timeDisplay)

                // Witty message when overtime
                if viewModel.isOvertime && !viewModel.currentWittyMessage.isEmpty {
                    Text(viewModel.currentWittyMessage)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(duration: 0.5), value: viewModel.currentWittyMessage)
                }
            }
            .padding(.top, 40)

            // Progress indicator
            if !viewModel.isOvertime {
                ProgressView(value: Double(60 - viewModel.timeRemaining), total: 60)
                    .progressViewStyle(.linear)
                    .tint(.blue)
                    .frame(maxWidth: 300)
            } else {
                Divider()
                    .frame(maxWidth: 300)
                    .overlay(.red)
            }

            // Buttons
            HStack(spacing: 16) {
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
                    .frame(minWidth: 100)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(viewModel.isRunning ? .orange : .blue)
                .keyboardShortcut(.space, modifiers: [])

                Button(action: {
                    viewModel.next()
                }) {
                    HStack {
                        Image(systemName: "arrow.forward.circle.fill")
                        Text("Next")
                    }
                    .frame(minWidth: 100)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .keyboardShortcut(.return, modifiers: [.command])
            }
            .padding(.bottom, 40)
        }
        .frame(minWidth: 400, minHeight: 350)
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

#Preview {
    ContentView()
}
