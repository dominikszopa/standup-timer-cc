import SwiftUI

struct ContentView: View {
    @State private var viewModel = TimerViewModel()

    var body: some View {
        VStack(spacing: 15) {
            // Timer Display
            VStack(spacing: 6) {
                Text(viewModel.timeDisplay)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(viewModel.isOvertime ? .red : .primary)
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .animation(.spring(duration: 0.3), value: viewModel.timeDisplay)

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

            // Progress indicator
            if !viewModel.isOvertime {
                ProgressView(value: Double(60 - viewModel.timeRemaining), total: 60)
                    .progressViewStyle(.linear)
                    .tint(.blue)
                    .frame(maxWidth: 150)
            } else {
                Divider()
                    .frame(maxWidth: 150)
                    .overlay(.red)
            }

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
        .frame(minWidth: 200, minHeight: 175)
        .background {
            // Translucent background with materials
            if viewModel.isOvertime {
                ZStack {
                    Color.clear.background(.ultraThinMaterial)
                    Color.red.opacity(0.1)
                }
                .transition(.opacity)
            } else {
                Color.clear.background(.ultraThinMaterial)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.isOvertime)
    }
}

#Preview {
    ContentView()
}
