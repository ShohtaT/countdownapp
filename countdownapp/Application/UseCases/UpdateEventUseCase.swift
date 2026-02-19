import Foundation

final class UpdateEventUseCase {
    private let repository: CountdownEventRepositoryProtocol

    init(repository: CountdownEventRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ event: CountdownEvent) throws {
        try repository.update(event)
    }
}
