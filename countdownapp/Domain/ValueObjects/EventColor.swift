import SwiftUI

enum EventColor: String, CaseIterable, Codable, Identifiable {
    case blue, purple, pink, red, orange, green, teal, indigo

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .blue: .blue
        case .purple: .purple
        case .pink: .pink
        case .red: .red
        case .orange: .orange
        case .green: .green
        case .teal: .teal
        case .indigo: .indigo
        }
    }

    var displayName: String {
        switch self {
        case .blue: "ブルー"
        case .purple: "パープル"
        case .pink: "ピンク"
        case .red: "レッド"
        case .orange: "オレンジ"
        case .green: "グリーン"
        case .teal: "ティール"
        case .indigo: "インディゴ"
        }
    }
}
