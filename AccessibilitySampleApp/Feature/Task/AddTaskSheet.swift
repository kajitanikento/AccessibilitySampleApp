import SwiftUI

// MARK: - AddTaskSheet

struct AddTaskSheet: View {
    @Binding var isPresented: Bool
    let onSave: (String, Priority, String) -> Void

    @State private var title = ""
    @State private var description = ""
    @State private var priority: Priority = .medium
    @State private var titleError: String? = nil
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        HStack {
                            Text("タスク名")
                                .font(DesignTokens.Font.bodySmallBold)
                            Text("必須")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityLabel("必須項目")
                        }
                        TextField("例: 牛乳を買う", text: $title)
                            .focused($isTitleFocused)
                            .accessibilityLabel("タスク名（必須）")
                            .accessibilityHint("タスクの名前を入力してください")
                            .onChange(of: title) { _ in titleError = nil }
                        if let error = titleError {
                            Label(error, systemImage: "exclamationmark.circle")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityLabel("エラー: \(error)")
                        }
                    }

                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        Text("説明")
                            .font(DesignTokens.Font.bodySmallBold)
                        TextField("例: 近所のスーパーで購入する", text: $description, axis: .vertical)
                            .lineLimit(3...6)
                            .accessibilityLabel("説明")
                            .accessibilityHint("タスクの詳細を入力してください（任意）")
                    }
                } header: {
                    Text("タスク情報")
                }

                Section {
                    Picker("優先度", selection: $priority) {
                        ForEach(Priority.allCases) { p in
                            Text(p.label).tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityLabel("優先度を選択")
                } header: {
                    Text("優先度")
                }
            }
            .navigationTitle("タスクを追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        save()
                    }
                    .accessibilityLabel("タスクを保存")
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isTitleFocused = true
            }
        }
    }

    private func save() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            titleError = "タスク名を入力してください"
            UIAccessibility.post(notification: .announcement, argument: "エラー: タスク名を入力してください")
            return
        }
        onSave(title.trimmingCharacters(in: .whitespaces), priority, description.trimmingCharacters(in: .whitespaces))
        isPresented = false
    }
}

