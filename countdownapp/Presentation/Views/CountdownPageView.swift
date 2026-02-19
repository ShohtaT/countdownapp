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
                                pinnedMemo: viewModel.latestMemos[event.id],
                                onEdit: {
                                    formViewModel.configureForEdit(event)
                                    viewModel.editingEvent = event
                                    viewModel.showingAddSheet = true
                                },
                                onMemo: {
                                    viewModel.startEditingMemo(event: event)
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
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    HStack(spacing: 8) {
                        ForEach(0..<viewModel.activeEvents.count, id: \.self) { index in
                            Circle()
                                .fill(index == viewModel.currentPageIndex ? Color.primary : Color.primary.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 16)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showingEventList = true
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        formViewModel.configureForAdd()
                        viewModel.editingEvent = nil
                        viewModel.showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
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
            .sheet(item: $viewModel.editingMemoEvent) { event in
                MemoEditSheet(
                    event: event,
                    initialText: viewModel.latestMemos[event.id]?.body ?? CountdownCardView.defaultMessage(for: event),
                    onSave: { text in
                        viewModel.saveMemo(body: text)
                    },
                    onCancel: {
                        viewModel.editingMemoEvent = nil
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

private struct MemoEditSheet: View {
    let event: CountdownEvent
    let initialText: String
    let onSave: (String) -> Void
    let onCancel: () -> Void

    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text(event.title)
                    .font(.headline)
                    .padding(.top)

                TextEditor(text: $text)
                    .frame(minHeight: 150)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary.opacity(0.3))
                    )
                    .padding(.horizontal)

                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        onSave(text)
                    }
                }
            }
            .navigationTitle("メモ編集")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium])
        .onAppear {
            text = initialText
        }
    }
}
