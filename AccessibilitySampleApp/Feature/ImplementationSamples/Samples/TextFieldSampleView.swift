import SwiftUI
import UIKit

// MARK: - アクセシブルなテキストフィールド サンプル (WCAG 1.3.1, 3.3.1, 3.3.2)

struct TextFieldSampleView: View {
    @State private var taskName = ""
    @State private var email = ""
    @State private var taskNameError: String? = nil
    @State private var emailError: String? = nil

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
        .navigationTitle("アクセシブルなテキストフィールド")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Header

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(["WCAG 1.3.1", "WCAG 3.3.1", "WCAG 3.3.2"], id: \.self) { c in
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
            Text("ラベル・ヒント・エラー状態・textContentType を正しく設定してフォームをアクセシブルにする")
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

                // タスク名フィールド（必須）
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    // ▼ 可視ラベル（プレースホルダーとは別に必要）
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Text("タスク名")
                            .font(DesignTokens.Font.bodySmallBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Text("必須")
                            .font(DesignTokens.Font.captionBold)
                            .padding(.horizontal, DesignTokens.Spacing.xs)
                            .padding(.vertical, 2)
                            .background(DesignTokens.Color.danger.opacity(0.1))
                            .foregroundStyle(DesignTokens.Color.danger)
                            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                            .accessibilityLabel("必須入力")
                    }
                    TextField("例: 買い物リストを作成する", text: $taskName)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                .stroke(taskNameError != nil ? DesignTokens.Color.danger : DesignTokens.Color.border, lineWidth: taskNameError != nil ? 2 : 1)
                        )
                        // ▼ フィールドの目的を明示（ラベル + 必須を結合）
                        .accessibilityLabel("タスク名、必須")
                        .accessibilityHint("タスクのタイトルを入力してください")
                        // ▼ キーボード最適化
                        .textContentType(.none)
                        .keyboardType(.default)
                        .autocorrectionDisabled(false)
                    if let error = taskNameError {
                        HStack(spacing: DesignTokens.Spacing.xs) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityHidden(true)
                            Text(error)
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }

                // メールフィールド
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("メールアドレス")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    TextField("例: user@example.com", text: $email)
                        .font(DesignTokens.Font.body)
                        .padding(DesignTokens.Spacing.md)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                .stroke(emailError != nil ? DesignTokens.Color.danger : DesignTokens.Color.border, lineWidth: emailError != nil ? 2 : 1)
                        )
                        .accessibilityLabel("メールアドレス")
                        .accessibilityHint("半角英数字で入力してください")
                        // ▼ 入力目的を指定（iOS キーボードの自動補完に対応）
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    if let error = emailError {
                        HStack(spacing: DesignTokens.Spacing.xs) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityHidden(true)
                            Text(error)
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }

                // 送信ボタン
                DAButton("バリデーションを試す", style: .solidFill, size: .medium) {
                    validateForm()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(DesignTokens.Spacing.base)
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
            .padding(.horizontal, DesignTokens.Spacing.base)
        }
    }

    private func validateForm() {
        var hasError = false

        if taskName.trimmingCharacters(in: .whitespaces).isEmpty {
            taskNameError = "タスク名を入力してください"
            hasError = true
        } else {
            taskNameError = nil
        }

        if !email.isEmpty && !email.contains("@") {
            emailError = "正しいメールアドレスの形式で入力してください"
            hasError = true
        } else {
            emailError = nil
        }

        // ▼ VoiceOver にエラーの発生をアナウンス
        if hasError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIAccessibility.post(notification: .announcement, argument: "入力エラーがあります。エラー内容を確認してください")
            }
        } else {
            UIAccessibility.post(notification: .announcement, argument: "入力内容を確認しました")
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
                    modifier: ".accessibilityLabel(\"フィールド名、必須\")",
                    detail: "プレースホルダーはVoiceOverで読まれない場合がある。フィールドの目的と必須かどうかをlabelに含める"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".accessibilityHint(\"入力形式の説明\")",
                    detail: "ユーザーに入力形式（例: 半角英数字）を伝える。hintはlabelの後に読まれる"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: ".textContentType(.emailAddress)",
                    detail: "WCAG 1.3.5「入力目的の特定」。iOSのパスワードマネージャーやキーボード補完が機能する"
                )
                Divider().padding(.leading, DesignTokens.Spacing.base + 4)
                keyPoint(
                    modifier: "UIAccessibility.post(.announcement, ...)",
                    detail: "エラー発生時にVoiceOverへ通知。0.1秒の遅延を入れることでフォーカス移動後に読み上げられる"
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
                        Text("悪い例 — プレースホルダーのみ")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.dangerText)
                    }
                    Text("TextField(\"タスク名を入力\", text: $name)\n// VoiceOver: 「テキストフィールド」のみ\n// ラベルが消える・必須かどうか不明")
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
                        Text("良い例 — 可視ラベル + accessibilityLabel")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(DesignTokens.Color.success)
                    }
                    Text("Text(\"タスク名\")\nTextField(\"例: 買い物リスト\", text: $name)\n    .accessibilityLabel(\"タスク名、必須\")\n    .accessibilityHint(\"タスクのタイトルを入力\")")
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
        TextFieldSampleView()
    }
}
