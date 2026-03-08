import SwiftUI

struct TaskDetailView: View {
    let task: TodoTask

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // タスク情報カード
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
                    // タイトル
                    Text(task.title)
                        .font(DesignTokens.Font.heading3)
                        .foregroundStyle(DesignTokens.Color.textPrimary)

                    // バッジ行
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        // 優先度バッジ（意味のある画像: accessibilityLabel付き）
                        Text("優先度 \(task.priority.label)")
                            .font(DesignTokens.Font.captionBold)
                            .padding(.horizontal, DesignTokens.Spacing.sm)
                            .padding(.vertical, DesignTokens.Spacing.xs)
                            .background(task.priority.backgroundColor)
                            .foregroundStyle(task.priority.foregroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                            .accessibilityLabel("優先度 \(task.priority.label)")

                        // 完了状態バッジ
                        if task.completed {
                            Label("完了", systemImage: "checkmark")
                                .font(DesignTokens.Font.captionBold)
                                .padding(.horizontal, DesignTokens.Spacing.sm)
                                .padding(.vertical, DesignTokens.Spacing.xs)
                                .background(DesignTokens.Color.successSurface)
                                .foregroundStyle(DesignTokens.Color.success)
                                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                                .accessibilityLabel("完了済み")
                        } else {
                            Text("未完了")
                                .font(DesignTokens.Font.captionBold)
                                .padding(.horizontal, DesignTokens.Spacing.sm)
                                .padding(.vertical, DesignTokens.Spacing.xs)
                                .background(DesignTokens.Color.background)
                                .foregroundStyle(DesignTokens.Color.textSecondary)
                                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                                .accessibilityLabel("未完了")
                        }
                    }

                    Divider()

                    // 説明
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        Text("説明")
                            .font(DesignTokens.Font.bodySmallBold)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                        Text(task.description.isEmpty ? "説明なし" : task.description)
                            .font(DesignTokens.Font.body)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                }
                .padding(DesignTokens.Spacing.base)
                .background(DesignTokens.Color.surface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
                .padding(.horizontal, DesignTokens.Spacing.base)
                .padding(.top, DesignTokens.Spacing.base)
            }
        }
        .navigationTitle("タスク詳細")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }
}

private struct InfoRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: DesignTokens.Spacing.xs) {
            Circle()
                .fill(DesignTokens.Color.primary)
                .frame(width: 5, height: 5)
                .padding(.top, 6)
                .accessibilityHidden(true)
            Text(text)
                .font(DesignTokens.Font.bodySmall)
                .foregroundStyle(DesignTokens.Color.primary)
        }
    }
}
