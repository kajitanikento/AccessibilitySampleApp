import SwiftUI

// MARK: - 見出しとグループ化 サンプル (WCAG 1.3.1, 2.4.6)

struct SemanticGroupingSampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {

                // ヘッダーカード
                headerCard

                // ライブデモ
                demoSection

                // 実装のポイント
                keyPointsSection
            }
            .padding(.top, DesignTokens.Spacing.base)
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("見出しとグループ化")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 1.3.1", "WCAG 2.4.6"], id: \.self) { criterion in
                    Text(criterion)
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
            Text("見出しトレイト・要素グループ化・装飾非表示で VoiceOver のナビゲーションを改善する")
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

                // セクション見出し
                HStack(spacing: DesignTokens.Spacing.sm) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(DesignTokens.Color.primary)
                        .accessibilityHidden(true)
                    Text("おすすめ機能")
                        .font(DesignTokens.Font.heading4)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        // ▼ VoiceOver ロータの「見出し」で移動可能にする
                        .accessibilityAddTraits(.isHeader)
                }

                // グループ化された項目
                VStack(spacing: DesignTokens.Spacing.md) {
                    groupedFeatureRow(
                        icon: "checkmark.shield.fill",
                        title: "セキュリティ強化",
                        description: "生体認証・2段階認証に対応"
                    )
                    groupedFeatureRow(
                        icon: "bolt.fill",
                        title: "高速同期",
                        description: "バックグラウンドで自動同期"
                    )
                    groupedFeatureRow(
                        icon: "paintbrush.fill",
                        title: "カスタムテーマ",
                        description: "ダーク・ライト・システム設定に追従"
                    )
                }

                // 補足テキスト（VoiceOverには読まれない装飾）
                HStack(spacing: DesignTokens.Spacing.xs) {
                    Image(systemName: "info.circle")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textDisabled)
                        .accessibilityHidden(true)
                    Text("すべての機能はアップデートで追加されます")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textDisabled)
                        .accessibilityHidden(true)
                }
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    private func groupedFeatureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: DesignTokens.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(DesignTokens.Color.primary)
                .frame(width: 28, height: 28)
                // ▼ アイコンは装飾として非表示（タイトルで内容が伝わる）
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                Text(title)
                    .font(DesignTokens.Font.bodyBold)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                Text(description)
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }
        }
        // ▼ アイコン + タイトル + 説明を1つのVoiceOver要素に結合
        .accessibilityElement(children: .combine)
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
                    modifier: ".accessibilityAddTraits(.isHeader)",
                    detail: "セクション見出しに追加。VoiceOver のロータ「見出し」で画面内を素早く移動できるようになる"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityElement(children: .combine)",
                    detail: "アイコン + テキストなど複数要素を1つのVoiceOver要素にまとめる。不要なフォーカス移動を減らす"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityHidden(true)",
                    detail: "装飾アイコン・補足テキストなど視覚的な飾りはVoiceOverから隠す。情報は別の方法（テキスト）で伝える"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "accessibilityElement(children: .contain)",
                    detail: "グループ内の子要素を個別にフォーカス可能にしつつ、グループ全体もVoiceOver要素として認識させたい場合に使う"
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

#Preview {
    NavigationStack {
        SemanticGroupingSampleView()
    }
}
