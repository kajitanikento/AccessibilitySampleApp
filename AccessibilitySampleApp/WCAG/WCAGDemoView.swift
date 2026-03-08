import SwiftUI
import UIKit

// MARK: - WCAGCriterion

enum WCAGCriterion: String {
    // 1. 知覚可能
    case nonTextContent         = "1.1.1"
    case audioOnlyVideoOnly     = "1.2.1"
    case captionsPrerecorded    = "1.2.2"
    case audioDescription       = "1.2.3"
    case infoAndRelationships   = "1.3.1"
    case meaningfulSequence     = "1.3.2"
    case sensoryCharacteristics = "1.3.3"
    case orientation            = "1.3.4"
    case identifyInputPurpose   = "1.3.5"
    case useOfColor             = "1.4.1"
    case contrastMinimum        = "1.4.3"
    case resizeText             = "1.4.4"
    case reflow                 = "1.4.10"
    case nonTextContrast        = "1.4.11"
    // 2. 操作可能
    case keyboard               = "2.1.1"
    case noKeyboardTrap         = "2.1.2"
    case timingAdjustable       = "2.2.1"
    case bypassBlocks           = "2.4.1"
    case pageTitled             = "2.4.2"
    case focusOrder             = "2.4.3"
    case linkPurpose            = "2.4.4"
    case headingsAndLabels      = "2.4.6"
    case pointerGestures        = "2.5.1"
    case pointerCancellation    = "2.5.2"
    case labelInName            = "2.5.3"
    case draggingMovements      = "2.5.7"
    // 3. 理解可能
    case languageOfPage         = "3.1.1"
    case onFocus                = "3.2.1"
    case onInput                = "3.2.2"
    case consistentNavigation   = "3.2.3"
    case consistentIdentification = "3.2.4"
    case errorIdentification    = "3.3.1"
    case labelsOrInstructions   = "3.3.2"
    case errorSuggestion        = "3.3.3"
    // 4. 堅牢
    case nameRoleValue          = "4.1.2"
}

struct WCAGDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DesignTokens.Spacing.xl) {
                Text("WCAG 2.2 A/AA レベル対応")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, DesignTokens.Spacing.base)
                    .padding(.horizontal, DesignTokens.Spacing.base)

                // 1. 知覚可能
                WCAGSectionCard(
                    number: "1",
                    title: "知覚可能",
                    englishTitle: "Perceivable",
                    description: "情報やUIは様々な方法で知覚できる必要がある",
                    iconName: "eye",
                    accentColor: DesignTokens.Color.primary
                ) {
                    WCAGItemRow(id: .nonTextContent, title: "非テキストコンテンツ", level: "A", accent: DesignTokens.Color.primary,
                                description: "非テキストコンテンツには意味を伝える代替テキストを提供する")
                    WCAGItemRow(id: .audioOnlyVideoOnly, title: "音声のみ・映像のみ（収録済み）", level: "A", accent: DesignTokens.Color.primary,
                                description: "音声のみまたは映像のみのコンテンツには代替手段を提供する")
                    WCAGItemRow(id: .captionsPrerecorded, title: "キャプション（収録済み）", level: "A", accent: DesignTokens.Color.primary,
                                description: "動画にはキャプションを提供する")
                    WCAGItemRow(id: .audioDescription, title: "音声解説または代替メディア（収録済み）", level: "A", accent: DesignTokens.Color.primary,
                                description: "動画の視覚情報を説明する代替手段を提供する")
                    WCAGItemRow(id: .infoAndRelationships, title: "情報及び関係性", level: "A", accent: DesignTokens.Color.primary,
                                description: "見出し、ラベル、グループなどの構造がプログラム的に識別できる必要がある")
                    WCAGItemRow(id: .meaningfulSequence, title: "意味のある順序", level: "A", accent: DesignTokens.Color.primary,
                                description: "コンテンツの順序が意味を保つ必要がある")
                    WCAGItemRow(id: .sensoryCharacteristics, title: "感覚的な特徴", level: "A", accent: DesignTokens.Color.primary,
                                description: "形、色、位置などの感覚情報だけで説明してはいけない")
                    WCAGItemRow(id: .orientation, title: "画面の向き", level: "AA", accent: DesignTokens.Color.primary,
                                description: "画面の向きに依存しないUIにする")
                    WCAGItemRow(id: .identifyInputPurpose, title: "入力目的の特定", level: "AA", accent: DesignTokens.Color.primary,
                                description: "入力フィールドの目的をプログラム的に識別できる必要がある")
                    WCAGItemRow(id: .useOfColor, title: "色の使用", level: "A", accent: DesignTokens.Color.primary,
                                description: "色だけに依存して情報を伝えてはいけない")
                    WCAGItemRow(id: .contrastMinimum, title: "コントラスト（最低限）", level: "AA", accent: DesignTokens.Color.primary,
                                description: "テキストと背景のコントラストを確保する（4.5:1以上）")
                    WCAGItemRow(id: .resizeText, title: "テキストのサイズ変更", level: "AA", accent: DesignTokens.Color.primary,
                                description: "テキストを拡大しても情報が失われない（Dynamic Type対応）")
                    WCAGItemRow(id: .reflow, title: "リフロー", level: "AA", accent: DesignTokens.Color.primary,
                                description: "小さい画面でもコンテンツが適切に再配置される")
                    WCAGItemRow(id: .nonTextContrast, title: "非テキストコントラスト", level: "AA", accent: DesignTokens.Color.primary,
                                description: "UIコンポーネントにも十分なコントラストが必要")
                }

                // 2. 操作可能
                WCAGSectionCard(
                    number: "2",
                    title: "操作可能",
                    englishTitle: "Operable",
                    description: "UIは様々な入力方法で操作可能である必要がある",
                    iconName: "hand.tap",
                    accentColor: DesignTokens.Color.success
                ) {
                    WCAGItemRow(id: .keyboard, title: "キーボード", level: "A", accent: DesignTokens.Color.success,
                                description: "すべての機能はキーボード操作可能である必要がある")
                    WCAGItemRow(id: .noKeyboardTrap, title: "キーボードトラップなし", level: "A", accent: DesignTokens.Color.success,
                                description: "キーボード操作が特定の要素に閉じ込められてはいけない")
                    WCAGItemRow(id: .timingAdjustable, title: "タイミング調整可能", level: "A", accent: DesignTokens.Color.success,
                                description: "時間制限がある場合は調整可能である必要がある")
                    WCAGItemRow(id: .bypassBlocks, title: "ブロックのスキップ", level: "A", accent: DesignTokens.Color.success,
                                description: "繰り返しコンテンツをスキップできる必要がある")
                    WCAGItemRow(id: .pageTitled, title: "ページタイトル", level: "A", accent: DesignTokens.Color.success,
                                description: "ページには適切なタイトルを付ける")
                    WCAGItemRow(id: .focusOrder, title: "フォーカス順序", level: "A", accent: DesignTokens.Color.success,
                                description: "フォーカス移動は意味のある順序である必要がある")
                    WCAGItemRow(id: .linkPurpose, title: "リンクの目的", level: "A", accent: DesignTokens.Color.success,
                                description: "リンクやボタンの目的が理解できる必要がある")
                    WCAGItemRow(id: .headingsAndLabels, title: "見出しとラベル", level: "AA", accent: DesignTokens.Color.success,
                                description: "見出しやラベルは内容を説明する必要がある")
                    WCAGItemRow(id: .pointerGestures, title: "ポインタジェスチャー", level: "A", accent: DesignTokens.Color.success,
                                description: "複雑なジェスチャーには単純な代替操作を提供する")
                    WCAGItemRow(id: .pointerCancellation, title: "ポインタキャンセル", level: "A", accent: DesignTokens.Color.success,
                                description: "誤操作を防ぐ設計が必要")
                    WCAGItemRow(id: .labelInName, title: "ラベルを名前に含める", level: "A", accent: DesignTokens.Color.success,
                                description: "視覚ラベルとアクセシビリティ名を一致させる")
                    WCAGItemRow(id: .draggingMovements, title: "ドラッグ操作", level: "AA", accent: DesignTokens.Color.success,
                                description: "ドラッグ操作には代替手段を提供する")
                }

                // 3. 理解可能（紫: デザインシステムトークン外のため hex 維持）
                WCAGSectionCard(
                    number: "3",
                    title: "理解可能",
                    englishTitle: "Understandable",
                    description: "UIや情報は理解しやすく予測可能である必要がある",
                    iconName: "brain",
                    accentColor: Color(hex: "#ad46ff")
                ) {
                    WCAGItemRow(id: .languageOfPage, title: "ページの言語", level: "A", accent: Color(hex: "#ad46ff"),
                                description: "ページの言語を明示する")
                    WCAGItemRow(id: .onFocus, title: "フォーカス時", level: "A", accent: Color(hex: "#ad46ff"),
                                description: "フォーカスだけで予期しない変更を起こさない")
                    WCAGItemRow(id: .onInput, title: "入力時", level: "A", accent: Color(hex: "#ad46ff"),
                                description: "入力によって予期しない変更を起こさない")
                    WCAGItemRow(id: .consistentNavigation, title: "一貫したナビゲーション", level: "AA", accent: Color(hex: "#ad46ff"),
                                description: "ナビゲーションは一貫している必要がある")
                    WCAGItemRow(id: .consistentIdentification, title: "一貫した識別", level: "AA", accent: Color(hex: "#ad46ff"),
                                description: "同じ機能は同じ方法で識別できる必要がある")
                    WCAGItemRow(id: .errorIdentification, title: "エラーの特定", level: "A", accent: Color(hex: "#ad46ff"),
                                description: "エラーは明確に通知する")
                    WCAGItemRow(id: .labelsOrInstructions, title: "ラベルや説明", level: "A", accent: Color(hex: "#ad46ff"),
                                description: "入力にラベルや説明を提供する")
                    WCAGItemRow(id: .errorSuggestion, title: "エラーの修正提案", level: "AA", accent: Color(hex: "#ad46ff"),
                                description: "エラーの修正方法を提示する")
                }

                // 4. 堅牢（オレンジ: デザインシステムトークン外のため hex 維持）
                WCAGSectionCard(
                    number: "4",
                    title: "堅牢",
                    englishTitle: "Robust",
                    description: "コンテンツは支援技術で解釈可能である必要がある",
                    iconName: "chevron.left.forwardslash.chevron.right",
                    accentColor: Color(hex: "#ff6900")
                ) {
                    WCAGItemRow(id: .nameRoleValue, title: "名前・役割・値", level: "A", accent: Color(hex: "#ff6900"),
                                description: "UI要素には適切な名前、役割、状態を提供する")
                }
            }
            .padding(.bottom, DesignTokens.Spacing.xl)
        }
        .navigationTitle("WCAGデモ")
        .background(DesignTokens.Color.background)
    }
}

// MARK: - WCAGItemRow

private struct WCAGItemRow: View {
    let id: WCAGCriterion
    let title: String
    let level: String
    let accent: Color
    let description: String

    var body: some View {
        NavigationLink {
            WCAGItemDetailView(id: id, title: title, level: level, description: description, accent: accent)
        } label: {
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(accent)
                    .frame(width: 4)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    HStack(alignment: .top) {
                        Text("\(id.rawValue) \(title)")
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        HStack(spacing: DesignTokens.Spacing.xs) {
                            Text(level)
                                .font(DesignTokens.Font.captionBold)
                                .padding(.horizontal, DesignTokens.Spacing.xs)
                                .padding(.vertical, 3)
                                .background(accent.opacity(0.15))
                                .foregroundStyle(accent)
                                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                                .accessibilityLabel("適合レベル \(level)")
                            Image(systemName: "chevron.right")
                                .font(DesignTokens.Font.captionBold)
                                .foregroundStyle(DesignTokens.Color.textDisabled)
                                .accessibilityHidden(true)
                        }
                    }
                    Text(description)
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, DesignTokens.Spacing.md)
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(id.rawValue) \(title)、適合レベル \(level)、\(description)")
        .accessibilityHint("ダブルタップで詳細とデモを表示")
    }
}

// MARK: - WCAGItemDetailView

private struct WCAGItemDetailView: View {
    let id: WCAGCriterion
    let title: String
    let level: String
    let description: String
    let accent: Color

    @State private var isLargeText = false
    @State private var isTranscriptVisible = false
    @State private var isCaptionVisible = true
    @State private var isAudioDescriptionVisible = false
    @State private var timerSeconds = 30
    @State private var isTimerRunning = false
    @State private var demoItems: [String] = ["タスク A", "タスク B", "タスク C"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {
                // ヘッダー
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Text("成功基準 \(id.rawValue)")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                        Text(level)
                            .font(DesignTokens.Font.captionBold)
                            .padding(.horizontal, DesignTokens.Spacing.xs)
                            .padding(.vertical, 3)
                            .background(accent.opacity(0.15))
                            .foregroundStyle(accent)
                            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                            .accessibilityLabel("適合レベル \(level)")
                        Spacer()
                    }
                    Text(description)
                        .font(DesignTokens.Font.body)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.base)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.surface)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.Radius.lg)
                        .stroke(DesignTokens.Color.border, lineWidth: 1)
                )
                .padding(.horizontal, DesignTokens.Spacing.base)

                // デモセクション
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.base) {
                    Text("デモ")
                        .font(DesignTokens.Font.bodyBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .padding(.horizontal, DesignTokens.Spacing.base)
                        .accessibilityAddTraits(.isHeader)

                    demoContent
                        .padding(.horizontal, DesignTokens.Spacing.base)
                }
            }
            .padding(.top, DesignTokens.Spacing.base)
            .padding(.bottom, DesignTokens.Spacing.xxxl)
        }
        .navigationTitle("\(id.rawValue) \(title)")
        .navigationBarTitleDisplayMode(.inline)
        .background(DesignTokens.Color.background)
    }

    // MARK: - Demo Content
    // デモコンテンツ内の特定の色はWCAGの教育目的のため維持

    @ViewBuilder
    private var demoContent: some View {
        switch id {
        case .nonTextContent:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: "意味のある画像（良い例）") {
                    HStack(spacing: DesignTokens.Spacing.md) {
                        ZStack {
                            RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                .fill(DesignTokens.Color.danger)
                                .frame(width: 48, height: 48)
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(DesignTokens.Color.textOnPrimary)
                        }
                        .accessibilityLabel("優先度が高いことを示す警告アイコン")

                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                            Text("優先度: 高")
                                .font(DesignTokens.Font.bodySmallBold)
                                .foregroundStyle(DesignTokens.Color.textPrimary)
                            Text("accessibilityLabel で代替テキストを提供")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.textSecondary)
                        }
                    }
                }

                FigmaDemoBox(label: "装飾画像（良い例）") {
                    HStack(spacing: DesignTokens.Spacing.md) {
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "#51a2ff"), Color(hex: "#ad46ff")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 48, height: 48)
                            .accessibilityHidden(true)

                        Text("accessibilityHidden(true) で読み上げから除外")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                }
            }

        case .meaningfulSequence:
            FigmaDemoBox(label: "読み上げ順序の例:") {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    ForEach(Array(["見出し", "本文", "ボタン"].enumerated()), id: \.offset) { i, text in
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            ZStack {
                                Circle()
                                    .fill(DesignTokens.Color.primaryLight)
                                    .frame(width: 24, height: 24)
                                Text("\(i + 1)")
                                    .font(DesignTokens.Font.captionBold)
                                    .foregroundStyle(DesignTokens.Color.primary)
                            }
                            .accessibilityHidden(true)
                            Text(text)
                                .font(DesignTokens.Font.bodySmall)
                                .foregroundStyle(DesignTokens.Color.textPrimary)
                        }
                    }
                }
            }

        case .useOfColor:
            // コントラスト比デモ: 教育目的のため特定色を維持
            HStack(spacing: DesignTokens.Spacing.md) {
                // 悪い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Circle().fill(Color(hex: "#fb2c36")).frame(width: 12, height: 12)
                                .accessibilityHidden(true)
                            Text("エラー").font(DesignTokens.Font.caption).foregroundStyle(DesignTokens.Color.textPrimary)
                        }
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Circle().fill(Color(hex: "#00c950")).frame(width: 12, height: 12)
                                .accessibilityHidden(true)
                            Text("成功").font(DesignTokens.Font.caption).foregroundStyle(DesignTokens.Color.textPrimary)
                        }
                    }
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                // 良い例
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 10))
                                .foregroundStyle(Color(hex: "#fb2c36"))
                                .accessibilityHidden(true)
                            Text("エラー").font(DesignTokens.Font.caption).foregroundStyle(DesignTokens.Color.textPrimary)
                        }
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 10))
                                .foregroundStyle(Color(hex: "#00c950"))
                                .accessibilityHidden(true)
                            Text("成功").font(DesignTokens.Font.caption).foregroundStyle(DesignTokens.Color.textPrimary)
                        }
                    }
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .contrastMinimum:
            // コントラスト比デモ: 意図的な低コントラスト色は維持
            VStack(spacing: DesignTokens.Spacing.sm) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("コントラスト不足（NG）")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(Color(hex: "#99a1af"))
                    Text("コントラスト比 3:1（不十分）")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(Color(hex: "#6a7282"))
                }
                .padding(.horizontal, DesignTokens.Spacing.md)
                .padding(.vertical, DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.background)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("適切なコントラスト（OK）")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    Text("コントラスト比 7:1（十分）")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                .padding(.horizontal, DesignTokens.Spacing.md)
                .padding(.vertical, DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.background)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .resizeText:
            VStack(spacing: DesignTokens.Spacing.md) {
                HStack {
                    Text("大きいテキスト")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    Spacer()
                    Toggle("", isOn: $isLargeText)
                        .labelsHidden()
                        .accessibilityLabel("大きいテキストの切り替え")
                }

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    Text("サンプルテキスト")
                        .font(isLargeText ? DesignTokens.Font.heading4 : DesignTokens.Font.bodyBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    Text("このテキストは、設定に応じてサイズが変わります。 レイアウトが崩れないように柔軟な設計が重要です。")
                        .font(isLargeText ? DesignTokens.Font.body : DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                .padding(DesignTokens.Spacing.base)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.Color.background)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .keyboard:
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                HStack(spacing: DesignTokens.Spacing.sm) {
                    Text("ボタン1")
                        .font(DesignTokens.Font.buttonSmall)
                        .foregroundStyle(DesignTokens.Color.textOnPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(DesignTokens.Color.textPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .accessibilityHint("Tabキーでフォーカス移動、Enterで実行")

                    Text("ボタン2")
                        .font(DesignTokens.Font.buttonSmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
                }
                Text("Tabキーでフォーカス移動、Enterで実行")
                    .font(DesignTokens.Font.caption)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }

        case .pageTitled:
            FigmaDemoBox(label: "この画面のタイトル設定") {
                Text(".navigationTitle(\"WCAGデモ\")")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }

        case .focusOrder:
            FigmaDemoBox(label: nil) {
                Text("タスク画面でのPush遷移で確認可能")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
            }

        case .draggingMovements:
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                ForEach(Array(demoItems.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(DesignTokens.Color.textDisabled)
                            .accessibilityHidden(true)
                        Text(item)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            guard index > 0 else { return }
                            demoItems.swapAt(index, index - 1)
                        } label: {
                            Image(systemName: "chevron.up")
                                .font(DesignTokens.Font.captionBold)
                                .foregroundStyle(index > 0 ? DesignTokens.Color.textPrimary : DesignTokens.Color.textDisabled)
                                .frame(width: 36, height: 36)
                        }
                        .disabled(index == 0)
                        .accessibilityLabel("\(item)を上へ移動")
                        Button {
                            guard index < demoItems.count - 1 else { return }
                            demoItems.swapAt(index, index + 1)
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(DesignTokens.Font.captionBold)
                                .foregroundStyle(index < demoItems.count - 1 ? DesignTokens.Color.textPrimary : DesignTokens.Color.textDisabled)
                                .frame(width: 36, height: 36)
                        }
                        .disabled(index == demoItems.count - 1)
                        .accessibilityLabel("\(item)を下へ移動")
                    }
                    .padding(.horizontal, DesignTokens.Spacing.md)
                    .padding(.vertical, DesignTokens.Spacing.sm)
                    .background(DesignTokens.Color.surface)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
                }
                Text("ドラッグ操作の代替として上下ボタンで並び替えを提供")
                    .font(DesignTokens.Font.caption)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }

        case .consistentNavigation:
            FigmaDemoBox(label: nil) {
                Text("ボトムタブは全画面で同じ位置・順序で表示")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
            }

        case .errorIdentification:
            HStack(alignment: .top, spacing: DesignTokens.Spacing.sm) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.danger)
                    .padding(.top, 2)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("タスク名を入力してください")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.dangerText)
                    Text("accessibilityLabel と role: .alert で通知")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.danger)
                }
            }
            .padding(DesignTokens.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(DesignTokens.Color.dangerSurface)
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.danger.opacity(0.4), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

        case .errorSuggestion:
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
                Text("通信に失敗しました")
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
                Text("再試行")
                    .font(DesignTokens.Font.buttonSmall)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
                    .frame(width: 68, height: 36)
                    .background(DesignTokens.Color.surface)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
                    .accessibilityHidden(true)
            }
            .padding(DesignTokens.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(DesignTokens.Color.warningSurface)
            .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.warning.opacity(0.5), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

        case .nameRoleValue:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaCodeBox(label: "accessibilityLabel（ラベル）",
                             code: ".accessibilityLabel(\"タスク「牛乳を買う」を削除\")")
                FigmaCodeBox(label: "accessibilityValue（値）",
                             code: ".accessibilityValue(\"完了\")")
                FigmaCodeBox(label: "accessibilityHint（ヒント）",
                             code: ".accessibilityHint(\"ダブルタップで削除します\")")
                FigmaCodeBox(label: "accessibilityAddTraits（役割）",
                             code: ".accessibilityAddTraits(.isHeader)")
            }

        // MARK: - 1.2.x メディア代替手段

        case .audioOnlyVideoOnly:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: "音声のみコンテンツの例") {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                        HStack(spacing: DesignTokens.Spacing.md) {
                            ZStack {
                                RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                    .fill(DesignTokens.Color.primaryLight)
                                    .frame(width: 52, height: 52)
                                Image(systemName: "waveform")
                                    .font(.system(size: 22))
                                    .foregroundStyle(DesignTokens.Color.primary)
                            }
                            .accessibilityHidden(true)
                            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                                Text("週次レポート音声版")
                                    .font(DesignTokens.Font.bodySmallBold)
                                    .foregroundStyle(DesignTokens.Color.textPrimary)
                                Text("3分42秒")
                                    .font(DesignTokens.Font.caption)
                                    .foregroundStyle(DesignTokens.Color.textSecondary)
                            }
                        }
                        Toggle("トランスクリプトを表示", isOn: $isTranscriptVisible)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .accessibilityLabel("テキストトランスクリプトの表示切り替え")
                    }
                }
                if isTranscriptVisible {
                    FigmaDemoBox(label: "テキストトランスクリプト（代替手段）") {
                        Text("「今週の売上は先週比 12% 増加しました。主な要因は新規顧客の獲得です」")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                }
            }

        case .captionsPrerecorded:
            FigmaDemoBox(label: nil) {
                VStack(spacing: DesignTokens.Spacing.sm) {
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                            .fill(Color(hex: "#1a1a2e")) // 教育目的: 動画プレーヤー背景色
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .overlay(
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white.opacity(0.8))
                            )
                            .accessibilityHidden(true)
                        if isCaptionVisible {
                            Text("「アクセシビリティは全ての人に必要です」")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(.white)
                                .padding(.horizontal, DesignTokens.Spacing.sm)
                                .padding(.vertical, DesignTokens.Spacing.xs)
                                .background(Color.black.opacity(0.75))
                                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                                .padding(.bottom, DesignTokens.Spacing.sm)
                                .accessibilityLabel("キャプション: アクセシビリティは全ての人に必要です")
                        }
                    }
                    Toggle("キャプションを表示", isOn: $isCaptionVisible)
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .accessibilityLabel("キャプションの表示切り替え")
                }
            }

        case .audioDescription:
            FigmaDemoBox(label: nil) {
                VStack(spacing: DesignTokens.Spacing.sm) {
                    ZStack {
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                            .fill(Color(hex: "#1a1a2e")) // 教育目的: 動画プレーヤー背景色
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .overlay(
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white.opacity(0.8))
                            )
                            .accessibilityHidden(true)
                    }
                    HStack {
                        Image(systemName: isAudioDescriptionVisible ? "speaker.wave.2.fill" : "speaker.slash.fill")
                            .foregroundStyle(isAudioDescriptionVisible ? DesignTokens.Color.primary : DesignTokens.Color.textDisabled)
                            .accessibilityHidden(true)
                        Toggle("音声解説", isOn: $isAudioDescriptionVisible)
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .accessibilityLabel("音声解説の切り替え")
                    }
                    if isAudioDescriptionVisible {
                        Text("「画面には青いバナーが表示されており、左側にサービスのロゴ、右側にナビゲーションメニューがあります」")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

        // MARK: - 1.3.x 適応可能

        case .infoAndRelationships:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaCodeBox(label: "見出しとして識別する",
                             code: "Text(\"セクション名\")\n    .font(DesignTokens.Font.heading4)\n    .accessibilityAddTraits(.isHeader)")
                FigmaCodeBox(label: "関連要素をグループ化する",
                             code: "HStack { icon; title; date }\n    .accessibilityElement(children: .combine)\n    .accessibilityLabel(\"タスク名、期限 5月1日\")")
                FigmaCodeBox(label: "入力とラベルを関連づける",
                             code: "TextField(\"例: 牛乳を買う\", text: $title)\n    .accessibilityLabel(\"タスク名\")")
            }

        case .sensoryCharacteristics:
            HStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    Text("右のボタンを押して\n送信してください")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    Text("「送信」ボタンを押して\n送信してください")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .orientation:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: nil) {
                    HStack(spacing: DesignTokens.Spacing.md) {
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Image(systemName: "rectangle.portrait")
                                .font(.system(size: 28))
                                .foregroundStyle(DesignTokens.Color.primary)
                                .accessibilityHidden(true)
                            Image(systemName: "rectangle.landscape")
                                .font(.system(size: 28))
                                .foregroundStyle(DesignTokens.Color.primary)
                                .accessibilityHidden(true)
                        }
                        Text("縦・横どちらの向きでも動作する")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                }
                FigmaCodeBox(label: "向きを固定しない（Info.plist）",
                             code: "// Supported Interface Orientations に\n// Portrait と Landscape 両方を登録する\n// SwiftUI はデフォルトで制限なし")
            }

        case .identifyInputPurpose:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaCodeBox(label: "メールアドレス",
                             code: "TextField(\"例: user@example.com\",\n          text: $email)\n    .textContentType(.emailAddress)\n    .keyboardType(.emailAddress)")
                FigmaCodeBox(label: "氏名",
                             code: "TextField(\"例: 山田 太郎\", text: $name)\n    .textContentType(.name)")
                FigmaCodeBox(label: "パスワード",
                             code: "SecureField(\"パスワード\", text: $password)\n    .textContentType(.password)")
            }

        // MARK: - 1.4.x 判別可能

        case .reflow:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: nil) {
                    Text("このアプリは ScrollView を使用しており、画面幅に応じてコンテンツが縦方向に再配置されます。横スクロールなしで 320pt 幅でも閲覧できます。")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                FigmaCodeBox(label: "リフロー対応のレイアウト",
                             code: "ScrollView {\n    VStack {\n        Text(content)\n            .frame(maxWidth: .infinity)\n            .fixedSize(horizontal: false,\n                       vertical: true)\n    }\n}")
            }

        case .nonTextContrast:
            // 教育目的: 低コントラストと高コントラストのUIコンポーネントを比較
            HStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例 (1.5:1)")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Image(systemName: "bell")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(hex: "#c4c4c4")) // 教育目的: 低コントラスト
                            .frame(width: 44, height: 44)
                            .background(DesignTokens.Color.surface)
                            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                            .overlay(
                                RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                    .stroke(Color(hex: "#e8e8e8"), lineWidth: 1) // 教育目的: 低コントラスト
                            )
                            .accessibilityLabel("通知（コントラスト不足）")
                        Text("不十分")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例 (3:1+)")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Image(systemName: "bell")
                            .font(.system(size: 18))
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .frame(width: 44, height: 44)
                            .background(DesignTokens.Color.surface)
                            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                            .overlay(
                                RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                                    .stroke(DesignTokens.Color.border, lineWidth: 1)
                            )
                            .accessibilityLabel("通知（適切なコントラスト）")
                        Text("十分")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        // MARK: - 2.1.x キーボード

        case .noKeyboardTrap:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: nil) {
                    Text("シートやアラートは常に閉じる手段を提供します。フォーカスが特定の要素に閉じ込められることはありません。")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                FigmaCodeBox(label: "シートを閉じる",
                             code: "@Environment(\\.dismiss) var dismiss\n\nButton(\"閉じる\") { dismiss() }")
                FigmaCodeBox(label: "半モーダルはドラッグでも閉じられる",
                             code: ".sheet(isPresented: $isPresented) {\n    Content()\n        .presentationDetents(\n            [.medium, .large])\n        .presentationDragIndicator(.visible)\n}")
            }

        // MARK: - 2.2.x 十分な時間

        case .timingAdjustable:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: "タイムアウトの調整例") {
                    VStack(spacing: DesignTokens.Spacing.md) {
                        HStack {
                            Image(systemName: "timer")
                                .foregroundStyle(timerSeconds <= 10 ? DesignTokens.Color.danger : DesignTokens.Color.primary)
                                .accessibilityHidden(true)
                            Text("残り \(timerSeconds) 秒")
                                .font(DesignTokens.Font.bodyBold)
                                .foregroundStyle(timerSeconds <= 10 ? DesignTokens.Color.danger : DesignTokens.Color.textPrimary)
                                .accessibilityLabel("残り\(timerSeconds)秒")
                            Spacer()
                            if timerSeconds == 0 {
                                Text("タイムアウト")
                                    .font(DesignTokens.Font.captionBold)
                                    .foregroundStyle(DesignTokens.Color.danger)
                            }
                        }
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            DAButton(isTimerRunning ? "一時停止" : "開始", style: .solidFill, size: .small) {
                                isTimerRunning.toggle()
                            }
                            DAButton("20秒延長", style: .outlined, size: .small) {
                                timerSeconds += 20
                            }
                            DAButton("リセット", style: .text, size: .small) {
                                timerSeconds = 30
                                isTimerRunning = false
                            }
                        }
                    }
                }
            }
            .task(id: isTimerRunning) {
                guard isTimerRunning else { return }
                while isTimerRunning && timerSeconds > 0 {
                    do {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    } catch {
                        return
                    }
                    guard isTimerRunning else { return }
                    timerSeconds -= 1
                    if timerSeconds == 0 { isTimerRunning = false }
                }
            }

        // MARK: - 2.4.x ナビゲーション可能

        case .bypassBlocks:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: nil) {
                    Text("VoiceOver のローターで「見出し」を選択すると、見出し間をスワイプでジャンプできます。.isHeader trait を付与することが前提です。")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                FigmaCodeBox(label: "セクション見出しのマーク",
                             code: "Text(\"1. 知覚可能 (Perceivable)\")\n    .font(DesignTokens.Font.heading4)\n    .accessibilityAddTraits(.isHeader)")
            }

        case .linkPurpose:
            HStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    HStack(spacing: 0) {
                        Text("詳細は")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Text("こちら")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.primary)
                            .underline()
                        Text("を確認")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    Text("WCAG 2.2 の\n詳細を見る")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.primary)
                        .underline()
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .headingsAndLabels:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: "見出し階層の例") {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                        Text("アクセシビリティ設定")
                            .font(DesignTokens.Font.heading4)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                        Text("VoiceOver")
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                            .padding(.leading, DesignTokens.Spacing.md)
                        Text("読み上げ速度: 標準")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                            .padding(.leading, DesignTokens.Spacing.xxl)
                    }
                }
                FigmaCodeBox(label: "見出しのマーク",
                             code: "Text(\"セクション名\")\n    .accessibilityAddTraits(.isHeader)")
            }

        // MARK: - 2.5.x 入力モダリティ

        case .pointerGestures:
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                HStack(spacing: DesignTokens.Spacing.sm) {
                    Button { } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .accessibilityHidden(true)
                            Text("前のページ")
                        }
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("前のページへ")

                    Button { } label: {
                        HStack {
                            Text("次のページ")
                            Image(systemName: "chevron.right")
                                .accessibilityHidden(true)
                        }
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(DesignTokens.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                        .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(DesignTokens.Color.border, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("次のページへ")
                }
                Text("スワイプジェスチャーに対してタップ可能なボタンを代替操作として提供")
                    .font(DesignTokens.Font.caption)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }

        case .pointerCancellation:
            HStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    Text("onTapGesture は\nDown で即実行\n（キャンセル不可）")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    Text("Button は\nUp で完了\n（ドラッグでキャンセル可）")
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        case .labelInName:
            HStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Text("削除")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Button { } label: {
                            Text("×")
                                .font(DesignTokens.Font.bodyBold)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .frame(width: 28, height: 28)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("×")
                    }
                    Text(".accessibilityLabel(\"×\")")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Text("削除")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Button { } label: {
                            Text("×")
                                .font(DesignTokens.Font.bodyBold)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .frame(width: 28, height: 28)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("削除")
                    }
                    Text(".accessibilityLabel(\"削除\")")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        // MARK: - 3.1.x 読み取り可能

        case .languageOfPage:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaCodeBox(label: "Info.plist で言語を宣言",
                             code: "<!-- Info.plist -->\n<key>CFBundleDevelopmentRegion</key>\n<string>ja</string>")
                FigmaCodeBox(label: "SwiftUI でロケールを明示（部分指定）",
                             code: "Text(\"設定\")\n    .environment(\\.locale,\n        Locale(identifier: \"ja\"))")
            }

        // MARK: - 3.2.x 予測可能

        case .onFocus:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaDemoBox(label: nil) {
                    Text("VoiceOver のスワイプでフォーカスを移動しても、自動的な画面遷移や予期しないダイアログが表示されてはいけません。")
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                }
                FigmaCodeBox(label: "フォーカスだけで遷移しない（OK）",
                             code: "@FocusState private var isFocused: Bool\n\nTextField(\"タスク名\", text: $title)\n    .focused($isFocused)\n// フォーカス変化だけで遷移しない")
            }

        case .onInput:
            VStack(spacing: DesignTokens.Spacing.md) {
                FigmaCodeBox(label: "入力・選択だけで自動遷移しない（OK）",
                             code: "Picker(\"優先度\", selection: $priority) {\n    ...\n}\n// 選択後はボタン押下で確定する")
                FigmaCodeBox(label: "NG パターン",
                             code: "// 選択と同時に自動遷移してしまう例\n.onChange(of: selectedItem) { _ in\n    navigationPath.append(selectedItem)\n}")
            }

        case .consistentIdentification:
            FigmaDemoBox(label: "アプリ全体で一貫したアイコンと名前を使用") {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.md) {
                        Image(systemName: "plus")
                            .font(.system(size: 16))
                            .foregroundStyle(DesignTokens.Color.primary)
                            .frame(width: 20)
                            .accessibilityHidden(true)
                        Text("追加アクション → 常に「plus」アイコン")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                    HStack(spacing: DesignTokens.Spacing.md) {
                        Image(systemName: "trash")
                            .font(.system(size: 16))
                            .foregroundStyle(DesignTokens.Color.danger)
                            .frame(width: 20)
                            .accessibilityHidden(true)
                        Text("削除アクション → 常に「trash」アイコン")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                    HStack(spacing: DesignTokens.Spacing.md) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 16))
                            .foregroundStyle(DesignTokens.Color.success)
                            .frame(width: 20)
                            .accessibilityHidden(true)
                        Text("完了アクション → 常に「checkmark.circle」")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                    }
                }
            }

        // MARK: - 3.3.x 入力支援

        case .labelsOrInstructions:
            VStack(spacing: DesignTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#82181a"))
                            .accessibilityHidden(true)
                        Text("悪い例（プレースホルダーのみ）")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#82181a"))
                    }
                    RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                        .stroke(DesignTokens.Color.border, lineWidth: 1)
                        .frame(height: 44)
                        .overlay(
                            Text("タスク名を入力...")
                                .font(DesignTokens.Font.bodySmall)
                                .foregroundStyle(DesignTokens.Color.textDisabled)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, DesignTokens.Spacing.md)
                        )
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#fef2f2"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#ffc9c9"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(DesignTokens.Font.caption)
                            .foregroundStyle(Color(hex: "#0d542b"))
                            .accessibilityHidden(true)
                        Text("良い例（外部ラベル付き）")
                            .font(DesignTokens.Font.captionBold)
                            .foregroundStyle(Color(hex: "#0d542b"))
                    }
                    Text("タスク名")
                        .font(DesignTokens.Font.bodySmallBold)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                    RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                        .stroke(DesignTokens.Color.border, lineWidth: 1)
                        .frame(height: 44)
                        .overlay(
                            Text("例: 牛乳を買う")
                                .font(DesignTokens.Font.bodySmall)
                                .foregroundStyle(DesignTokens.Color.textDisabled)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, DesignTokens.Spacing.md)
                        )
                }
                .padding(DesignTokens.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#f0fdf4"))
                .overlay(RoundedRectangle(cornerRadius: DesignTokens.Radius.md).stroke(Color(hex: "#b9f8cf"), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
            }

        default:
            VStack(spacing: DesignTokens.Spacing.base) {
                Image(systemName: "hammer")
                    .font(.system(size: 32))
                    .foregroundStyle(DesignTokens.Color.textDisabled)
                    .accessibilityHidden(true)
                Text("このデモは準備中です")
                    .font(DesignTokens.Font.body)
                    .foregroundStyle(DesignTokens.Color.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignTokens.Spacing.xxxl)
        }
    }
}

// MARK: - WCAGSectionCard

private struct WCAGSectionCard<Content: View>: View {
    let number: String
    let title: String
    let englishTitle: String
    let description: String
    let iconName: String
    let accentColor: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.base) {
            // セクションヘッダー
            HStack(alignment: .top, spacing: DesignTokens.Spacing.md) {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundStyle(accentColor)
                    .frame(width: 24, height: 24)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                    Text("\(number). \(title) (\(englishTitle))")
                        .font(DesignTokens.Font.heading4)
                        .foregroundStyle(DesignTokens.Color.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    Text(description)
                        .font(DesignTokens.Font.bodySmall)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
            }

            // 各基準
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xl) {
                content()
            }
        }
        .padding(DesignTokens.Spacing.base)
        .background(DesignTokens.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
        .overlay(
            RoundedRectangle(cornerRadius: DesignTokens.Radius.lg)
                .stroke(DesignTokens.Color.border, lineWidth: 1)
        )
        .padding(.horizontal, DesignTokens.Spacing.base)
    }
}

// MARK: - FigmaDemoBox

private struct FigmaDemoBox<Content: View>: View {
    let label: String?
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            if let label {
                Text(label)
                    .font(DesignTokens.Font.bodySmall)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
            }
            content()
        }
        .padding(DesignTokens.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.Color.background)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
    }
}

// MARK: - FigmaCodeBox

private struct FigmaCodeBox: View {
    let label: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            Text(label)
                .font(DesignTokens.Font.bodySmallBold)
                .foregroundStyle(DesignTokens.Color.textPrimary)
            Text(code)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(DesignTokens.Color.textSecondary)
        }
        .padding(DesignTokens.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.Color.background)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
    }
}
