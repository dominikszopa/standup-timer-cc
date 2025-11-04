import Foundation
import Combine

@Observable
class TimerViewModel {
    var timeRemaining: Int = 60 // Start at 1 minute
    var isRunning: Bool = false
    var isOvertime: Bool = false

    private var timer: Timer?
    private let startTime: Int = 60

    // Array of witty messages for when time is up
    private let wittyMessages = [
        "Time to wrap it up! ⏰",
        "Your minute is showing... 👀",
        "Houston, we have overtime! 🚀",
        "The clock is judging you now ⏱️",
        "Brevity is the soul of wit! 🎭",
        "TL;DR time! 📝",
        "Red means stop talking! 🛑",
        "Even your coffee is getting cold ☕️",
        "Short and sweet, please! 🍬",
        "The timer is giving you the look 👁️"
    ]

    var currentWittyMessage: String = ""

    func start() {
        guard !isRunning else { return }
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func next() {
        stop()
        timeRemaining = startTime
        isOvertime = false
        currentWittyMessage = ""
        start()
    }

    private func tick() {
        if !isOvertime {
            // Counting down
            timeRemaining -= 1

            if timeRemaining <= 0 {
                // Time's up! Switch to overtime
                isOvertime = true
                timeRemaining = 0
                currentWittyMessage = wittyMessages.randomElement() ?? "Time to wrap it up!"
            }
        } else {
            // Counting up in overtime
            timeRemaining += 1
        }
    }

    var timeDisplay: String {
        let absTime = abs(timeRemaining)
        let minutes = absTime / 60
        let seconds = absTime % 60

        if isOvertime && timeRemaining > 0 {
            return String(format: "+%d:%02d", minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}
