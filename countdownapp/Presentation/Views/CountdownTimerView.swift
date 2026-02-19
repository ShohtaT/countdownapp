import SwiftUI

struct CountdownTimerView: View {
    let timeRemaining: TimeRemaining
    let tintColor: Color

    var body: some View {
        if timeRemaining.isExpired {
            Text("期限切れ")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
        } else {
            HStack(spacing: 12) {
                if timeRemaining.days > 0 {
                    timerUnit(value: timeRemaining.days, label: "日")
                }
                timerUnit(value: timeRemaining.hours, label: "時間")
                timerUnit(value: timeRemaining.minutes, label: "分")
                timerUnit(value: timeRemaining.seconds, label: "秒")
            }
        }
    }

    private func timerUnit(value: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
                .foregroundStyle(.primary)

            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(minWidth: 60)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}
