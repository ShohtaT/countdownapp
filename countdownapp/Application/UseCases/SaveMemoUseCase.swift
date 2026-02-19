import Foundation

final class SaveMemoUseCase {
    private let repository: MemoRepositoryProtocol

    init(repository: MemoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(eventId: UUID, body: String) throws {
        let trimmed = body.trimmingCharacters(in: .whitespacesAndNewlines)
        let existing = try repository.fetchAll(eventId: eventId)

        if trimmed.isEmpty {
            if let memo = existing.first {
                try repository.delete(id: memo.id)
            }
            return
        }

        if let memo = existing.first {
            var updated = memo
            updated.body = trimmed
            try repository.update(updated)
        } else {
            let memo = Memo(id: UUID(), eventId: eventId, body: trimmed, createdAt: Date())
            try repository.add(memo)
        }
    }
}
