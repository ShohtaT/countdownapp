import SwiftUI

struct CountdownPageView: View {
    @State var viewModel: CountdownPageViewModel
    @State private var formViewModel = EventFormViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient

                if viewModel.activeEvents.isEmpty {
                    EmptyStateView {
                        formViewModel.configureForAdd()
                        viewModel.showingAddSheet = true
                    }
                } else {
                    TabView(selection: $viewModel.currentPageIndex) {
                        ForEach(Array(viewModel.activeEvents.enumerated()), id: \.element.id) { index, event in
                            CountdownCardView(
                                event: event,
                                now: viewModel.now,
                                onEdit: {
                                    formViewModel.configureForEdit(event)
                                    viewModel.editingEvent = event
                                    viewModel.showingAddSheet = true
                                },
                                onDelete: {
                                    withAnimation {
                                        viewModel.deleteEvent(id: event.id)
                                    }
                                }
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showingEventList = true
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                    .glassEffect(.regular.interactive())
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        formViewModel.configureForAdd()
                        viewModel.editingEvent = nil
                        viewModel.showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .glassEffect(.regular.interactive())
                }
            }
            .sheet(isPresented: $viewModel.showingAddSheet) {
                EventFormSheet(
                    formViewModel: formViewModel,
                    onSave: { title, date, color in
                        viewModel.addEvent(title: title, targetDate: date, color: color)
                    },
                    onUpdate: { event in
                        viewModel.updateEvent(event)
                    }
                )
            }
            .sheet(isPresented: $viewModel.showingEventList) {
                EventListView(viewModel: viewModel) { event in
                    formViewModel.configureForEdit(event)
                    viewModel.showingEventList = false
                    viewModel.showingAddSheet = true
                }
            }
        }
        .onAppear {
            viewModel.loadEvents()
            viewModel.startTimer()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.systemBackground).opacity(0.95)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
