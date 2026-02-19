import Foundation

struct Memo: Identifiable, Equatable {
    let id: UUID
    let eventId: UUID
    var body: String
    let createdAt: Date
}
