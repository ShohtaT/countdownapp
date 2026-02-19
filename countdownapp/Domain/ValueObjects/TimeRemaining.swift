import Foundation

struct TimeRemaining: Equatable {
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    let isExpired: Bool
    let totalSeconds: Int

    init(from now: Date, to target: Date) {
        let interval = target.timeIntervalSince(now)

        if interval <= 0 {
            self.days = 0
            self.hours = 0
            self.minutes = 0
            self.seconds = 0
            self.isExpired = true
            self.totalSeconds = 0
            return
        }

        self.isExpired = false
        self.totalSeconds = Int(interval)

        let totalMinutes = totalSeconds / 60
        let totalHours = totalMinutes / 60

        self.days = totalHours / 24
        self.hours = totalHours % 24
        self.minutes = totalMinutes % 60
        self.seconds = totalSeconds % 60
    }
}
