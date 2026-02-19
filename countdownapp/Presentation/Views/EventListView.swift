import SwiftUI

struct EventListView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: CountdownPageViewModel
    var onEdit: (CountdownEvent) -> Void

    var body: some View {
        NavigationStack {
            List {
                if !viewModel.activeEvents.isEmpty {
                    Section("アクティブ") {
                        ForEach(viewModel.activeEvents) { event in
                            eventRow(event)
                        }
                    }
                }

                if !viewModel.expiredEvents.isEmpty {
                    Section("期限切れ") {
                        ForEach(viewModel.expiredEvents) { event in
                            eventRow(event)
                        }
                    }
                }

                if viewModel.events.isEmpty {
                    ContentUnavailableView(
                        "イベントがありません",
                        systemImage: "calendar.badge.clock",
                        description: Text("右上の＋ボタンからイベントを追加しましょう")
                    )
                }
            }
            .navigationTitle("イベント一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func eventRow(_ event: CountdownEvent) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(event.color.color.gradient)
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 2) {
                Text(event.title)
                    .font(.body)
                    .fontWeight(.medium)

                Text(event.targetDate, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if event.isExpired {
                Text("期限切れ")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.red.opacity(0.1), in: Capsule())
            } else {
                let remaining = event.timeRemaining(from: Date())
                Text(remainingText(remaining))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                viewModel.deleteEvent(id: event.id)
            } label: {
                Label("削除", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                onEdit(event)
            } label: {
                Label("編集", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }

    private func remainingText(_ time: TimeRemaining) -> String {
        if time.days > 0 {
            return "あと\(time.days)日"
        } else if time.hours > 0 {
            return "あと\(time.hours)時間"
        } else {
            return "あと\(time.minutes)分"
        }
    }
}
