import SwiftUI

struct ContentView: View {
    @State private var viewModel = TimerViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.05) {
                Spacer()

                // Timer Display
                VStack(spacing: 12) {
                    Text(viewModel.timeDisplay)
                        .font(.system(size: min(geometry.size.width * 0.2, 96), weight: .bold, design: .rounded))
                        .foregroundStyle(viewModel.isOvertime ? .red : .primary)
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .animation(.spring(duration: 0.3), value: viewModel.timeDisplay)
                        .shadow(color: viewModel.isOvertime ? .red.opacity(0.3) : .clear, radius: 10)

                    // Witty message when overtime
                    if viewModel.isOvertime && !viewModel.currentWittyMessage.isEmpty {
                        Text(viewModel.currentWittyMessage)
                            .font(.system(size: min(geometry.size.width * 0.05, 20)))
                            .fontWeight(.medium)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.spring(duration: 0.5), value: viewModel.currentWittyMessage)
                            .padding(.horizontal)
                    }
                }

                Spacer()

                // Progress indicator
                if !viewModel.isOvertime {
                    ProgressView(value: Double(60 - viewModel.timeRemaining), total: 60)
                        .progressViewStyle(.linear)
                        .tint(.blue)
                        .frame(maxWidth: min(geometry.size.width * 0.8, 400))
                        .shadow(color: .blue.opacity(0.3), radius: 4)
                } else {
                    Divider()
                        .frame(maxWidth: min(geometry.size.width * 0.8, 400))
                        .overlay(.red.opacity(0.7))
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
                        HStack(spacing: 8) {
                            Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                            Text(viewModel.isRunning ? "Pause" : "Start")
                        }
                        .frame(minWidth: geometry.size.width * 0.25)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(geometry.size.width > 400 ? .large : .regular)
                    .tint(viewModel.isRunning ? .orange : .blue)
                    .keyboardShortcut(.space, modifiers: [])

                    Button(action: {
                        viewModel.next()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.forward.circle.fill")
                            Text("Next")
                        }
                        .frame(minWidth: geometry.size.width * 0.25)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(geometry.size.width > 400 ? .large : .regular)
                    .keyboardShortcut(.return, modifiers: [.command])
                }
                .padding(.bottom, geometry.size.height * 0.08)
            }
        }
        .background {
            // Translucent background with materials
            ZStack {
                if viewModel.isOvertime {
                    // Red translucent background during overtime
                    Color.red.opacity(0.15)
                        .transition(.opacity)
                }

                // Ultra thin material for glass effect
                VisualEffectBlur(material: .hudWindow, blendingMode: .behindWindow)
                    .ignoresSafeArea()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.isOvertime)
    }
}

// Custom visual effect blur for translucency
struct VisualEffectBlur: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

#Preview {
    ContentView()
}
