import SwiftUI

struct CountdownCardView: View {
    let event: CountdownEvent
    let now: Date
    var onEdit: () -> Void
    var onDelete: () -> Void

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
