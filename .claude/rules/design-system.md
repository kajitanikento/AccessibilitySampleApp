---
paths: 
  - "AccessibilitySampleApp/**/*View.swift"
  - "AccessibilitySampleApp/DesignSystem/**"
---


# デジタル庁デザインシステム実装ルール

参照: https://www.figma.com/design/bARB0bTYmVuImnlcSFqRxX/
バージョン: v2.10.3

---

## 基本方針

- デザイントークンを必ず使用する。ハードコードした色・フォントサイズ・余白は禁止
- SwiftUI の `DesignTokens` ファイル（`AccessibilitySampleApp/DesignSystem/DesignTokens.swift`）に定義されたトークンのみ使用する
- WCAG 2.1 AA 準拠を前提とする
- フォントは Noto Sans JP を使用する。バンドルされていない場合は `.system` フォールバックを使用
- Dynamic Type をサポートする（`scaledFont` or `.font(.body)` などのスケーラブルスタイル）

---

## カラートークン

### プリミティブカラー（参照用・直接使用禁止）

```
Blue:
  blue-50:  #E8EAFA
  blue-100: #C4CAF5
  blue-200: #9EA9F0
  blue-300: #7789EA
  blue-400: #5B6FE5
  blue-500: #4155E0
  blue-600: #3248CC
  blue-700: #2539B8
  blue-800: #1A2BA3
  blue-900: #0017C1  ← Primary Action

Gray (Neutral):
  gray-50:  #F8F8F8
  gray-100: #EFEFEF
  gray-200: #E0E0E0
  gray-300: #C4C4C4
  gray-400: #9E9E9E
  gray-500: #757575
  gray-600: #616161
  gray-700: #424242
  gray-800: #212121
  gray-900: #000000

White: #FFFFFF
```

### セマンティックカラー（SwiftUI `DesignTokens.Color` を使用）

```swift
// 使用例
DesignTokens.Color.primary          // #0017C1 / ボタン・リンク
DesignTokens.Color.primaryDark      // #001299 / Hover/Active状態
DesignTokens.Color.textPrimary      // #212121 / 本文テキスト
DesignTokens.Color.textSecondary    // #616161 / 補足テキスト
DesignTokens.Color.textDisabled     // #9E9E9E / 無効テキスト
DesignTokens.Color.textOnPrimary    // #FFFFFF / Primary背景上のテキスト
DesignTokens.Color.surface          // #FFFFFF / カード・モーダル背景
DesignTokens.Color.background       // #F8F8F8 / ページ背景
DesignTokens.Color.border           // #C4C4C4 / ボーダー
DesignTokens.Color.borderFocus      // #0017C1 / フォーカスリング
DesignTokens.Color.danger           // #D32F2F / エラー
DesignTokens.Color.dangerText       // #B71C1C / エラーテキスト
DesignTokens.Color.warning          // #F9A825 / 警告
DesignTokens.Color.success          // #388E3C / 成功
```

### ダークモード
- 全トークンは `Color(light:dark:)` パターンまたは `Color("TokenName")` (Assets.xcassets) で定義する
- ハードコードの `Color(hex:)` は禁止

---

## タイポグラフィトークン

フォント: **Noto Sans JP**（システムフォント代替: `.system`）

### テキストスタイル一覧

| トークン名 | サイズ | ウェイト | 行高 | 字間 | 用途 |
|---|---|---|---|---|---|
| `heading1` | 32px | Bold(700) | 1.5 | 0 | ページ見出し |
| `heading2` | 24px | Bold(700) | 1.5 | 0 | セクション見出し |
| `heading3` | 20px | Bold(700) | 1.5 | 0 | サブ見出し |
| `heading4` | 18px | Bold(700) | 1.5 | 0 | 小見出し |
| `bodyLarge` | 18px | Regular(400) | 1.75 | 0 | 大きめ本文 |
| `body` | 16px | Regular(400) | 1.75 | 0 | 標準本文 |
| `bodyBold` | 16px | Bold(700) | 1.75 | 0 | 強調本文 |
| `bodySmall` | 14px | Regular(400) | 1.75 | 0 | 小さめ本文 |
| `bodySmallBold` | 14px | Bold(700) | 1.75 | 0 | 小さめ強調 |
| `caption` | 12px | Regular(400) | 1.5 | 0 | キャプション |
| `captionBold` | 12px | Bold(700) | 1.5 | 0 | 強調キャプション |
| `button` (oneline) | 16px | Bold(700) | 1.0 | 0.02em | ボタンラベル |
| `buttonSmall` | 14px | Bold(700) | 1.0 | 0.02em | 小ボタンラベル |
| `buttonXSmall` | 12px | Bold(700) | 1.0 | 0.02em | 極小ボタンラベル |

```swift
// 使用例
Text("見出し").font(DesignTokens.Font.heading2)
Text("本文").font(DesignTokens.Font.body)
Text("ボタン").font(DesignTokens.Font.button)
```

---

## スペーシングトークン

4px グリッドを基本とする。

```swift
DesignTokens.Spacing.xs    // 4px
DesignTokens.Spacing.sm    // 8px
DesignTokens.Spacing.md    // 12px
DesignTokens.Spacing.base  // 16px
DesignTokens.Spacing.lg    // 20px
DesignTokens.Spacing.xl    // 24px
DesignTokens.Spacing.xxl   // 32px
DesignTokens.Spacing.xxxl  // 40px
DesignTokens.Spacing.huge  // 48px
DesignTokens.Spacing.giant // 64px
```

---

## ボーダーラジアストークン

```swift
DesignTokens.Radius.sm   // 4px  (小コンポーネント: Badge, Tag)
DesignTokens.Radius.md   // 8px  (ボタン, 入力フィールド, カード)
DesignTokens.Radius.lg   // 16px (モーダル, 大カード)
DesignTokens.Radius.full // 9999px (ピル形状)
```

---

## コンポーネント仕様

### ボタン (Button)

#### スタイルと用途
| スタイル | 用途 |
|---|---|
| `solidFill` | Primary Action（最重要操作、1画面に1つ） |
| `outlined` | Secondary Action |
| `text` | Tertiary Action / テキストリンク |

#### サイズ仕様

| Size | 高さ | 水平Padding | フォント | 最小幅 |
|---|---|---|---|---|
| `large` | 56px | 16px | 16px Bold | 136px |
| `medium` | 48px | 16px | 14px Bold | 96px |
| `small` | 36px | 12px | 14px Bold | 80px |
| `xSmall` | 28px | 8px | 12px Bold | 72px |

#### 状態別カラー

**Solid Fill**
| State | Background | Text |
|---|---|---|
| Default | `#0017C1` | `#FFFFFF` |
| Hover | `#001299` | `#FFFFFF` |
| Active | `#001299` | `#FFFFFF` |
| Disabled | `#C4C4C4` | `#FFFFFF` |

**Outlined**
| State | Background | Border | Text |
|---|---|---|---|
| Default | `#FFFFFF` | `#0017C1` | `#0017C1` |
| Hover | `#E8EAFA` | `#001299` | `#001299` |
| Active | `#E8EAFA` | `#001299` | `#001299` |
| Disabled | `#FFFFFF` | `#C4C4C4` | `#C4C4C4` |

**Text Button**
| State | Text |
|---|---|
| Default | `#0017C1` |
| Hover | `#001299` |
| Active | `#001299` |
| Disabled | `#9E9E9E` |

#### SwiftUI実装パターン

```swift
// DAButton コンポーネントを使用
DAButton("ラベル", style: .solidFill, size: .large) {
    // action
}
.disabled(isDisabled)

// Outlined
DAButton("キャンセル", style: .outlined, size: .medium) { }

// Text Button
DAButton("詳細を見る", style: .text, size: .small) { }
```

#### フォーカスインジケーター
- フォーカス時: `borderFocus` (#0017C1) 2px アウトライン + 2px オフセット
- SwiftUI: `.overlay(focusRing)` でカスタム実装

#### アクセシビリティ
- `Button` を使用（`onTapGesture` 禁止）
- `accessibilityLabel`: ラベルが視覚テキストと異なる場合のみ設定
- `accessibilityAddTraits(.isButton)` は `Button` なら不要
- disabled時は `accessibilityAddTraits(.isNotEnabled)`

---

### 入力フィールド (TextField)

#### 仕様
- 高さ: 48px（Large）/ 40px（Medium）
- ボーダー: 1px solid `#C4C4C4`（Default）
- フォーカス: 2px solid `#0017C1`
- エラー: 1px solid `#D32F2F`
- ラベル: 常に外部ラベル（プレースホルダーのみは禁止）
- 角丸: 8px

```swift
// ラベルは必ず TextField の外に配置
VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
    Text("メールアドレス")
        .font(DesignTokens.Font.bodyBold)
        .foregroundColor(DesignTokens.Color.textPrimary)

    TextField("例: user@example.com", text: $email)
        .textFieldStyle(DATextFieldStyle(state: .default))
        .accessibilityLabel("メールアドレス")
}
```

---

### フォームレイアウト

- ラベルと入力フィールドの間隔: `Spacing.xs` (4px)
- フィールド間隔: `Spacing.xl` (24px)
- エラーメッセージは入力フィールドの直下に `Spacing.xs` で配置
- エラーには警告アイコン + テキストを併用（色だけに依存しない）

---

### カード

- 背景: `surface` (#FFFFFF)
- ボーダー: 1px solid `border` (#C4C4C4)（または shadow）
- 角丸: `Radius.md` (8px)
- 内余白: `Spacing.base` (16px)

---

### リスト / テーブル

- 行高: 最低 44px（タップターゲット確保）
- セパレーター: `border` (#C4C4C4)
- VoiceOver: 行全体を1要素にまとめて読み上げる（`.accessibilityElement(children: .combine)`）

---

## アクセシビリティ必須要件

### タップターゲット
- 最小サイズ: 44x44pt（WCAG 2.5.8）
- 小さいコンポーネントは `.frame(minWidth: 44, minHeight: 44)` でタップ領域を確保

### コントラスト比
- 通常テキスト（18px未満 / Bold 14px未満）: **4.5:1以上**
- 大きいテキスト（18px以上 / Bold 14px以上）: **3:1以上**
- UIコンポーネントのボーダー・アイコン: **3:1以上**

コントラストチェック必須の組み合わせ:
- `primary` (#0017C1) on white (#FFFFFF): 8.6:1 ✓
- `textPrimary` (#212121) on white (#FFFFFF): 16.1:1 ✓
- `textSecondary` (#616161) on white (#FFFFFF): 5.9:1 ✓
- `textDisabled` (#9E9E9E) on white (#FFFFFF): 2.8:1 ✗（装飾的用途のみ）

### VoiceOver
- すべてのインタラクティブ要素に意味のある `accessibilityLabel` を設定
- 装飾画像: `accessibilityHidden(true)`
- 意味のある画像: `accessibilityLabel` を設定
- 状態変化を `.accessibilityValue` または `UIAccessibility.post(notification:)` で通知

### Dynamic Type
- `body`, `title`, `caption` などの標準テキストスタイルを使用
- カスタムサイズは `UIFontMetrics` でスケーリング（ハードコードのサイズは禁止）

---

## 禁止事項

1. ハードコードの色値（`Color(hex: "#0017C1")` → `DesignTokens.Color.primary` を使用）
2. ハードコードのフォントサイズ（`.font(.system(size: 16))` → `DesignTokens.Font.body` を使用）
3. ハードコードの余白（`padding(16)` → `padding(DesignTokens.Spacing.base)` を使用）
4. プレースホルダーのみのフォームラベル（外部ラベルが必須）
5. `onTapGesture` でインタラクションを実装（`Button` を使用）
6. 色のみで情報を伝えるUI（アイコンまたはテキストを併用）
7. 44pt未満のタップターゲット

---

## Figmaとのトークン対応表

| Figma CSS変数 | SwiftUI定数 |
|---|---|
| `--color-primitive-blue-900` | `DesignTokens.Color.primary` |
| `--color-neutral-white` | `DesignTokens.Color.surface` |
| `--font-size-16` | `DesignTokens.Font.body` |
| `--font-family-sans` | Noto Sans JP / system |
| `--font-weight-700` | `.bold` |
| `--border-radius-8` | `DesignTokens.Radius.md` |
