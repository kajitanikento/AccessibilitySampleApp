# AccessibilitySampleApp

iOSアプリのアクセシビリティ実装の構築方法を示すためのサンプルアプリです。

## デザインシステム

**デジタル庁デザインシステム v2.10.3** に準拠してUI実装を行う。

詳細ルール: `.claude/rules/design-system.md` を必ず参照すること。

### 実装の原則（必須）

1. **トークンのみ使用** — 色・フォント・余白は `DesignTokens`（`AccessibilitySampleApp/DesignSystem/DesignTokens.swift`）の定数を使用。ハードコード禁止
2. **既存コンポーネント優先** — ボタンは `DAButton`（`AccessibilitySampleApp/DesignSystem/DAButton.swift`）を使用
3. **WCAG 2.1 AA** — タップターゲット最小44pt、コントラスト比テキスト4.5:1以上、VoiceOver対応必須
4. **SwiftUI ネイティブ** — `Button` を使用し `onTapGesture` でインタラクションを実装しない

### デザインシステム ファイル構成

```
AccessibilitySampleApp/DesignSystem/
  ├── DesignTokens.swift   # 色・フォント・スペーシング・ラジアスのトークン定数
  └── DAButton.swift       # デジタル庁準拠ボタンコンポーネント
```

### Figmaリンク

- デザインシステム: https://www.figma.com/design/bARB0bTYmVuImnlcSFqRxX/
- アプリデザイン: https://www.figma.com/design/018xsStYAbOFdYScxWXbvM/AccessibilitySampleApp

## アプリ概要

WCAG 2.2 A/AA 対応の SwiftUI アクセシビリティサンプルアプリ。

### ファイル構成

```
AccessibilitySampleApp/
  ├── Feature                  # 機能
  └── DesignSystem/            # デジタル庁デザインシステム実装
```
