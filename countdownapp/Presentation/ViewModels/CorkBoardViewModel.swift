import Foundation

@Observable
final class CorkBoardViewModel {
    private let fetchMemosUseCase: FetchMemosUseCase
    private let addMemoUseCase: AddMemoUseCase
    private let deleteMemoUseCase: DeleteMemoUseCase

    let event: CountdownEvent

    var memos: [Memo] = []
    var inputText: String = ""

    var pinnedMemo: Memo? {
        memos.first
    }

    var pastMemos: [Memo] {
        Array(memos.dropFirst())
    }

    init(
        event: CountdownEvent,
        fetchMemosUseCase: FetchMemosUseCase,
        addMemoUseCase: AddMemoUseCase,
        deleteMemoUseCase: DeleteMemoUseCase
    ) {
        self.event = event
        self.fetchMemosUseCase = fetchMemosUseCase
        self.addMemoUseCase = addMemoUseCase
        self.deleteMemoUseCase = deleteMemoUseCase
    }

    func loadMemos() {
        do {
            memos = try fetchMemosUseCase.execute(eventId: event.id)
        } catch {
            print("Failed to load memos: \(error)")
        }
    }

    func addMemo() {
        do {
            try addMemoUseCase.execute(eventId: event.id, body: inputText)
            inputText = ""
            loadMemos()
        } catch {
            print("Failed to add memo: \(error)")
        }
    }

    func deleteMemo(id: UUID) {
        do {
            try deleteMemoUseCase.execute(id: id)
            loadMemos()
        } catch {
            print("Failed to delete memo: \(error)")
        }
    }
}
