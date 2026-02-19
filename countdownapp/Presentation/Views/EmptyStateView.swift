import SwiftUI

struct EmptyStateView: View {
    var onAddTapped: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text("イベントがありません")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("カウントダウンしたいイベントを\n追加しましょう")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button(action: onAddTapped) {
                Label("イベントを追加", systemImage: "plus")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .glassEffect(.regular.interactive())
        }
        .padding()
    }
}
