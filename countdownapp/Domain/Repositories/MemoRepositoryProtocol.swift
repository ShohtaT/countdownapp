import Foundation

protocol MemoRepositoryProtocol {
    func fetchAll(eventId: UUID) throws -> [Memo]
    func add(_ memo: Memo) throws
    func delete(id: UUID) throws
}
