import SwiftUI

struct CountdownCardView: View {
    let event: CountdownEvent
    let now: Date
    var pinnedMemo: Memo?
    var onEdit: () -> Void
    var onMemo: () -> Void
    var onDelete: () -> Void

    static let defaultMessages = [
        "今日もお疲れ様！\n明日も頑張ってね🍵",
        "最近頑張ってるね！\n無理せずにね💪",
        "あなたのペースで\n大丈夫だよ🌱",
        "コツコツが\nいちばんの近道🐢",
        "よく頑張ってるよ！\n自分を褒めてあげて🌟",
        "深呼吸して\nまた一歩ずつ🌈",
        "未来の自分が\nきっと感謝するよ📖",
        "休むのも\n大事な努力だよ☕",
    ]

    static func defaultMessage(for event: CountdownEvent) -> String {
        let index = abs(event.id.hashValue) % defaultMessages.count
        return defaultMessages[index]
    }

    private var displayText: String {
        if let memo = pinnedMemo {
            return memo.body
        }
        return Self.defaultMessage(for: event)
    }

    private var timeRemaining: TimeRemaining {
        event.timeRemaining(from: now)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(event.targetDate, style: .date)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                CountdownTimerView(
                    timeRemaining: timeRemaining,
                    tintColor: event.color.color
                )
            }

            Spacer()
                .frame(height: 24)

            Button(action: onMemo) {
                ZStack(alignment: .top) {
                    Text(displayText)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .frame(width: 150, height: 150)
                        .padding(12)
                        .background(event.color.color.opacity(0.15))
                        .cornerRadius(4)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 1, y: 2)

                    Circle()
                        .fill(event.color.color)
                        .frame(width: 14, height: 14)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        .offset(y: -7)
                }
            }
            .buttonStyle(.plain)

            Spacer()

            HStack(spacing: 16) {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .font(.title3)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.bordered)

                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                        .font(.title3)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.bordered)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tint(event.color.color)
    }
}
