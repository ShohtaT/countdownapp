import Foundation
import SwiftUI

@Observable
final class CountdownPageViewModel {
    private let fetchEventsUseCase: FetchEventsUseCase
    private let addEventUseCase: AddEventUseCase
    private let updateEventUseCase: UpdateEventUseCase
    private let deleteEventUseCase: DeleteEventUseCase
    private let fetchMemosUseCase: FetchMemosUseCase?

    var events: [CountdownEvent] = []
    var now: Date = Date()
    var currentPageIndex: Int = 0
    var showingAddSheet = false
    var showingEventList = false
    var editingEvent: CountdownEvent?
    var selectedMemoEvent: CountdownEvent?
    var latestMemos: [UUID: Memo] = [:]

    var memoViewModelFactory: ((CountdownEvent) -> CorkBoardViewModel)?

    private var timer: Timer?

    var activeEvents: [CountdownEvent] {
        events.filter { !$0.isExpired }
    }

    var expiredEvents: [CountdownEvent] {
        events.filter { $0.isExpired }
    }

    init(
        fetchEventsUseCase: FetchEventsUseCase,
        addEventUseCase: AddEventUseCase,
        updateEventUseCase: UpdateEventUseCase,
        deleteEventUseCase: DeleteEventUseCase,
        fetchMemosUseCase: FetchMemosUseCase? = nil,
        memoViewModelFactory: ((CountdownEvent) -> CorkBoardViewModel)? = nil
    ) {
        self.fetchEventsUseCase = fetchEventsUseCase
        self.addEventUseCase = addEventUseCase
        self.updateEventUseCase = updateEventUseCase
        self.deleteEventUseCase = deleteEventUseCase
        self.fetchMemosUseCase = fetchMemosUseCase
        self.memoViewModelFactory = memoViewModelFactory
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.now = Date()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func loadEvents() {
        do {
            events = try fetchEventsUseCase.execute()
            clampPageIndex()
            loadLatestMemos()
        } catch {
            print("Failed to load events: \(error)")
        }
    }

    func loadLatestMemos() {
        guard let fetchMemosUseCase else { return }
        var result: [UUID: Memo] = [:]
        for event in events {
            if let first = try? fetchMemosUseCase.execute(eventId: event.id).first {
                result[event.id] = first
            }
        }
        latestMemos = result
    }

    func addEvent(title: String, targetDate: Date, color: EventColor) {
        do {
            try addEventUseCase.execute(title: title, targetDate: targetDate, color: color)
            loadEvents()
            let activeCount = activeEvents.count
            if activeCount > 0 {
                currentPageIndex = activeCount - 1
            }
        } catch {
            print("Failed to add event: \(error)")
        }
    }

    func updateEvent(_ event: CountdownEvent) {
        do {
            try updateEventUseCase.execute(event)
            loadEvents()
        } catch {
            print("Failed to update event: \(error)")
        }
    }

    func deleteEvent(id: UUID) {
        do {
            try deleteEventUseCase.execute(id: id)
            loadEvents()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }

    private func clampPageIndex() {
        let maxIndex = max(0, activeEvents.count - 1)
        if currentPageIndex > maxIndex {
            currentPageIndex = maxIndex
        }
    }
}
