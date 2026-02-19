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

        let memoRepository = MemoRepository(modelContext: modelContext)
        let fetchMemosUseCase = FetchMemosUseCase(repository: memoRepository)
        let addMemoUseCase = AddMemoUseCase(repository: memoRepository)
        let deleteMemoUseCase = DeleteMemoUseCase(repository: memoRepository)

        let viewModel = CountdownPageViewModel(
            fetchEventsUseCase: fetchUseCase,
            addEventUseCase: addUseCase,
            updateEventUseCase: updateUseCase,
            deleteEventUseCase: deleteUseCase,
            fetchMemosUseCase: fetchMemosUseCase,
            memoViewModelFactory: { event in
                CorkBoardViewModel(
                    event: event,
                    fetchMemosUseCase: fetchMemosUseCase,
                    addMemoUseCase: addMemoUseCase,
                    deleteMemoUseCase: deleteMemoUseCase
                )
            }
        )

        CountdownPageView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CountdownEventModel.self, inMemory: true)
}
