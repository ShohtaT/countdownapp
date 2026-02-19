import Foundation
import SwiftData

@Model
final class CountdownEventModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var targetDate: Date
    var colorRawValue: String
    var createdAt: Date
    var displayOrder: Int

    @Relationship(deleteRule: .cascade, inverse: \MemoModel.event)
    var memos: [MemoModel] = []

    init(
        id: UUID = UUID(),
        title: String,
        targetDate: Date,
        colorRawValue: String,
        createdAt: Date = Date(),
        displayOrder: Int = 0
    ) {
        self.id = id
        self.title = title
        self.targetDate = targetDate
        self.colorRawValue = colorRawValue
        self.createdAt = createdAt
        self.displayOrder = displayOrder
    }
}
