//
//  AccessibilitySampleAppUITests.swift
//  AccessibilitySampleAppUITests
//
//  Created by kajitani kento on 2026/03/07.
//

import XCTest

final class AccessibilitySampleAppUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - タスク一覧画面

    /// 起動直後にタスクタブが表示されている
    @MainActor
    func testTaskTabIsDisplayedOnLaunch() {
        _ = app.taskListScreen()
    }

    /// 初期タスクが一覧に表示されている
    @MainActor
    func testInitialTasksAreVisible() {
        let taskList = app.taskListScreen()
        XCTAssertTrue(app.staticTexts["牛乳を買う"].exists)
        XCTAssertTrue(app.staticTexts["メール返信"].exists)
        XCTAssertTrue(app.staticTexts["企画書作成"].exists)
        taskList.verify()
    }

    // MARK: - タスク詳細への遷移

    /// タスク行をタップするとタスク詳細画面に遷移する
    @MainActor
    func testTapTaskRowNavigatesToDetail() {
        app.taskListScreen()
            .tap(task: "牛乳を買う")
            .verify()
    }

    /// タスク詳細画面から戻るボタンでタスク一覧に戻る
    @MainActor
    func testBackButtonReturnsToTaskList() {
        app.taskListScreen()
            .tap(task: "牛乳を買う")
            .tapBack()
            .verify()
    }

    // MARK: - タスク追加シート

    /// 追加ボタンをタップするとタスク追加シートが表示される
    @MainActor
    func testAddButtonPresentsAddTaskSheet() {
        app.taskListScreen()
            .tapAddButton()
            .verify()
    }

    /// タスク追加シートのキャンセルボタンでシートが閉じる
    @MainActor
    func testCancelDismissesAddTaskSheet() {
        app.taskListScreen()
            .tapAddButton()
            .tapCancel()
            .verify()
    }

    // MARK: - フィルターシート

    /// フィルターボタンをタップするとフィルター選択シートが表示される
    @MainActor
    func testFilterButtonPresentsFilterSheet() {
        app.taskListScreen()
            .tapFilterButton()
            .verify()
    }

    /// フィルターシートの閉じるボタンでシートが閉じる
    @MainActor
    func testCloseDismissesFilterSheet() {
        app.taskListScreen()
            .tapFilterButton()
            .tapClose()
            .verify()
    }
}
