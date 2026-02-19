import Foundation

@Observable
final class EventFormViewModel {
    var title: String = ""
    var targetDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    var selectedColor: EventColor = .blue
    var isEditing: Bool = false

    private var editingEventId: UUID?
    private var editingCreatedAt: Date?
    private var editingDisplayOrder: Int?

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func configureForAdd() {
        title = ""
        targetDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        selectedColor = .blue
        isEditing = false
        editingEventId = nil
        editingCreatedAt = nil
        editingDisplayOrder = nil
    }

    func configureForEdit(_ event: CountdownEvent) {
        title = event.title
        targetDate = event.targetDate
        selectedColor = event.color
        isEditing = true
        editingEventId = event.id
        editingCreatedAt = event.createdAt
        editingDisplayOrder = event.displayOrder
    }

    func buildEvent() -> CountdownEvent? {
        guard isValid else { return nil }

        if isEditing, let id = editingEventId, let createdAt = editingCreatedAt, let order = editingDisplayOrder {
            return CountdownEvent(
                id: id,
                title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                targetDate: targetDate,
                color: selectedColor,
                createdAt: createdAt,
                displayOrder: order
            )
        }
        return nil
    }
}
