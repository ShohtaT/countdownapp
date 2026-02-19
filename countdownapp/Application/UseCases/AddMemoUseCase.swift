import Foundation

final class AddMemoUseCase {
    private let repository: MemoRepositoryProtocol

    init(repository: MemoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(eventId: UUID, body: String) throws {
        let trimmed = body.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let memo = Memo(
            id: UUID(),
            eventId: eventId,
            body: trimmed,
            createdAt: Date()
        )
        try repository.add(memo)
    }
}
