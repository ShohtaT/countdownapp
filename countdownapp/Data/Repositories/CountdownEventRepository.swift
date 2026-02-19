import Foundation
import SwiftData

final class CountdownEventRepository: CountdownEventRepositoryProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchAll() throws -> [CountdownEvent] {
        let descriptor = FetchDescriptor<CountdownEventModel>(
            sortBy: [SortDescriptor(\.displayOrder)]
        )
        let models = try modelContext.fetch(descriptor)
        return models.map(CountdownEventMapper.toDomain)
    }

    func add(_ event: CountdownEvent) throws {
        let model = CountdownEventMapper.toModel(event)
        modelContext.insert(model)
        try modelContext.save()
    }

    func update(_ event: CountdownEvent) throws {
        let predicate = #Predicate<CountdownEventModel> { $0.id == event.id }
        let descriptor = FetchDescriptor(predicate: predicate)
        guard let model = try modelContext.fetch(descriptor).first else { return }
        CountdownEventMapper.update(model, from: event)
        try modelContext.save()
    }

    func delete(id: UUID) throws {
        let predicate = #Predicate<CountdownEventModel> { $0.id == id }
        let descriptor = FetchDescriptor(predicate: predicate)
        guard let model = try modelContext.fetch(descriptor).first else { return }
        modelContext.delete(model)
        try modelContext.save()
    }
}
