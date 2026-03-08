import SwiftUI
import UIKit

// MARK: - カスタムリストアクション サンプル (WCAG 4.1.2, 2.5.1)

struct ListActionSampleView: View {
    struct ListItem: Identifiable {
        let id = UUID()
        var title: String
        var isCompleted: Bool
        var priority: String
    }

    @State private var items: [ListItem] = [
        ListItem(title: "週次レポートの作成", isCompleted: false, priority: "高"),
        ListItem(title: "チームミーティングの準備", isCompleted: false, priority: "中"),
        ListItem(title: "メールの返信", isCompleted: true, priority: "低"),
    ]
    @State private var lastAction: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {

                headerCard
                demoSection
                keyPointsSection
                comparisonSection
            }
            .padding(.top, DesignTokens.Spacing.base)
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("カスタムリストアクション")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 4.1.2", "WCAG 2.5.1"], id: \.self) { c in
                    Text(c)
                        .font(DesignTokens.Font.captionBold)
                        .padding(.horizontal, DesignTokens.Spacing.xs)
                        .padding(.vertical, 3)
                        .background(DesignTokens.Color.primary.opacity(0.15))
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                }
                Text("レベル A")
                    .font(DesignTokens.Font.captionBold)
                    .padding(.horizontal, DesignTokens.Spacing.xs)
                    .padding(.vertical, 3)
                    .background(DesignTokens.Color.primary.opacity(0.15))
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                    .accessibilityLabel("適合レベル A")
            }
            Text("複数ボタンを持つリスト行を1つのVoiceOver要素にまとめ、カスタムアクションで操作を提供する")
                .font(DesignTokens.Font.body)
                .foregroundStyle(DesignTokens.Color.textPrimary)
        }
        .padding(DesignTokens.Spacing.base)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
        .padding(.horizontal, DesignTokens.Spacing.base)
    }

    // MARK: - Demo

    private var demoSection: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.base) {
            Text("ライブデモ")
                .font(DesignTokens.Font.bodyBold)
                .foregroundStyle(DesignTokens.Color.textPrimary)
                .padding(.horizontal, DesignTokens.Spacing.base)
                .accessibilityAddTraits(.isHeader)

            VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
                // 操作ログ
                if !lastAction.isEmpty {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "info.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.primary)
                            .accessibilityHidden(true)
                        Text(lastAction)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.primary)
                    }
                    .padding(DesignTokens.Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(DesignTokens.Color.primaryLight)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("操作ログ: \(lastAction)")
                }

                ForEach(items) { item in
                    accessibleListRow(item: item)
                }
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    private func accessibleListRow(item: ListItem) -> some View {
        HStack(alignment: .center, spacing: DesignTokens.Spacing.md) {
            // チェックボックス
            Button {
                toggleItem(item)
            } label: {
                Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                    .font(.system(size: 20))
                    .foregroundStyle(item.isCompleted ? DesignTokens.Color.primary : DesignTokens.Color.border)
            }
            .frame(width: DesignTokens.TouchTarget.minimum, height: DesignTokens.TouchTarget.minimum)
            .accessibilityHidden(true) // ▼ 行全体のカスタムアクションで操作するため個別ボタンを非表示

            // テキスト
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                Text(item.title)
                    .font(DesignTokens.Font.bodyBold)
                    .foregroundStyle(item.isCompleted ? DesignTokens.Color.textDisabled : DesignTokens.Color.textPrimary)
                    .strikethrough(item.isCompleted)
                Text("優先度: \(item.priority)")
                    .font(DesignTokens.Font.caption)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }

            Spacer()

            // 削除ボタン（視覚的のみ、VoiceOverはカスタムアクションで操作）
            Button {
                deleteItem(item)
            } label: {
                Image(systemName: "trash")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.danger)
            }
            .frame(width: DesignTokens.TouchTarget.minimum, height: DesignTokens.TouchTarget.minimum)
            .accessibilityHidden(true) // ▼ カスタムアクションで代替
        }
        .padding(DesignTokens.Spacing.md)
        .background(DesignTokens.Color.background)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
        // ▼ 行全体を1つのVoiceOver要素として公開
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(item.title)
        .accessibilityValue("\(item.isCompleted ? "完了" : "未完了")、優先度 \(item.priority)")
        .accessibilityHint("スワイプで操作メニューを表示")
        // ▼ スワイプ操作の代替としてカスタムアクションを提供
        .accessibilityAction(named: item.isCompleted ? "未完了に戻す" : "完了にする") {
            toggleItem(item)
        }
        .accessibilityAction(named: "削除") {
            deleteItem(item)
        }
    }

    private func toggleItem(_ item: ListItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
            let state = items[index].isCompleted ? "完了" : "未完了"
            lastAction = "\(item.title) を\(state)に変更"
            UIAccessibility.post(notification: .announcement, argument: lastAction)
        }
    }

    private func deleteItem(_ item: ListItem) {
        items.removeAll { $0.id == item.id }
        lastAction = "\(item.title) を削除"
        UIAccessibility.post(notification: .announcement, argument: lastAction)
    }

    // MARK: - Key Points

    private var keyPointsSection: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.base) {
            Text("実装のポイント")
                .font(DesignTokens.Font.bodyBold)
                .foregroundStyle(DesignTokens.Color.textPrimary)
                .padding(.horizontal, DesignTokens.Spacing.base)
                .accessibilityAddTraits(.isHeader)

            VStack(alignment: .leading, spacing: 0) {
                keyPoint(
                    modifier: ".accessibilityElement(children: .ignore)",
                    detail: "子ビューのVoiceOverフォーカスを無効にし、親のHStackを1要素として扱う。labelとvalueで内容を記述"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityAction(named: \"完了にする\") { }",
                    detail: "VoiceOverのローカルコンテキストメニュー（3本指スワイプ）で操作を提供。スワイプ削除の代替として必須"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityValue(\"完了、優先度 高\")",
                    detail: "チェック状態・優先度などの動的な状態値をvalueで伝える。labelは変えずvalueを更新するのがベストプラクティス"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "子ボタンに .accessibilityHidden(true)",
                    detail: "行内の個別ボタンはVoiceOverから隠す。カスタムアクションで同等の操作を提供するため情報は失われない"
                )
            }
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    // MARK: - Comparison

    private var comparisonSection: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.base) {
            Text("悪い例 vs 良い例")
                .font(DesignTokens.Font.bodyBold)
                .foregroundStyle(DesignTokens.Color.textPrimary)
                .padding(.horizontal, DesignTokens.Spacing.base)
                .accessibilityAddTraits(.isHeader)

            VStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                            .accessibilityHidden(true)
                        Text("悪い例 — ボタンが個別フォーカス")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                    }
                    Text("HStack {\n  Button(\"完了\") { ... }  // ←フォーカス1\n  Text(\"タスク名\")          // ←フォーカス2\n  Button(\"削除\") { ... }  // ←フォーカス3\n}\n// VoiceOver: 3回スワイプが必要")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.dangerSurface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.danger.opacity(0.4), lineWidth: 1))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.success)
                            .accessibilityHidden(true)
                        Text("良い例 — 行全体が1要素 + カスタムアクション")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("HStack { ... }\n    .accessibilityElement(children: .ignore)\n    .accessibilityLabel(\"タスク名\")\n    .accessibilityValue(\"未完了、優先度 高\")\n    .accessibilityAction(named: \"完了にする\") { }\n    .accessibilityAction(named: \"削除\") { }")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.successSurface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.success.opacity(0.4), lineWidth: 1))
            }
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    // MARK: - Helper

    private func keyPoint(modifier: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle()
                .fill(DesignTokens.Color.primary)
                .frame(width: 4)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                Text(modifier)
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                    .foregroundStyle(DesignTokens.Color.primary)
                Text(detail)
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }
            .padding(.leading, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.md)
            .padding(.trailing, DesignTokens.Spacing.base)
        }
    }
}

#Preview {
    NavigationStack {
        ListActionSampleView()
    }
}
