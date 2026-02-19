import Foundation

struct CountdownEvent: Identifiable, Equatable, Hashable {
    let id: UUID
    var title: String
    var targetDate: Date
    var color: EventColor
    let createdAt: Date
    var displayOrder: Int

    var isExpired: Bool {
        targetDate <= Date()
    }

    func timeRemaining(from now: Date) -> TimeRemaining {
        TimeRemaining(from: now, to: targetDate)
    }
}
