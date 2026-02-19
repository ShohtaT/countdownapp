import SwiftUI

struct ColorPickerGrid: View {
    @Binding var selectedColor: EventColor

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(EventColor.allCases) { eventColor in
                Circle()
                    .fill(eventColor.color.gradient)
                    .frame(width: 44, height: 44)
                    .overlay {
                        if selectedColor == eventColor {
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                    .scaleEffect(selectedColor == eventColor ? 1.15 : 1.0)
                    .animation(.spring(duration: 0.3), value: selectedColor)
                    .onTapGesture {
                        selectedColor = eventColor
                    }
                    .accessibilityLabel(eventColor.displayName)
            }
        }
        .padding(.horizontal)
    }
}
