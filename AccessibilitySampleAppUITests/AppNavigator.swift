//
//  AppNavigator.swift
//  AccessibilitySampleAppUITests
//
//  アプリ内の遷移をPage Object Modelで管理するヘルパー。
//  各Screenが自身から遷移可能な画面のみをメソッドとして公開するため、
//  存在しない遷移（例: タスク一覧からWCAG項目詳細へ直接遷移）はコンパイルエラーになる。
//
//  ナビゲーショングラフ:
//
//  [TabBar]
//    ├─ TaskListScreen
//    │    ├─ tap(task:) ──────────────────────────────► TaskDetailScreen
//    │    │                                                  └─ tapBack() ──► TaskListScreen
//    │    ├─ tapAddButton() ──────────────────────────► AddTaskSheetScreen
//    │    │                                                  ├─ tapCancel() ─► TaskListScreen
//    │    │                                                  └─ tapSave() ───► TaskListScreen
//    │    ├─ tapFilterButton() ─────────────────────► FilterSheetScreen
//    │    │                                                  ├─ tapClose() ──► TaskListScreen
//    │    │                                                  └─ select(_:) ──► TaskListScreen
//    │    └─ tapWCAGDemoTab() ──────────────────────► WCAGDemoScreen
//    │
//    └─ WCAGDemoScreen
//         ├─ tap(item:) ──────────────────────────────► WCAGItemDetailScreen
//         │                                                  └─ tapBack() ──► WCAGDemoScreen
//         └─ tapTaskTab() ────────────────────────────► TaskListScreen
//

import XCTest

// MARK: - Base Protocol

protocol AppScreen {
    var app: XCUIApplication { get }
}

// MARK: - Entry Point

extension XCUIApplication {
    /// アプリ起動直後のタスク一覧画面を取得する
    func taskListScreen(timeout: TimeInterval = 3) -> TaskListScreen {
        let screen = TaskListScreen(app: self)
        screen.verify(timeout: timeout)
        return screen
    }
}

// MARK: - TaskListScreen

/// タスク一覧画面 (NavigationStack > TaskListView)
struct TaskListScreen: AppScreen {
    let app: XCUIApplication

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        XCTAssertTrue(
            app.navigationBars["タスク"].waitForExistence(timeout: timeout),
            "タスク一覧画面が表示されていません"
        )
        return self
    }

    // MARK: Push遷移 → TaskDetailScreen

    /// タスク行をタップしてタスク詳細画面へ遷移する
    func tap(task title: String) -> TaskDetailScreen {
        app.staticTexts[title].tap()
        return TaskDetailScreen(app: app, taskTitle: title)
    }

    // MARK: Sheet遷移 → AddTaskSheetScreen

    /// ナビバー右の「タスクを追加」ボタンをタップしてタスク追加シートを表示する
    func tapAddButton() -> AddTaskSheetScreen {
        // iOS 26 では navigationBars 経由が不安定なため accessibilityLabel で直接検索
        app.buttons.matching(NSPredicate(format: "label == 'タスクを追加'")).firstMatch.tap()
        return AddTaskSheetScreen(app: app)
    }

    // MARK: Sheet遷移 → FilterSheetScreen

    /// フィルターボタンをタップしてフィルター選択シートを表示する
    func tapFilterButton() -> FilterSheetScreen {
        app.buttons
            .matching(NSPredicate(format: "label BEGINSWITH 'フィルター:'"))
            .firstMatch
            .tap()
        return FilterSheetScreen(app: app)
    }

    // MARK: タブ切り替え → WCAGDemoScreen

    /// WCAGデモタブをタップしてWCAGデモ画面へ切り替える
    func tapWCAGDemoTab() -> WCAGDemoScreen {
        app.tabBars.buttons["WCAGデモ"].tap()
        return WCAGDemoScreen(app: app)
    }
}

// MARK: - TaskDetailScreen

/// タスク詳細画面 (NavigationStack > TaskDetailView)
struct TaskDetailScreen: AppScreen {
    let app: XCUIApplication
    /// 遷移元のタスクタイトル（検証用）
    let taskTitle: String

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        XCTAssertTrue(
            app.navigationBars["タスク詳細"].waitForExistence(timeout: timeout),
            "タスク詳細画面が表示されていません"
        )
        XCTAssertTrue(
            app.staticTexts[taskTitle].exists,
            "詳細画面にタスクタイトル「\(taskTitle)」が表示されていません"
        )
        return self
    }

    // MARK: Pop遷移 → TaskListScreen

    /// 戻るボタンをタップしてタスク一覧へ戻る
    func tapBack() -> TaskListScreen {
        app.navigationBars["タスク詳細"].buttons.firstMatch.tap()
        return TaskListScreen(app: app)
    }
}

// MARK: - AddTaskSheetScreen

/// タスク追加シート (Sheet > NavigationStack > AddTaskSheet)
struct AddTaskSheetScreen: AppScreen {
    let app: XCUIApplication

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        // キーボード自動表示の影響で navigationBars が不安定なため、
        // シート固有のテキストフィールドで存在確認する
        XCTAssertTrue(
            app.textFields["タスク名（必須）"].waitForExistence(timeout: timeout),
            "タスク追加シートが表示されていません"
        )
        return self
    }

    // MARK: 入力操作（self を返してチェーン可能）

    /// タスク名テキストフィールドに入力する
    @discardableResult
    func typeTitle(_ title: String) -> Self {
        let field = app.textFields["タスク名（必須）"]
        field.tap()
        field.typeText(title)
        return self
    }

    /// 優先度セグメントを選択する（"低" / "中" / "高"）
    @discardableResult
    func selectPriority(_ label: String) -> Self {
        app.buttons[label].tap()
        return self
    }

    // MARK: Sheet閉じる → TaskListScreen

    /// 「キャンセル」をタップしてシートを閉じタスク一覧へ戻る
    func tapCancel() -> TaskListScreen {
        app.buttons.matching(NSPredicate(format: "label == 'キャンセル'")).firstMatch.tap()
        return TaskListScreen(app: app)
    }

    /// 「保存」をタップしてタスクを保存しタスク一覧へ戻る
    func tapSave() -> TaskListScreen {
        app.buttons["タスクを保存"].tap()
        return TaskListScreen(app: app)
    }
}

// MARK: - FilterSheetScreen

/// フィルター選択シート (Sheet > NavigationStack > FilterSheetView)
struct FilterSheetScreen: AppScreen {
    let app: XCUIApplication

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        XCTAssertTrue(
            app.navigationBars["フィルター選択"].waitForExistence(timeout: timeout),
            "フィルター選択シートが表示されていません"
        )
        return self
    }

    // MARK: Sheet閉じる → TaskListScreen

    /// 「閉じる」をタップしてシートを閉じタスク一覧へ戻る
    func tapClose() -> TaskListScreen {
        app.navigationBars["フィルター選択"].buttons["閉じる"].tap()
        return TaskListScreen(app: app)
    }

    /// フィルター項目を選択してシートを閉じタスク一覧へ戻る
    /// - Parameter label: "すべて" / "未完了" / "完了"
    func select(_ label: String) -> TaskListScreen {
        app.buttons[label].tap()
        return TaskListScreen(app: app)
    }
}

// MARK: - WCAGDemoScreen

/// WCAGデモ画面 (NavigationStack > WCAGDemoView)
struct WCAGDemoScreen: AppScreen {
    let app: XCUIApplication

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        XCTAssertTrue(
            app.navigationBars["WCAGデモ"].waitForExistence(timeout: timeout),
            "WCAGデモ画面が表示されていません"
        )
        return self
    }

    // MARK: Push遷移 → WCAGItemDetailScreen

    /// WCAG項目行をタップしてWCAG項目詳細画面へ遷移する
    /// - Parameter itemText: 行に表示されるテキスト（例: "1.1.1 非テキストコンテンツ"）
    func tap(item itemText: String) -> WCAGItemDetailScreen {
        app.staticTexts[itemText].tap()
        return WCAGItemDetailScreen(app: app, itemText: itemText)
    }

    // MARK: タブ切り替え → TaskListScreen

    /// タスクタブをタップしてタスク一覧へ切り替える
    func tapTaskTab() -> TaskListScreen {
        app.tabBars.buttons["タスク"].tap()
        return TaskListScreen(app: app)
    }
}

// MARK: - WCAGItemDetailScreen

/// WCAG項目詳細画面 (NavigationStack > WCAGItemDetailView)
struct WCAGItemDetailScreen: AppScreen {
    let app: XCUIApplication
    /// 遷移元の項目テキスト（ナビバータイトルの検証用）
    let itemText: String

    @discardableResult
    func verify(timeout: TimeInterval = 3) -> Self {
        XCTAssertTrue(
            app.navigationBars[itemText].waitForExistence(timeout: timeout),
            "WCAG項目詳細画面（\(itemText)）が表示されていません"
        )
        return self
    }

    // MARK: Pop遷移 → WCAGDemoScreen

    /// 戻るボタンをタップしてWCAGデモ一覧へ戻る
    func tapBack() -> WCAGDemoScreen {
        app.navigationBars[itemText].buttons.firstMatch.tap()
        return WCAGDemoScreen(app: app)
    }
}
