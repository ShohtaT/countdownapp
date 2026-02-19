import SwiftUI

struct CorkBoardView: View {
    @State var viewModel: CorkBoardViewModel

    private let corkColor = Color(red: 0.76, green: 0.60, blue: 0.42)
    private let woodColor = Color(red: 0.45, green: 0.30, blue: 0.18)

    var body: some View {
        ZStack {
            // Cork board background
            corkColor
                .ignoresSafeArea()
                .overlay(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.05),
                            .clear,
                            .black.opacity(0.08)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                )

            VStack(spacing: 0) {
                // Wood frame header
                HStack {
                    Text(viewModel.event.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(viewModel.memos.count) memos")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(woodColor)

                // Content area
                ScrollView {
                    VStack(spacing: 16) {
                        // Pinned memo (latest)
                        if let pinned = viewModel.pinnedMemo {
                            VStack(alignment: .leading, spacing: 4) {
                                Label("Pinned", systemImage: "pin.fill")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(woodColor)

                                MemoCardView(
                                    memo: pinned,
                                    isPinned: true,
                                    onDelete: {
                                        withAnimation {
                                            viewModel.deleteMemo(id: pinned.id)
                                        }
                                    }
                                )
                            }
                            .padding(.horizontal)
                            .padding(.top, 16)
                        }

                        // Past memos
                        if !viewModel.pastMemos.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Past Memos")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(woodColor)
                                    .padding(.horizontal)

                                ForEach(viewModel.pastMemos) { memo in
                                    MemoCardView(
                                        memo: memo,
                                        isPinned: false,
                                        onDelete: {
                                            withAnimation {
                                                viewModel.deleteMemo(id: memo.id)
                                            }
                                        }
                                    )
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 8)
                        }

                        if viewModel.memos.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "note.text")
                                    .font(.system(size: 40))
                                    .foregroundStyle(woodColor.opacity(0.5))
                                Text("No memos yet")
                                    .font(.subheadline)
                                    .foregroundStyle(woodColor.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        }
                    }
                    .padding(.bottom, 80)
                }

                // Input bar
                HStack(spacing: 8) {
                    TextField("Write a memo...", text: $viewModel.inputText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...3)

                    Button(action: {
                        withAnimation {
                            viewModel.addMemo()
                        }
                    }) {
                        Image(systemName: "pin.fill")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(
                                viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                    ? Color.red.opacity(0.4)
                                    : Color.red
                            )
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(woodColor)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadMemos()
        }
    }
}
