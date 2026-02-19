import Foundation
import SwiftData

final class MemoRepository: MemoRepositoryProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchAll(eventId: UUID) throws -> [Memo] {
        let targetEventId = eventId
        let predicate = #Predicate<MemoModel> { $0.eventId == targetEventId }
        let descriptor = FetchDescriptor<MemoModel>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        let models = try modelContext.fetch(descriptor)
        return models.map(MemoMapper.toDomain)
    }

    func add(_ memo: Memo) throws {
        let model = MemoMapper.toModel(memo)
        modelContext.insert(model)
        try modelContext.save()
    }

    func delete(id: UUID) throws {
        let targetId = id
        let predicate = #Predicate<MemoModel> { $0.id == targetId }
        let descriptor = FetchDescriptor(predicate: predicate)
        guard let model = try modelContext.fetch(descriptor).first else { return }
        modelContext.delete(model)
        try modelContext.save()
    }
}
