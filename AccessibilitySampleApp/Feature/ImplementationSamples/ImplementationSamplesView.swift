import SwiftUI

// MARK: - 実装サンプル メインリスト

struct ImplementationSamplesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DesignTokens.Spacing.base) {
                Text("SwiftUIでアクセシビリティを実装するための\nケーススタディ形式のサンプル集")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, DesignTokens.Spacing.base)
                    .padding(.top, DesignTokens.Spacing.base)

                ForEach(ImplementationSample.allCases, id: \.self) { sample in
                    sampleRow(for: sample)
                }
            }
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("実装サンプル")
        .background(DesignTokens.Color.background)
    }

    // MARK: - Row

    private func sampleRow(for sample: ImplementationSample) -> some View {
        NavigationLink(destination: sample.destination) {
            HStack(alignment: .top, spacing: 0) {
                HStack(alignment: .center, spacing: DesignTokens.Spacing.md) {
                    // アイコン
                    Image(systemName: sample.systemImage)
                        .font(.system(size: 20))
                        .foregroundStyle(DesignTokens.Color.primary)
                        .frame(width: 40, height: 40)
                        .background(DesignTokens.Color.primaryLight)
                        .clipShape(Circle())
                        .accessibilityHidden(true)

                    // テキスト
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        Text(sample.title)
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .multilineTextAlignment(.leading)

                        Text(sample.subtitle)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                            .multilineTextAlignment(.leading)

                        // WCAG クライテリアバッジ
                        HStack(spacing: DesignTokens.Spacing.xs) {
                            ForEach(sample.wcagCriteria, id: \.self) { criterion in
                                Text(criterion)
                                    .font(DesignTokens.Font.captionBold)
                                    .padding(.horizontal, DesignTokens.Spacing.xs)
                                    .padding(.vertical, 2)
                                    .background(DesignTokens.Color.primaryLight)
                                    .foregroundStyle(DesignTokens.Color.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                            }
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(DesignTokens.Font.captionBold)
                        .foregroundStyle(DesignTokens.Color.textDisabled)
                        .accessibilityHidden(true)
                }
                .padding(.leading, DesignTokens.Spacing.md)
                .padding(.trailing, DesignTokens.Spacing.base)
                .padding(.vertical, DesignTokens.Spacing.md)
            }
            .background(DesignTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg).stroke(DesignTokens.Color.border, lineWidth: 1))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, DesignTokens.Spacing.base)
        // ▼ 行全体を1つのVoiceOver要素として組み合わせる
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(sample.title)。\(sample.subtitle)。\(sample.wcagCriteria.joined(separator: "、"))")
        .accessibilityHint("ダブルタップでサンプルを表示")
    }
}

// MARK: - ImplementationSample

private enum ImplementationSample: CaseIterable {
    case textField
    case listAction
    case stateAnnouncement
    case sheetFocus
    case stepper
    case imageAltText
    case semanticGrouping

    var title: String {
        switch self {
        case .textField:         return "アクセシブルなテキストフィールド"
        case .listAction:        return "カスタムリストアクション"
        case .stateAnnouncement: return "状態変化のアナウンス"
        case .sheetFocus:        return "シートのフォーカス管理"
        case .stepper:           return "カスタムステッパー"
        case .imageAltText:      return "画像の代替テキスト"
        case .semanticGrouping:  return "見出しとグループ化"
        }
    }

    var subtitle: String {
        switch self {
        case .textField:         return "ラベル・ヒント・エラー・textContentType"
        case .listAction:        return "accessibilityElement + accessibilityAction"
        case .stateAnnouncement: return "UIAccessibility.post(.announcement)"
        case .sheetFocus:        return "@FocusState + onAppear 自動フォーカス"
        case .stepper:           return "accessibilityTraits(.adjustable) + スワイプ操作"
        case .imageAltText:      return "accessibilityHidden / accessibilityLabel"
        case .semanticGrouping:  return "isHeader トレイト + accessibilityElement(.combine)"
        }
    }

    var systemImage: String {
        switch self {
        case .textField:         return "textformat.abc"
        case .listAction:        return "list.bullet.rectangle"
        case .stateAnnouncement: return "bell.badge"
        case .sheetFocus:        return "arrow.up.right.square"
        case .stepper:           return "plusminus"
        case .imageAltText:      return "photo"
        case .semanticGrouping:  return "text.justify.left"
        }
    }

    var wcagCriteria: [String] {
        switch self {
        case .textField:         return ["1.3.1", "3.3.1", "3.3.2"]
        case .listAction:        return ["4.1.2", "2.5.1"]
        case .stateAnnouncement: return ["4.1.3", "1.3.1"]
        case .sheetFocus:        return ["2.4.3", "2.1.2"]
        case .stepper:           return ["4.1.2", "2.1.1"]
        case .imageAltText:      return ["1.1.1"]
        case .semanticGrouping:  return ["1.3.1", "2.4.6"]
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .textField:         TextFieldSampleView()
        case .listAction:        ListActionSampleView()
        case .stateAnnouncement: StateAnnouncementSampleView()
        case .sheetFocus:        SheetFocusSampleView()
        case .stepper:           StepperSampleView()
        case .imageAltText:      ImageAltTextSampleView()
        case .semanticGrouping:  SemanticGroupingSampleView()
        }
    }
}

#Preview {
    NavigationStack {
        ImplementationSamplesView()
    }
}
