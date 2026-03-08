import SwiftUI

// MARK: - DAButton
// デジタル庁デザインシステム v2.10.3 準拠ボタン
// 仕様: .claude/design-system.md の「ボタン」セクション参照

struct DAButton: View {
    enum Style { case solidFill, outlined, text }
    enum Size  { case large, medium, small, xSmall }

    let title: String
    let style: Style
    let size: Size
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @State private var isPressed = false

    init(_ title: String, style: Style = .solidFill, size: Size = .large, action: @escaping () -> Void) {
        self.title  = title
        self.style  = style
        self.size   = size
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(labelFont)
                .lineLimit(1)
                .padding(.horizontal, horizontalPadding)
                .frame(minWidth: minWidth, minHeight: height)
                .frame(height: height)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .overlay(borderOverlay)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
        }
        .buttonStyle(DAButtonStyle(isPressed: $isPressed))
        .frame(minWidth: DesignTokens.TouchTarget.minimum, minHeight: DesignTokens.TouchTarget.minimum)
        .contentShape(Rectangle())
    }

    // MARK: - Size constants

    private var height: CGFloat {
        switch size {
        case .large:  return 56
        case .medium: return 48
        case .small:  return 36
        case .xSmall: return 28
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .large:         return DesignTokens.Spacing.base  // 16
        case .medium:        return DesignTokens.Spacing.base  // 16
        case .small:         return DesignTokens.Spacing.md    // 12
        case .xSmall:        return DesignTokens.Spacing.sm    // 8
        }
    }

    private var minWidth: CGFloat {
        switch size {
        case .large:  return 136
        case .medium: return 96
        case .small:  return 80
        case .xSmall: return 72
        }
    }

    private var labelFont: SwiftUI.Font {
        switch size {
        case .large, .medium: return DesignTokens.Font.button
        case .small:          return DesignTokens.Font.buttonSmall
        case .xSmall:         return DesignTokens.Font.buttonXSmall
        }
    }

    // MARK: - Colors

    private var foregroundColor: SwiftUI.Color {
        guard isEnabled else {
            return style == .solidFill ? DesignTokens.Color.textOnPrimary : DesignTokens.Color.textDisabled
        }
        switch style {
        case .solidFill: return DesignTokens.Color.textOnPrimary
        case .outlined:  return isPressed ? DesignTokens.Color.primaryDark : DesignTokens.Color.primary
        case .text:      return isPressed ? DesignTokens.Color.primaryDark : DesignTokens.Color.primary
        }
    }

    private var backgroundColor: SwiftUI.Color {
        guard isEnabled else {
            return style == .solidFill ? DesignTokens.Color.border : .clear
        }
        switch style {
        case .solidFill: return isPressed ? DesignTokens.Color.primaryDark : DesignTokens.Color.primary
        case .outlined:  return isPressed ? DesignTokens.Color.primaryLight : DesignTokens.Color.surface
        case .text:      return isPressed ? DesignTokens.Color.primaryLight : .clear
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if style == .outlined {
            RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                .strokeBorder(
                    isEnabled
                        ? (isPressed ? DesignTokens.Color.primaryDark : DesignTokens.Color.primary)
                        : DesignTokens.Color.border,
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Button press style

private struct DAButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}

// MARK: - Previews

#Preview("Solid Fill") {
    VStack(spacing: DesignTokens.Spacing.sm) {
        DAButton("大ボタン", style: .solidFill, size: .large)  { }
        DAButton("中ボタン", style: .solidFill, size: .medium) { }
        DAButton("小ボタン", style: .solidFill, size: .small)  { }
        DAButton("極小",     style: .solidFill, size: .xSmall) { }
        DAButton("無効",     style: .solidFill, size: .large)  { }.disabled(true)
    }
    .padding()
}

#Preview("Outlined") {
    VStack(spacing: DesignTokens.Spacing.sm) {
        DAButton("キャンセル", style: .outlined, size: .large)  { }
        DAButton("キャンセル", style: .outlined, size: .medium) { }
        DAButton("無効",       style: .outlined, size: .large)  { }.disabled(true)
    }
    .padding()
}

#Preview("Text") {
    VStack(spacing: DesignTokens.Spacing.sm) {
        DAButton("詳細を見る", style: .text, size: .large)  { }
        DAButton("詳細を見る", style: .text, size: .small)  { }
        DAButton("無効",       style: .text, size: .large)  { }.disabled(true)
    }
    .padding()
}
