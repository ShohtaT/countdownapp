import Foundation
import SwiftData

@Model
final class MemoModel {
    @Attribute(.unique) var id: UUID
    var eventId: UUID
    var body: String
    var createdAt: Date

    var event: CountdownEventModel?

    init(
        id: UUID = UUID(),
        eventId: UUID,
        body: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.eventId = eventId
        self.body = body
        self.createdAt = createdAt
    }
}
