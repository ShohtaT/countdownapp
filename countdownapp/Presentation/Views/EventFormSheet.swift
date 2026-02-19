import SwiftUI

struct EventFormSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State var formViewModel: EventFormViewModel

    var onSave: (String, Date, EventColor) -> Void
    var onUpdate: ((CountdownEvent) -> Void)?

    var body: some View {
        NavigationStack {
            Form {
                Section("タイトル") {
                    TextField("イベント名", text: $formViewModel.title)
                }

                Section("日時") {
                    DatePicker(
                        "ターゲット日時",
                        selection: $formViewModel.targetDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)
                }

                Section("カラー") {
                    ColorPickerGrid(selectedColor: $formViewModel.selectedColor)
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle(formViewModel.isEditing ? "イベントを編集" : "イベントを追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        if formViewModel.isEditing, let event = formViewModel.buildEvent() {
                            onUpdate?(event)
                        } else {
                            onSave(
                                formViewModel.title.trimmingCharacters(in: .whitespacesAndNewlines),
                                formViewModel.targetDate,
                                formViewModel.selectedColor
                            )
                        }
                        dismiss()
                    }
                    .disabled(!formViewModel.isValid)
                }
            }
        }
    }
}
