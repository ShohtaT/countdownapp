import Foundation

enum CountdownEventMapper {
    static func toDomain(_ model: CountdownEventModel) -> CountdownEvent {
        CountdownEvent(
            id: model.id,
            title: model.title,
            targetDate: model.targetDate,
            color: EventColor(rawValue: model.colorRawValue) ?? .blue,
            createdAt: model.createdAt,
            displayOrder: model.displayOrder
        )
    }

    static func toModel(_ entity: CountdownEvent) -> CountdownEventModel {
        CountdownEventModel(
            id: entity.id,
            title: entity.title,
            targetDate: entity.targetDate,
            colorRawValue: entity.color.rawValue,
            createdAt: entity.createdAt,
            displayOrder: entity.displayOrder
        )
    }

    static func update(_ model: CountdownEventModel, from entity: CountdownEvent) {
        model.title = entity.title
        model.targetDate = entity.targetDate
        model.colorRawValue = entity.color.rawValue
        model.displayOrder = entity.displayOrder
    }
}
