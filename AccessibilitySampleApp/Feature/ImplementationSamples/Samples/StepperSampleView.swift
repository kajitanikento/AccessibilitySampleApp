import SwiftUI
import UIKit

// MARK: - カスタムステッパー サンプル (WCAG 4.1.2, 2.1.1)

struct StepperSampleView: View {
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
        .navigationTitle("カスタムステッパー")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 4.1.2", "WCAG 2.1.1"], id: \.self) { c in
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
            Text("カスタム +/- コントロールに .adjustable トレイトと accessibilityAdjustableAction を実装してVoiceOverスワイプ操作に対応する")
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

            VStack(spacing: DesignTokens.Spacing.xl) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.success)
                            .accessibilityHidden(true)
                        Text("アクセシブルなステッパー")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("VoiceOver: 上スワイプで増加、下スワイプで減少")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                    AccessibleCounterView(label: "通知数", min: 0, max: 20, step: 1)
                }

                Divider()

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.success)
                            .accessibilityHidden(true)
                        Text("数量セレクター（範囲制限あり）")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("VoiceOver: 「数量、現在 1、上スワイプで増加」と読み上げ")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                    AccessibleCounterView(label: "数量", min: 1, max: 10, step: 1)
                }
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
                    modifier: ".accessibilityAddTraits(.isAdjustable)",
                    detail: "コンテナに付与。VoiceOverが「上スワイプで増加、下スワイプで減少」と案内するよう促す。このトレイトなしでは adjustableAction が機能しない"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityAdjustableAction { direction in }",
                    detail: "VoiceOver上スワイプ（.increment）と下スワイプ（.decrement）のコールバック。ここで実際の値を変更する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityValue(String(count))",
                    detail: "現在値をVoiceOverに伝える。VoiceOver: 「ラベル名、現在の値」と読み上げる"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "子ボタンに .accessibilityHidden(true)",
                    detail: "+ と - ボタンは視覚的操作のみ。VoiceOverユーザーはコンテナのスワイプ操作で値を変更するため非表示にする"
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

// MARK: - AccessibleCounterView

private struct AccessibleCounterView: View {
    let label: String
    let min: Int
    let max: Int
    let step: Int

    @State private var count: Int

    init(label: String, min: Int, max: Int, step: Int) {
        self.label = label
        self.min = min
        self.max = max
        self.step = step
        self._count = State(initialValue: min)
    }

    var body: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            Text(label)
                .font(DesignTokens.Font.bodyBold)
                .foregroundStyle(DesignTokens.Color.textPrimary)

            Spacer()

            HStack(spacing: 0) {
                // マイナスボタン（視覚的操作用）
                Button {
                    if count > min { count -= step }
                } label: {
                    Image(systemName: "minus")
                        .font(DesignTokens.Font.bodyBold)
                        .foregroundStyle(count <= min ? DesignTokens.Color.textDisabled : DesignTokens.Color.textPrimary)
                        .frame(width: DesignTokens.TouchTarget.minimum, height: DesignTokens.TouchTarget.minimum)
                }
                .disabled(count <= min)
                // ▼ VoiceOverからは非表示（コンテナのスワイプで操作）
                .accessibilityHidden(true)

                // 現在値表示
                Text("\(count)")
                    .font(DesignTokens.Font.bodyBold)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .frame(minWidth: 40)
                    .multilineTextAlignment(.center)
                    .accessibilityHidden(true)

                // プラスボタン（視覚的操作用）
                Button {
                    if count < max { count += step }
                } label: {
                    Image(systemName: "plus")
                        .font(DesignTokens.Font.bodyBold)
                        .foregroundStyle(count >= max ? DesignTokens.Color.textDisabled : DesignTokens.Color.textPrimary)
                        .frame(width: DesignTokens.TouchTarget.minimum, height: DesignTokens.TouchTarget.minimum)
                }
                .disabled(count >= max)
                .accessibilityHidden(true)
            }
            .background(DesignTokens.Color.background)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
            // ▼ コンテナ全体をadjustableコントロールとして公開
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(label)
            .accessibilityValue("\(count)")
            // ▼ accessibilityAdjustableAction を付けると adjustable トレイトが自動設定される
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    if count < max { count += step }
                case .decrement:
                    if count > min { count -= step }
                @unknown default:
                    break
                }
            }
        }
        .padding(.vertical, DesignTokens.Spacing.sm)
    }
}

#Preview {
    NavigationStack {
        StepperSampleView()
    }
}
