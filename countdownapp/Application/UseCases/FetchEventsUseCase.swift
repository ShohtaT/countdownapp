import Foundation

final class FetchEventsUseCase {
    private let repository: CountdownEventRepositoryProtocol

    init(repository: CountdownEventRepositoryProtocol) {
        self.repository = repository
    }

    func execute() throws -> [CountdownEvent] {
        try repository.fetchAll()
    }
}
