import SwiftUI

// MARK: - 画像の代替テキスト サンプル (WCAG 1.1.1)

struct ImageAltTextSampleView: View {
    @State private var showBadLabel = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {

                // ヘッダーカード
                headerCard

                // ライブデモ
                demoSection

                // 実装のポイント
                keyPointsSection

                // 悪い例 vs 良い例
                comparisonSection
            }
            .padding(.top, DesignTokens.Spacing.base)
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("画像の代替テキスト")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                Text("WCAG 1.1.1")
                    .font(DesignTokens.Font.captionBold)
                    .padding(.horizontal, DesignTokens.Spacing.xs)
                    .padding(.vertical, 3)
                    .background(DesignTokens.Color.primary.opacity(0.15))
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                    .accessibilityLabel("WCAG 1.1.1")
                Text("レベル A")
                    .font(DesignTokens.Font.captionBold)
                    .padding(.horizontal, DesignTokens.Spacing.xs)
                    .padding(.vertical, 3)
                    .background(DesignTokens.Color.primary.opacity(0.15))
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                    .accessibilityLabel("適合レベル A")
            }
            Text("飾り・情報・操作の3種類で適切な代替テキストを設定する")
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

            VStack(alignment: .leading, spacing: DesignTokens.Spacing.lg) {
                // 1. 装飾画像
                imageRow(
                    label: "① 装飾画像 — .accessibilityHidden(true)",
                    caption: "VoiceOver はスキップ"
                ) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 28))
                        .foregroundStyle(DesignTokens.Color.primary)
                        .accessibilityHidden(true)
                }

                Divider()

                // 2. 情報を伝える画像
                imageRow(
                    label: "② 情報画像 — .accessibilityLabel(\"説明\")",
                    caption: "VoiceOver: 「警告アイコン、レベルが危険です」"
                ) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(DesignTokens.Color.danger)
                        .accessibilityLabel("警告アイコン、レベルが危険です")
                }

                Divider()

                // 3. 操作ボタンの画像
                imageRow(
                    label: "③ 機能ボタン — ボタン自体に label",
                    caption: "VoiceOver: 「お気に入りに追加、ボタン」"
                ) {
                    Button {
                        // action
                    } label: {
                        Image(systemName: "heart")
                            .font(.system(size: 28))
                            .foregroundStyle(DesignTokens.Color.danger)
                    }
                    .accessibilityLabel("お気に入りに追加")
                    .frame(minWidth: DesignTokens.TouchTarget.minimum, minHeight: DesignTokens.TouchTarget.minimum)
                }
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    private func imageRow(label: String, caption: String, @ViewBuilder content: () -> some View) -> some View {
        HStack(alignment: .center, spacing: DesignTokens.Spacing.md) {
            content()
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                Text(label)
                    .font(DesignTokens.Font.bodySmallBold)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                Text(caption)
                    .font(DesignTokens.Font.caption)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }
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
                    modifier: ".accessibilityHidden(true)",
                    detail: "背景パターン・区切り線など、意味を持たない装飾画像に適用。VoiceOver フォーカスをスキップさせる"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityLabel(\"説明\")",
                    detail: "情報を伝える画像に適用。SF Symbols の自動読み上げ名は不正確な場合があるため明示的に指定する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "Button { } label: { Image(...) }",
                    detail: "操作可能な画像ボタンは Image に label を付けるのではなく Button の accessibilityLabel で説明する"
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
                // 悪い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                            .accessibilityHidden(true)
                        Text("悪い例 — SF Symbols の自動ラベル")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                    }
                    Text("Image(systemName: \"heart\")\n// VoiceOver: 「Heart」（英語のまま）")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.dangerSurface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.danger.opacity(0.4), lineWidth: 1))

                // 良い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.success)
                            .accessibilityHidden(true)
                        Text("良い例 — 明示的な日本語ラベル")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("Image(systemName: \"heart\")\n    .accessibilityLabel(\"お気に入りに追加\")\n// VoiceOver: 「お気に入りに追加」")
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
        ImageAltTextSampleView()
    }
}
