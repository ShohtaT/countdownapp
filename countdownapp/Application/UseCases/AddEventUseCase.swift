import Foundation

final class AddEventUseCase {
    private let repository: CountdownEventRepositoryProtocol

    init(repository: CountdownEventRepositoryProtocol) {
        self.repository = repository
    }

    func execute(title: String, targetDate: Date, color: EventColor) throws {
        let existingEvents = try repository.fetchAll()
        let maxOrder = existingEvents.map(\.displayOrder).max() ?? -1

        let event = CountdownEvent(
            id: UUID(),
            title: title,
            targetDate: targetDate,
            color: color,
            createdAt: Date(),
            displayOrder: maxOrder + 1
        )
        try repository.add(event)
    }
}
