import Foundation

protocol CountdownEventRepositoryProtocol {
    func fetchAll() throws -> [CountdownEvent]
    func add(_ event: CountdownEvent) throws
    func update(_ event: CountdownEvent) throws
    func delete(id: UUID) throws
}
