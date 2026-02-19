import Foundation

enum MemoMapper {
    static func toDomain(_ model: MemoModel) -> Memo {
        Memo(
            id: model.id,
            eventId: model.eventId,
            body: model.body,
            createdAt: model.createdAt
        )
    }

    static func toModel(_ entity: Memo) -> MemoModel {
        MemoModel(
            id: entity.id,
            eventId: entity.eventId,
            body: entity.body,
            createdAt: entity.createdAt
        )
    }

    static func update(_ model: MemoModel, from entity: Memo) {
        model.body = entity.body
    }
}
