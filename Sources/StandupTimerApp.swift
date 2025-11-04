import SwiftUI

@main
struct StandupTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(.clear)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .windowBackgroundDragBehavior(.enabled)
    }
}
