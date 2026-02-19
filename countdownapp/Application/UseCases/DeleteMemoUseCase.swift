import Foundation

final class DeleteMemoUseCase {
    private let repository: MemoRepositoryProtocol

    init(repository: MemoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: UUID) throws {
        try repository.delete(id: id)
    }
}
