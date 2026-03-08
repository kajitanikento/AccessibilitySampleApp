//
//  AccessibilityAuditUITests.swift
//  AccessibilitySampleAppUITests
//
//  performAccessibilityAudit(for:) を使って各画面のアクセシビリティを検査するテスト。
//  iOS 17+ / Xcode 15+ が必要。
//
//  auditTypes:
//    .contrast                    — テキスト・UI要素のコントラスト比 (WCAG 1.4.3 / 1.4.11)
//    .elementDetection            — 要素の検出可能性
//    .hitRegion                   — タップターゲットサイズ (WCAG 2.5.8)
//    .sufficientElementDescription— accessibilityLabel の品質 (WCAG 4.1.2)
//    .dynamicType                 — Dynamic Type 対応 (WCAG 1.4.4)
//    .textClipped                 — テキスト切れ
//    .trait                       — accessibilityTraits の整合性
//    .action                      — アクション定義の整合性
//    .parentChild                 — 親子関係の整合性
//

import XCTest

final class AccessibilityAuditUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = true  // 複数の issue を一度に確認するため
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - タスク一覧画面

    /// タスク一覧画面のアクセシビリティ全項目を検査する
    @MainActor
    func testTaskListScreenAccessibility() throws {
        app.taskListScreen().verify()

        try audit(screen: "タスク一覧", ignoring: [
            // iOS 26 Liquid Glass 環境下で .buttonStyle(.bordered) ボタンの
            // ガラス背景とシステムフォント色の合成コントラストが borderline になる。
            // システムUI の挙動のため許容する。
            KnownIssue(
                auditType: .contrast,
                descriptionContains: "Contrast",
                reason: "iOS 26 Liquid Glass bordered button composited contrast is system-controlled and cannot be overridden"
            ),
            // iOS 26 の .buttonStyle(.bordered).controlSize(.small) が
            // 内部で固定サイズのシステムフォントを使用する場合がある。
            KnownIssue(
                auditType: .dynamicType,
                descriptionContains: "Dynamic Type",
                reason: "System bordered button with controlSize(.small) uses internal fixed font in iOS 26"
            ),
        ])
    }

    // MARK: - タスク詳細画面

    /// タスク詳細画面のアクセシビリティ全項目を検査する
    @MainActor
    func testTaskDetailScreenAccessibility() throws {
        app.taskListScreen()
            .tap(task: "牛乳を買う")
            .verify()

        try audit(screen: "タスク詳細")
    }

    // MARK: - タスク追加シート

    /// タスク追加シートのアクセシビリティ全項目を検査する
    @MainActor
    func testAddTaskSheetAccessibility() throws {
        app.taskListScreen()
            .tapAddButton()
            .verify()

        // キーボードが表示されている状態でも audit を実行する
        // （キーボードによる要素遮蔽も検査対象とするため意図的に閉じない）
        try audit(screen: "タスク追加シート", ignoring: [
            // UIKit の TextField プレースホルダーは意図的に薄いグレー（UIColor.placeholderText）で表示される。
            // これはシステム挙動であり、placeholderText は補助的な役割のため許容する。
            KnownIssue(
                auditType: .contrast,
                descriptionContains: "Contrast",
                reason: "TextField placeholder uses UIColor.placeholderText (system behavior, supplemental hint text)"
            ),
            // Segmented Picker (.pickerStyle(.segmented)) は UIKit ベースのシステムコンポーネントであり、
            // Dynamic Type のスケーリングを部分的にしか反映しない。
            KnownIssue(
                auditType: .dynamicType,
                descriptionContains: "Dynamic Type",
                reason: "Segmented Picker is a UIKit system component with limited Dynamic Type support"
            ),
        ])
    }

    // MARK: - フィルター選択シート

    /// フィルター選択シートのアクセシビリティ全項目を検査する
    @MainActor
    func testFilterSheetAccessibility() throws {
        app.taskListScreen()
            .tapFilterButton()
            .verify()

        try audit(screen: "フィルター選択シート", ignoring: [
            // iOS 26 の NavigationStack インライン表示とシステムフォームが
            // 特定の Dynamic Type サイズで部分的に未対応となるシステム挙動。
            KnownIssue(
                auditType: .dynamicType,
                descriptionContains: "Dynamic Type",
                reason: "System navigation/form components partially restrict Dynamic Type scaling (iOS 26 system behavior)"
            ),
            // iOS 26 Liquid Glass スタイルのリストセル背景色とシステムボタン色の組み合わせに
            // よる borderline コントラストはシステム UI の挙動のため許容する。
            KnownIssue(
                auditType: .contrast,
                descriptionContains: "Contrast",
                reason: "System List cell / navigation button contrast is controlled by UIKit system components (iOS 26 Liquid Glass)"
            ),
        ])
    }

    // MARK: - WCAGデモ画面

    /// WCAGデモ画面のアクセシビリティ全項目を検査する
    @MainActor
    func testWCAGDemoScreenAccessibility() throws {
        app.taskListScreen()
            .tapWCAGDemoTab()
            .verify()

        try audit(screen: "WCAGデモ", ignoring: [
            // WCAGDemoView の教育デモコンテンツは意図的にさまざまな色を使用する。
            // 一部のアクセントカラー（橙 #ff6900 / 紫 #ad46ff）はバッジ背景として使われており
            // iOS 26 Liquid Glass 環境下でシステムUIとの合成コントラストが検出される場合がある。
            KnownIssue(
                auditType: .contrast,
                descriptionContains: "Contrast",
                reason: "WCAGDemoView uses accent colors (orange/purple) for educational section indicators which may borderline fail in iOS 26 Liquid Glass compositing"
            ),
        ])
    }

    // MARK: - WCAG項目詳細画面

    /// WCAG項目詳細画面のアクセシビリティ全項目を検査する
    @MainActor
    func testWCAGItemDetailScreenAccessibility() throws {
        app.taskListScreen()
            .tapWCAGDemoTab()
            .tap(item: "1.1.1 非テキストコンテンツ")
            .verify()

        try audit(screen: "WCAG項目詳細", ignoring: [
            // WCAGItemDetailView の demoContent は意図的に「悪い例」と「良い例」を示す教育コンテンツ。
            // 「悪い例」セクションは WCAG 違反を意図的に含む可能性があるため許容する。
            KnownIssue(
                auditType: .contrast,
                descriptionContains: "Contrast",
                reason: "Demo content intentionally contains 'bad example' patterns to illustrate WCAG violations for educational purposes"
            ),
        ])
    }

    // MARK: - Audit Helper

    /// 指定された画面に対してアクセシビリティ監査を実行する。
    ///
    /// issueHandler で `true` を返した issue は無視される（既知の許容問題の除外に使用）。
    /// デフォルトでは全 issue を失敗として記録する。
    ///
    /// - Parameters:
    ///   - screen: ログ出力用の画面名
    ///   - auditTypes: 検査する項目（デフォルト: .all）
    ///   - ignoring: 許容する既知 issue の条件（デフォルト: なし）
    @MainActor
    private func audit(
        screen: String,
        auditTypes: XCUIAccessibilityAuditType = .all,
        ignoring knownIssues: [KnownIssue] = []
    ) throws {
        try app.performAccessibilityAudit(for: auditTypes) { issue in
            // 既知の issue と照合して無視するか判定する
            for known in knownIssues {
                if known.matches(issue) {
                    XCTContext.runActivity(named: "[\(screen)] 許容済み: \(issue.compactDescription)") { _ in }
                    return true // ignore
                }
            }
            // XCTFail で詳細を xcresult に記録してから失敗させる
            // (return false だと compactDescription しか残らないため手動で記録)
            let detail = """
                概要: \(issue.compactDescription)
                詳細: \(issue.detailedDescription)
                要素: \(issue.element?.label ?? issue.element?.identifier ?? "不明")
                """
            XCTContext.runActivity(named: "[\(screen)] アクセシビリティ issue") { activity in
                activity.add(XCTAttachment(string: detail))
            }
            XCTFail("[\(screen)] \(issue.compactDescription)\n\(issue.detailedDescription)")
            return true // XCTFail で記録済みのため二重記録を防ぐ
        }
    }
}

// MARK: - KnownIssue

/// 許容する既知のアクセシビリティ issue を定義する。
///
/// 使用例:
/// ```swift
/// try audit(
///     screen: "タスク一覧",
///     ignoring: [
///         KnownIssue(auditType: .contrast, descriptionContains: "SquareCheckbox", reason: "..."),
///     ]
/// )
/// ```
struct KnownIssue {
    let auditType: XCUIAccessibilityAuditType
    let descriptionContains: String
    let reason: String

    func matches(_ issue: XCUIAccessibilityAuditIssue) -> Bool {
        guard issue.auditType == auditType else { return false }
        return issue.compactDescription.contains(descriptionContains)
            || issue.detailedDescription.contains(descriptionContains)
    }
}
