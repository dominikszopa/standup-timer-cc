import SwiftUI
import AppKit

@main
struct StandupTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Set window to always stay on top
                    if let window = NSApplication.shared.windows.first {
                        window.level = .floating
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
