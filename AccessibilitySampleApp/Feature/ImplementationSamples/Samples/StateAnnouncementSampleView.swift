import SwiftUI
import UIKit

// MARK: - 状態変化のアナウンス サンプル (WCAG 4.1.3, 1.3.1)

struct StateAnnouncementSampleView: View {
    enum LoadState {
        case idle, loading, success, failure
    }

    @State private var loadState: LoadState = .idle
    @State private var withAnnouncement = true

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
        .navigationTitle("状態変化のアナウンス")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 4.1.3", "WCAG 1.3.1"], id: \.self) { c in
                    Text(c)
                        .font(DesignTokens.Font.captionBold)
                        .padding(.horizontal, DesignTokens.Spacing.xs)
                        .padding(.vertical, 3)
                        .background(DesignTokens.Color.primary.opacity(0.15))
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                }
                Text("レベル AA")
                    .font(DesignTokens.Font.captionBold)
                    .padding(.horizontal, DesignTokens.Spacing.xs)
                    .padding(.vertical, 3)
                    .background(DesignTokens.Color.primary.opacity(0.15))
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                    .accessibilityLabel("適合レベル AA")
            }
            Text("非同期処理の結果や状態変化を UIAccessibility.post でVoiceOverに通知する")
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

                // アナウンス有無の切り替え
                Toggle(isOn: $withAnnouncement) {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        Text("VoiceOver アナウンスあり")
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Text("OFFにすると視覚的な変化のみ（VoiceOverには通知されない）")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                }
                .tint(DesignTokens.Color.primary)
                .accessibilityLabel("VoiceOver アナウンス")
                .accessibilityHint(withAnnouncement ? "現在オン。タップで無効にする" : "現在オフ。タップで有効にする")

                Divider()

                // 状態表示エリア
                HStack(spacing: DesignTokens.Spacing.md) {
                    stateIcon
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        Text(stateTitle)
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Text(stateDescription)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                    Spacer()
                }
                .padding(DesignTokens.Spacing.md)
                .background(stateBackground)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                // ▼ 状態変化を accessibilityValue で表現
                .accessibilityElement(children: .combine)
                .accessibilityLabel("処理状態")
                .accessibilityValue(stateTitle)

                // 実行ボタン
                DAButton("データを取得する", style: .solidFill, size: .medium) {
                    simulateLoading()
                }
                .disabled(loadState == .loading)
                .frame(maxWidth: .infinity)
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    @ViewBuilder
    private var stateIcon: some View {
        switch loadState {
        case .idle:
            Image(systemName: "clock")
                .font(.system(size: 24))
                .foregroundStyle(DesignTokens.Color.textDisabled)
                // ▼ ローディング中はスピナーに .updatesFrequently トレイトを付ける
                .accessibilityHidden(true)
        case .loading:
            ProgressView()
                .scaleEffect(1.2)
                // ▼ 頻繁に更新される要素であることをVoiceOverに伝える
                .accessibilityLabel("データを取得中")
                .accessibilityAddTraits(.updatesFrequently)
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 24))
                .foregroundStyle(DesignTokens.Color.success)
                .accessibilityHidden(true)
        case .failure:
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 24))
                .foregroundStyle(DesignTokens.Color.danger)
                .accessibilityHidden(true)
        }
    }

    private var stateTitle: String {
        switch loadState {
        case .idle: return "待機中"
        case .loading: return "取得中..."
        case .success: return "取得成功"
        case .failure: return "取得失敗"
        }
    }

    private var stateDescription: String {
        switch loadState {
        case .idle: return "「データを取得する」をタップしてください"
        case .loading: return "サーバーからデータを取得しています"
        case .success: return "10件のデータを取得しました"
        case .failure: return "ネットワークエラーが発生しました"
        }
    }

    private var stateBackground: Color {
        switch loadState {
        case .idle: return DesignTokens.Color.background
        case .loading: return DesignTokens.Color.primaryLight
        case .success: return DesignTokens.Color.successSurface
        case .failure: return DesignTokens.Color.dangerSurface
        }
    }

    private func simulateLoading() {
        loadState = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let success = Bool.random()
            loadState = success ? .success : .failure

            // ▼ withAnnouncement ON の場合のみアナウンスを送出
            if withAnnouncement {
                let message = success ? "データを取得しました。10件" : "取得に失敗しました。ネットワークを確認してください"
                UIAccessibility.post(notification: .announcement, argument: message)
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
                    modifier: "UIAccessibility.post(.announcement, argument:)",
                    detail: "非同期処理の完了・エラーをVoiceOverへ通知。フォーカス移動なしで結果を読み上げさせる"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityAddTraits(.updatesFrequently)",
                    detail: "ProgressView やカウントダウンタイマーなど、頻繁に変化する要素に付与。VoiceOverが読み上げ頻度を調整する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityValue(stateString)",
                    detail: "状態を持つ要素（ローディング/成功/失敗）の現在値をVoiceOverに伝える。labelはラベル名、valueは現在の状態"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)",
                    detail: "アナウンス送出に短い遅延を入れることで、UI更新とVoiceOverの読み上げが競合しないようにする"
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
                        Text("悪い例 — 視覚的な変化のみ")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                    }
                    Text("isLoading = false\nresultText = \"取得しました\"\n// VoiceOverユーザーは結果に気づかない")
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
                        Text("良い例 — アナウンスで通知")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("isLoading = false\nresultText = \"取得しました\"\nUIAccessibility.post(\n    notification: .announcement,\n    argument: \"データを取得しました。10件\"\n)")
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
        StateAnnouncementSampleView()
    }
}
