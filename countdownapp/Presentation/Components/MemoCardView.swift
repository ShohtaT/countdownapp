import SwiftUI

struct MemoCardView: View {
    let memo: Memo
    let isPinned: Bool
    var onDelete: () -> Void

    private var backgroundColor: Color {
        isPinned
            ? Color(red: 1.0, green: 0.97, blue: 0.80)
            : Color(red: 1.0, green: 1.0, blue: 0.95)
    }

    private var rotation: Double {
        isPinned ? 0 : Double(memo.id.hashValue % 7 - 3) * 0.5
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                Text(memo.body)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(memo.createdAt, format: .dateTime.month().day().hour().minute())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(4)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 1, y: 2)

            HStack(spacing: 4) {
                if isPinned {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                }

                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(.gray.opacity(0.6))
                }
            }
            .padding(6)
        }
        .rotationEffect(.degrees(rotation))
    }
}
