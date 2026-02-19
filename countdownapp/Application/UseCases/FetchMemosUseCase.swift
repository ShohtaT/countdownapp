import Foundation

final class FetchMemosUseCase {
    private let repository: MemoRepositoryProtocol

    init(repository: MemoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(eventId: UUID) throws -> [Memo] {
        try repository.fetchAll(eventId: eventId)
    }
}
