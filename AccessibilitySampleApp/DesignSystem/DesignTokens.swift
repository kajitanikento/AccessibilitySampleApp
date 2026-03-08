import SwiftUI
import UIKit

// MARK: - デジタル庁デザインシステム v2.10.3 トークン定義
// 参照: https://www.figma.com/design/bARB0bTYmVuImnlcSFqRxX/
// このファイルに定義されたトークンのみを使用すること。ハードコードの色・サイズは禁止。

enum DesignTokens {

    // MARK: - Color

    enum Color {
        // Primary
        static let primary       = adaptiveColor(light: 0x0017C1, dark: 0x5B6FE5)
        static let primaryDark   = adaptiveColor(light: 0x001299, dark: 0x4155E0)
        static let primaryLight  = adaptiveColor(light: 0xE8EAFA, dark: 0x1A2BA3)

        // Text
        static let textPrimary   = adaptiveColor(light: 0x212121, dark: 0xEFEFEF)
        static let textSecondary = adaptiveColor(light: 0x616161, dark: 0x9E9E9E)
        static let textDisabled  = adaptiveColor(light: 0x9E9E9E, dark: 0x616161)
        static let textOnPrimary = adaptiveColor(light: 0xFFFFFF, dark: 0xFFFFFF)

        // Surface / Background
        static let surface       = adaptiveColor(light: 0xFFFFFF, dark: 0x1C1C1E)
        static let background    = adaptiveColor(light: 0xF8F8F8, dark: 0x000000)
        static let surfaceRaised = adaptiveColor(light: 0xFFFFFF, dark: 0x2C2C2E)

        // Border
        static let border        = adaptiveColor(light: 0xC4C4C4, dark: 0x424242)
        static let borderFocus   = adaptiveColor(light: 0x0017C1, dark: 0x5B6FE5)

        // Semantic
        static let danger        = adaptiveColor(light: 0xD32F2F, dark: 0xEF5350)
        static let dangerText    = adaptiveColor(light: 0xB71C1C, dark: 0xEF9A9A)
        static let dangerSurface = adaptiveColor(light: 0xFFEBEE, dark: 0x4E1B1B)
        static let warning       = adaptiveColor(light: 0xF9A825, dark: 0xFFCA28)
        static let warningSurface = adaptiveColor(light: 0xFFFDE7, dark: 0x4A3800)
        static let success       = adaptiveColor(light: 0x388E3C, dark: 0x66BB6A)
        static let successSurface = adaptiveColor(light: 0xE8F5E9, dark: 0x1B3A1D)

        private static func adaptiveColor(light lightHex: UInt, dark darkHex: UInt) -> SwiftUI.Color {
            SwiftUI.Color(UIColor { $0.userInterfaceStyle == .dark ? uiColor(darkHex) : uiColor(lightHex) })
        }

        private static func uiColor(_ hex: UInt) -> UIColor {
            let r = CGFloat((hex >> 16) & 0xFF) / 255
            let g = CGFloat((hex >> 8)  & 0xFF) / 255
            let b = CGFloat(hex         & 0xFF) / 255
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }

    // MARK: - Font

    enum Font {
        static let heading1      = scaledFont(size: 32, weight: .bold)
        static let heading2      = scaledFont(size: 24, weight: .bold)
        static let heading3      = scaledFont(size: 20, weight: .bold)
        static let heading4      = scaledFont(size: 18, weight: .bold)

        static let bodyLarge     = scaledFont(size: 18, weight: .regular)
        static let body          = scaledFont(size: 16, weight: .regular)
        static let bodyBold      = scaledFont(size: 16, weight: .bold)
        static let bodySmall     = scaledFont(size: 14, weight: .regular)
        static let bodySmallBold = scaledFont(size: 14, weight: .bold)

        static let caption       = scaledFont(size: 12, weight: .regular)
        static let captionBold   = scaledFont(size: 12, weight: .bold)

        // ボタン用（oneline スタイル / letterSpacing 0.02em）
        static let button        = scaledFont(size: 16, weight: .bold)
        static let buttonSmall   = scaledFont(size: 14, weight: .bold)
        static let buttonXSmall  = scaledFont(size: 12, weight: .bold)

        private static func scaledFont(size: CGFloat, weight: UIFont.Weight) -> SwiftUI.Font {
            let fontName = weight == .bold ? "NotoSansJP-Bold" : "NotoSansJP-Regular"
            // Font.custom(_:size:relativeTo:) は Dynamic Type 対応:
            // NotoSansJP が利用不可の場合はシステムフォントにフォールバックしつつ、
            // relativeTo で指定したテキストスタイルに連動してスケールする。
            return SwiftUI.Font.custom(fontName, size: size, relativeTo: .body)
        }
    }

    // MARK: - Spacing (4px grid)

    enum Spacing {
        static let xs:    CGFloat = 4
        static let sm:    CGFloat = 8
        static let md:    CGFloat = 12
        static let base:  CGFloat = 16
        static let lg:    CGFloat = 20
        static let xl:    CGFloat = 24
        static let xxl:   CGFloat = 32
        static let xxxl:  CGFloat = 40
        static let huge:  CGFloat = 48
        static let giant: CGFloat = 64
    }

    // MARK: - Border Radius

    enum Radius {
        static let sm:   CGFloat = 4
        static let md:   CGFloat = 8
        static let lg:   CGFloat = 16
        static let full: CGFloat = 9999
    }

    // MARK: - Minimum Touch Target

    enum TouchTarget {
        /// WCAG 2.5.8 準拠: 最小 44x44pt
        static let minimum: CGFloat = 44
    }
}
