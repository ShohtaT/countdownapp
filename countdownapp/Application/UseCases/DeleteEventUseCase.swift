import Foundation

final class DeleteEventUseCase {
    private let repository: CountdownEventRepositoryProtocol

    init(repository: CountdownEventRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: UUID) throws {
        try repository.delete(id: id)
    }
}
