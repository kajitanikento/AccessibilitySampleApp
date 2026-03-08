---
paths:
  - "AccessibilitySampleApp/**/*View.swift"
---

# SwiftUI アクセシビリティ実装ガイド

WCAG 2.2 A/AA 基準（https://waic.jp/translations/WCAG22/）に基づく SwiftUI 実装パターン集。
WCAG 基準の定義・一覧は `.claude/rules/wcag.md` を参照。

---

## 必須チェックリスト

- [ ] タップターゲット 44×44pt 以上（推奨）/ 最低 24×24pt（2.5.8）
- [ ] テキストコントラスト比 4.5:1 以上（1.4.3）
- [ ] 非テキスト要素コントラスト比 3:1 以上（1.4.11）
- [ ] 全インタラクティブ要素に `accessibilityLabel` または意味のある表示テキスト（4.1.2）
- [ ] 装飾画像に `.accessibilityHidden(true)`（1.1.1）
- [ ] `Button` を使用し `onTapGesture` は使用しない（2.1.1）
- [ ] Dynamic Type 対応（`DesignTokens.Font.*` を使用）（1.4.4）
- [ ] フォーカスされた要素がスティッキー UI に隠れない（2.4.11）
- [ ] ドラッグ操作に代替ボタンを提供（2.5.7）

---

## ラベル・役割・状態（4.1.2）

```swift
// 意味のある画像
Image(systemName: "exclamationmark.triangle.fill")
    .accessibilityLabel("優先度: 高")

// 装飾画像
Image("hero").accessibilityHidden(true)

// アイコンのみのボタン
Button { delete() } label: {
    Image(systemName: "trash")
}
.accessibilityLabel("タスク「\(task.title)」を削除")
.accessibilityHint("ダブルタップで削除します")

// 状態を値として通知
Toggle("通知", isOn: $enabled)
    .accessibilityLabel("プッシュ通知")
    .accessibilityValue(enabled ? "オン" : "オフ")

// カスタム要素に役割を付与
Text("完了")
    .accessibilityAddTraits(.isButton)
    .accessibilityLabel("ステータスを変更")
    .accessibilityValue("完了")
```

---

## グループ化と読み上げ順序（1.3.1 / 1.3.2）

```swift
// リスト行全体を1要素として読み上げ
HStack {
    priorityIcon
    VStack(alignment: .leading) {
        Text(task.title)
        Text(task.dueDate)
    }
    statusBadge
}
.accessibilityElement(children: .combine)
.accessibilityLabel("\(task.title)、期限 \(task.dueDate)、\(task.priority.label)")
.accessibilityHint("ダブルタップで詳細を表示")

// ZStack で順序が崩れる場合
ZStack {
    background.accessibilitySortPriority(0)
    content.accessibilitySortPriority(1)
}

// 見出し
Text("セクション名")
    .font(DesignTokens.Font.heading3)
    .accessibilityAddTraits(.isHeader)
```

---

## インタラクション（2.1.1 / 2.5.2）

```swift
// OK: Button は Up イベントで完了・キャンセル可能
Button("送信") { submit() }

// NG: onTapGesture はキーボード・Switch Control 非対応
Text("送信").onTapGesture { submit() }

// カスタムアクション（スワイプ操作の代替）
Row()
    .accessibilityAction(named: "削除") { delete(task) }
    .accessibilityAction(named: "完了にする") { complete(task) }
```

---

## ドラッグ操作の代替（2.5.7）

ドラッグ並び替えには必ずボタンによる代替移動を提供する。

```swift
ForEach(items) { item in
    HStack {
        Text(item.title)
        Spacer()
        Button { moveUp(item) } label: {
            Image(systemName: "chevron.up")
        }
        .accessibilityLabel("\(item.title)を上へ移動")
        Button { moveDown(item) } label: {
            Image(systemName: "chevron.down")
        }
        .accessibilityLabel("\(item.title)を下へ移動")
    }
}
.onMove { from, to in items.move(fromOffsets: from, toOffset: to) }
```

---

## タップターゲット（2.5.8）

```swift
// 視覚サイズが小さくてもタップ領域を 44×44pt に拡大
Button { action() } label: {
    Image(systemName: "info.circle").font(.system(size: 16))
}
.frame(minWidth: 44, minHeight: 44)

// contentShape で当たり判定のみ拡大
SomeView()
    .contentShape(Rectangle())
    .frame(minWidth: 44, minHeight: 44)
```

---

## コントラスト（1.4.3 / 1.4.11）

`DesignTokens.Color` のセマンティックトークンを使えば基準を満たす。
ハードコードの `Color(hex:)` を使う場合は必ずコントラスト比を確認する。

| 組み合わせ | コントラスト比 | 基準 |
|---|---|---|
| `textPrimary` (#212121) / white | 16.1:1 | OK |
| `textSecondary` (#616161) / white | 5.9:1 | OK |
| `primary` (#0017C1) / white | 8.6:1 | OK |
| `textDisabled` (#9E9E9E) / white | 2.8:1 | 装飾用途のみ |

フォーカスリング・アイコン・ボーダーは背景に対して 3:1 以上が必要（1.4.11）。

---

## Dynamic Type（1.4.4）

```swift
// NG
Text("本文").font(.system(size: 16))

// OK: DesignTokens.Font は Dynamic Type スケーリング済み
Text("本文").font(DesignTokens.Font.body)

// レイアウトは縦方向に伸縮させ、横スクロールを強制しない
Text("長いテキスト")
    .frame(maxWidth: .infinity, alignment: .leading)
    .fixedSize(horizontal: false, vertical: true)
```

---

## 色だけに依存しない（1.4.1）

```swift
// NG: 色だけでエラーを表現
TextField("", text: $value).border(Color.red)

// OK: アイコン + テキスト + 色を併用
HStack(spacing: DesignTokens.Spacing.xs) {
    Image(systemName: "exclamationmark.circle.fill")
        .foregroundStyle(DesignTokens.Color.danger)
        .accessibilityHidden(true)
    Text(errorMessage)
        .foregroundStyle(DesignTokens.Color.dangerText)
}
```

---

## フォームとエラー（3.3.1 / 3.3.2 / 3.3.3）

```swift
// ラベルは常に外部に配置（プレースホルダーのみ禁止）
VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
    Text("タスク名")
        .font(DesignTokens.Font.bodyBold)
    TextField("例: 牛乳を買う", text: $title)
        .accessibilityLabel("タスク名")
    // エラー時: アイコン + 修正方法（3.3.1 / 3.3.3）
    if let error = titleError {
        HStack(spacing: DesignTokens.Spacing.xs) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(DesignTokens.Color.danger)
                .accessibilityHidden(true)
            Text(error) // 例: "100文字以内で入力してください（現在120文字）"
                .font(DesignTokens.Font.bodySmall)
                .foregroundStyle(DesignTokens.Color.dangerText)
        }
    }
}
```

---

## フォーカス制御（2.4.3 / 2.4.11）

```swift
// モーダル表示後にフォーカスを移動
@AccessibilityFocusState private var isSheetFocused: Bool

.sheet(isPresented: $showSheet) {
    SheetContent()
        .accessibilityFocused($isSheetFocused)
        .onAppear { isSheetFocused = true }
}

// スティッキー UI がコンテンツを隠す場合は padding で回避（2.4.11）
ScrollView {
    content.padding(.bottom, bottomBarHeight)
}
```

---

## 状態変化の通知（4.1.2）

```swift
// iOS 17+
.accessibilityAnnouncement("タスクを追加しました")

// iOS 16 以前
UIAccessibility.post(notification: .announcement, argument: "タスクを追加しました")

// ローディング
ProgressView()
    .accessibilityLabel("読み込み中")
    .accessibilityAddTraits(.updatesFrequently)
```

---

## 認証（3.3.8）

```swift
// Face ID / Touch ID を提供（認知テストだけに頼らない）
Button("Face IDでサインイン") { authenticateWithBiometrics() }

// パスワードフィールドはペースト・パスワードマネージャーをブロックしない
SecureField("パスワード", text: $password)
    .textContentType(.password) // パスワードマネージャーを許可
```

---

## 冗長な入力の排除（3.3.7）

```swift
// 前のステップで入力済みの値は @State / @AppStorage で保持し自動補完
@AppStorage("lastUsedEmail") var savedEmail = ""

TextField("メール", text: $email)
    .onAppear { if email.isEmpty { email = savedEmail } }
```

---

## テスト手順

### VoiceOver（最低限の確認）
1. 設定 > アクセシビリティ > VoiceOver をオン
2. スワイプで全要素を順に確認（名前・役割・値・ヒントが正しいか）
3. ダブルタップでアクションが実行されるか確認
4. フォーカス順序が論理的か確認

### Xcode Accessibility Inspector
- Xcode > Open Developer Tool > Accessibility Inspector
- Color Contrast Calculator でコントラスト比を確認

### Dynamic Type
- 設定 > アクセシビリティ > さらに大きな文字 を最大に設定
- 全画面でテキストが読めレイアウトが崩れないことを確認
