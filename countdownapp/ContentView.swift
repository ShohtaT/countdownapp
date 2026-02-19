import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        let repository = CountdownEventRepository(modelContext: modelContext)
        let fetchUseCase = FetchEventsUseCase(repository: repository)
        let addUseCase = AddEventUseCase(repository: repository)
        let updateUseCase = UpdateEventUseCase(repository: repository)
        let deleteUseCase = DeleteEventUseCase(repository: repository)

        let viewModel = CountdownPageViewModel(
            fetchEventsUseCase: fetchUseCase,
            addEventUseCase: addUseCase,
            updateEventUseCase: updateUseCase,
            deleteEventUseCase: deleteUseCase
        )

        CountdownPageView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CountdownEventModel.self, inMemory: true)
}
