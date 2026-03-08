import SwiftUI

// MARK: - シートのフォーカス管理 サンプル (WCAG 2.4.3, 2.1.2)

struct SheetFocusSampleView: View {
    @State private var showCorrectSheet = false
    @State private var showIncorrectSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {

                headerCard
                demoSection
                keyPointsSection
            }
            .padding(.top, DesignTokens.Spacing.base)
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("シートのフォーカス管理")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
        .sheet(isPresented: $showCorrectSheet) {
            CorrectFocusSheet()
        }
        .sheet(isPresented: $showIncorrectSheet) {
            IncorrectFocusSheet()
        }
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 2.4.3", "WCAG 2.1.2"], id: \.self) { c in
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
            Text("シートを開いた際のVoiceOverフォーカスを最初の入力フィールドに自動移動させる")
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

            VStack(spacing: DesignTokens.Spacing.md) {
                // 良い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.success)
                            .accessibilityHidden(true)
                        Text("良い例 — 自動フォーカス")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("シートが開くと自動的に最初の入力フィールドにVoiceOverフォーカスが移動します")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                    DAButton("良い例のシートを開く", style: .solidFill, size: .medium) {
                        showCorrectSheet = true
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(DesignTokens.Spacing.md)
                .background(DesignTokens.Color.successSurface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                // 悪い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                            .accessibilityHidden(true)
                        Text("悪い例 — フォーカスなし")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                    }
                    Text("フォーカス指定なし。VoiceOverはシートのどこかランダムな要素からフォーカスを開始します")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                    DAButton("悪い例のシートを開く", style: .outlined, size: .medium) {
                        showIncorrectSheet = true
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(DesignTokens.Spacing.md)
                .background(DesignTokens.Color.dangerSurface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
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
                    modifier: "@FocusState private var focusedField: Field?",
                    detail: "フォーカス制御に @FocusState を使用。フィールドの種類をenum で管理する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".onAppear { DispatchQueue.main.asyncAfter(0.5) { } }",
                    detail: "シート表示後0.3〜0.5秒の遅延でフォーカスを設定。遅延なしだとシートのアニメーション完了前に実行されフォーカスが機能しない"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".focused($focusedField, equals: .title)",
                    detail: "特定のフィールドにフォーカスをバインド。focusedField = .title で該当フィールドにフォーカスが移動する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "ToolbarItem(placement: .cancellationAction)",
                    detail: "シートの閉じるボタンは cancellationAction 配置。VoiceOverユーザーがシートから抜け出せることを保証する（WCAG 2.1.2 キーボードトラップ防止）"
                )
            }
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
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

// MARK: - 良い例のシート（自動フォーカスあり）

private struct CorrectFocusSheet: View {
    enum Field { case title, description }

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var description = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.lg) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("タイトル")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    TextField("タスクのタイトル", text: $title)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border))
                        .accessibilityLabel("タイトル")
                        // ▼ @FocusState でフォーカスをバインド
                        .focused($focusedField, equals: .title)
                }

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("説明")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    TextField("任意の説明", text: $description)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border))
                        .accessibilityLabel("説明（任意）")
                        .focused($focusedField, equals: .description)
                }
                Spacer()
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.background)
            .navigationTitle("新しいタスク（良い例）")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") { dismiss() }
                        .accessibilityLabel("キャンセル、シートを閉じる")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") { dismiss() }
                        .accessibilityLabel("タスクを追加")
                }
            }
            // ▼ シート表示後に遅延を入れてフォーカスを最初のフィールドへ移動
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusedField = .title
                }
            }
        }
    }
}

// MARK: - 悪い例のシート（フォーカス指定なし）

private struct IncorrectFocusSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.lg) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("タイトル")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    TextField("タスクのタイトル", text: $title)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border))
                    // ▼ @FocusState も onAppear のフォーカス設定もなし
                }

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("説明")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    TextField("任意の説明", text: $description)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border))
                }
                Spacer()
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.background)
            .navigationTitle("新しいタスク（悪い例）")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SheetFocusSampleView()
    }
}
