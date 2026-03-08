import SwiftUI
import UIKit

enum TaskFilter: String, CaseIterable, Identifiable {
    case all, active, completed

    var id: String { rawValue }

    var label: String {
        switch self {
        case .all: return "すべて"
        case .active: return "未完了"
        case .completed: return "完了"
        }
    }
}

struct TaskListView: View {
    @EnvironmentObject private var store: TaskStore

    @State private var filter: TaskFilter = .all
    @State private var isAddSheetOpen = false
    @State private var isFilterSheetOpen = false
    @State private var deleteTarget: TodoTask? = nil
    @State private var priorityTarget: TodoTask? = nil
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var filteredTasks: [TodoTask] {
        switch filter {
        case .all: return store.tasks
        case .active: return store.tasks.filter { !$0.completed }
        case .completed: return store.tasks.filter { $0.completed }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
                // フィルターボタン
                Button {
                    isFilterSheetOpen = true
                } label: {
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                            .accessibilityHidden(true)
                        Text("フィルター: \(filter.label)")
                            .font(DesignTokens.Font.bodySmallBold)
                            .foregroundStyle(DesignTokens.Color.textPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, DesignTokens.Spacing.md)
                    .frame(height: 36)
                    .background(DesignTokens.Color.surface)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                            .stroke(DesignTokens.Color.border, lineWidth: 1)
                    )
                }
                .frame(minHeight: DesignTokens.TouchTarget.minimum)
                .accessibilityLabel("フィルター: \(filter.label)。タップして変更")
                .padding(.horizontal, DesignTokens.Spacing.base)
                
                // 状態通知テストボタン
                HStack(spacing: DesignTokens.Spacing.sm) {
                    Button("読み込みテスト") { simulateLoading() }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                    Button("エラーテスト") { simulateError() }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                .padding(.horizontal, DesignTokens.Spacing.base)
                
                // ローディング
                if isLoading {
                    HStack(spacing: DesignTokens.Spacing.sm) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .accessibilityHidden(true)
                        Text("読み込み中")
                            .font(DesignTokens.Font.bodySmall)
                    }
                    .padding(DesignTokens.Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(DesignTokens.Color.primaryLight)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .padding(.horizontal, DesignTokens.Spacing.base)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("読み込み中")
                    .accessibilityAddTraits(.updatesFrequently)
                // エラー
                } else if let error = errorMessage {
                    HStack(alignment: .top, spacing: DesignTokens.Spacing.sm) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundStyle(DesignTokens.Color.danger)
                            .accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                            Text("エラー")
                                .font(DesignTokens.Font.bodySmallBold)
                                .foregroundStyle(DesignTokens.Color.danger)
                            Text(error)
                                .font(DesignTokens.Font.bodySmall)
                                .foregroundStyle(DesignTokens.Color.danger)
                            Button("再試行") {
                                errorMessage = nil
                                simulateLoading()
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.small)
                        }
                    }
                    .padding(DesignTokens.Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(DesignTokens.Color.dangerSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignTokens.Radius.md)
                            .stroke(DesignTokens.Color.danger.opacity(0.4), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.md))
                    .padding(.horizontal, DesignTokens.Spacing.base)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("エラー: \(error)")
                // タスクリスト
                } else if filteredTasks.isEmpty {
                    VStack(spacing: DesignTokens.Spacing.md) {
                        Text("タスクがありません")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                        HStack(spacing: DesignTokens.Spacing.sm) {
                            Button("読み込みテスト") { simulateLoading() }
                                .buttonStyle(.bordered)
                                .controlSize(.small)
                            Button("エラーテスト") { simulateError() }
                                .buttonStyle(.bordered)
                                .controlSize(.small)
                        }
                    }
                    .padding(DesignTokens.Spacing.xl)
                    .frame(maxWidth: .infinity)
                    .background(DesignTokens.Color.surface)
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
                    .padding(.horizontal, DesignTokens.Spacing.base)
                } else {
                    LazyVStack(spacing: DesignTokens.Spacing.md) {
                        ForEach(filteredTasks) { task in
                            TaskRowView(
                                task: task,
                                onToggle: { handleToggle(task) },
                                onDelete: { deleteTarget = task }
                            )
                        }
                    }
                    .padding(.horizontal, DesignTokens.Spacing.base)
                }
            }
            .padding(.top, DesignTokens.Spacing.md)
        }
        .navigationTitle("タスク")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddSheetOpen = true
                } label: {
                    Label("追加", systemImage: "plus")
                }
                .accessibilityLabel("タスクを追加")
            }
        }
        .background(DesignTokens.Color.background)
        // タスク追加 Sheet
        .sheet(isPresented: $isAddSheetOpen) {
            AddTaskSheet(isPresented: $isAddSheetOpen) { title, priority in
                store.add(title: title, priority: priority)
                announce("タスク「\(title)」を追加しました")
            }
        }
        // フィルター Sheet
        .sheet(isPresented: $isFilterSheetOpen) {
            FilterSheetView(currentFilter: $filter, isPresented: $isFilterSheetOpen)
        }
        // 削除確認 Alert
        .alert("タスクを削除しますか？", isPresented: Binding(
            get: { deleteTarget != nil },
            set: { if !$0 { deleteTarget = nil } }
        )) {
            Button("削除", role: .destructive) {
                if let task = deleteTarget {
                    store.delete(task)
                    announce("タスク「\(task.title)」を削除しました")
                    deleteTarget = nil
                }
            }
            Button("キャンセル", role: .cancel) {
                deleteTarget = nil
            }
        } message: {
            Text("この操作は取り消せません。")
        }
        // 優先度変更 ConfirmationDialog
        .confirmationDialog("優先度を選択", isPresented: Binding(
            get: { priorityTarget != nil },
            set: { if !$0 { priorityTarget = nil } }
        ), titleVisibility: .visible) {
            ForEach(Priority.allCases) { priority in
                Button(priority.label) {
                    if let task = priorityTarget {
                        store.changePriority(task, to: priority)
                        announce("タスク「\(task.title)」の優先度を\(priority.label)に変更しました")
                        priorityTarget = nil
                    }
                }
            }
            Button("キャンセル", role: .cancel) {
                priorityTarget = nil
            }
        }
    }

    // MARK: - Actions

    private func handleToggle(_ task: TodoTask) {
        store.toggle(task)
        let newStatus = !task.completed ? "完了" : "未完了"
        announce("タスク「\(task.title)」を\(newStatus)にしました")
    }

    private func simulateLoading() {
        isLoading = true
        errorMessage = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            announce("3件のタスクを読み込みました")
        }
    }

    private func simulateError() {
        isLoading = true
        errorMessage = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
            errorMessage = "通信エラーが発生しました"
        }
    }

    private func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
}

// MARK: - TaskRowView

struct TaskRowView: View {
    let task: TodoTask
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // コンテンツ上部（タップで詳細へ）
            NavigationLink(destination: TaskDetailView(task: task)) {
                HStack(alignment: .top, spacing: DesignTokens.Spacing.md) {
                    // 正方形チェックボックス
                    Button {
                        onToggle()
                    } label: {
                        SquareCheckbox(isChecked: task.completed)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(task.completed ? "完了済み。タップで未完了に戻す" : "未完了。タップで完了にする")
                    .padding(.top, DesignTokens.Spacing.xs)

                    // タスク情報
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
                        Text(task.title)
                            .font(DesignTokens.Font.bodyBold)
                            .foregroundStyle(task.completed ? DesignTokens.Color.textSecondary : DesignTokens.Color.textPrimary)
                            .strikethrough(task.completed, color: DesignTokens.Color.textSecondary)

                        HStack(spacing: DesignTokens.Spacing.sm) {
                            // 優先度バッジ
                            Text("優先度 \(task.priority.label)")
                                .font(DesignTokens.Font.captionBold)
                                .padding(.horizontal, DesignTokens.Spacing.sm)
                                .padding(.vertical, DesignTokens.Spacing.xs)
                                .background(task.priority.backgroundColor)
                                .foregroundStyle(task.priority.foregroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.sm))
                                .accessibilityHidden(true)

                            // 完了状態
                            Text(task.completed ? "完了" : "未完了")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(task.completed ? DesignTokens.Color.success : DesignTokens.Color.textSecondary)
                                .accessibilityHidden(true)
                        }
                    }

                    Spacer()
                    
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash")
                            .font(DesignTokens.Font.bodySmall)
                            .foregroundStyle(DesignTokens.Color.danger)
                            .frame(width: DesignTokens.TouchTarget.minimum, height: DesignTokens.TouchTarget.minimum)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("タスク「\(task.title)」を削除")
                }
                .padding(DesignTokens.Spacing.base)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .background(DesignTokens.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radius.lg))
        .overlay(
            RoundedRectangle(cornerRadius: DesignTokens.Radius.lg)
                .stroke(DesignTokens.Color.border, lineWidth: 1)
        )
        // VoiceOver まとめ読み上げ + カスタムアクション
        .accessibilityElement(children: .contain)
        .accessibilityLabel("タスク「\(task.title)」、優先度\(task.priority.label)、\(task.completed ? "完了" : "未完了")")
        .accessibilityAction(named: task.completed ? "未完了に戻す" : "完了にする") { onToggle() }
        .accessibilityAction(named: "削除") { onDelete() }
    }
}

// MARK: - SquareCheckbox

private struct SquareCheckbox: View {
    let isChecked: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DesignTokens.Radius.sm)
                .fill(isChecked ? DesignTokens.Color.textPrimary : DesignTokens.Color.background)
                .frame(width: 16, height: 16)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.Radius.sm)
                        .stroke(
                            isChecked ? DesignTokens.Color.textPrimary : DesignTokens.Color.border,
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
            if isChecked {
                Image(systemName: "checkmark")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(DesignTokens.Color.textOnPrimary)
            }
        }
        .accessibilityHidden(true)
    }
}

// MARK: - AddTaskSheet

struct AddTaskSheet: View {
    @Binding var isPresented: Bool
    let onSave: (String, Priority) -> Void

    @State private var title = ""
    @State private var priority: Priority = .medium
    @State private var titleError: String? = nil
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                        HStack {
                            Text("タスク名")
                                .font(DesignTokens.Font.bodySmallBold)
                            Text("必須")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityLabel("必須項目")
                        }
                        TextField("例: 牛乳を買う", text: $title)
                            .focused($isTitleFocused)
                            .accessibilityLabel("タスク名（必須）")
                            .accessibilityHint("タスクの名前を入力してください")
                            .onChange(of: title) { _, _ in titleError = nil }
                        if let error = titleError {
                            Label(error, systemImage: "exclamationmark.circle")
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.danger)
                                .accessibilityLabel("エラー: \(error)")
                        }
                    }
                } header: {
                    Text("タスク情報")
                }

                Section {
                    Picker("優先度", selection: $priority) {
                        ForEach(Priority.allCases) { p in
                            Text(p.label).tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityLabel("優先度を選択")
                } header: {
                    Text("優先度")
                }
            }
            .navigationTitle("タスクを追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        save()
                    }
                    .accessibilityLabel("タスクを保存")
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isTitleFocused = true
            }
        }
    }

    private func save() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            titleError = "タスク名を入力してください"
            UIAccessibility.post(notification: .announcement, argument: "エラー: タスク名を入力してください")
            return
        }
        onSave(title.trimmingCharacters(in: .whitespaces), priority)
        isPresented = false
    }
}

// MARK: - FilterSheetView

struct FilterSheetView: View {
    @Binding var currentFilter: TaskFilter
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            List {
                ForEach(TaskFilter.allCases) { filter in
                    Button {
                        currentFilter = filter
                        isPresented = false
                    } label: {
                        HStack {
                            Text(filter.label)
                                .foregroundStyle(DesignTokens.Color.textPrimary)
                            Spacer()
                            if currentFilter == filter {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(DesignTokens.Color.primary)
                                    .accessibilityHidden(true)
                            }
                        }
                    }
                    .accessibilityLabel(filter.label)
                    .accessibilityAddTraits(currentFilter == filter ? .isSelected : [])
                }
            }
            .navigationTitle("フィルター選択")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("閉じる") {
                        isPresented = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
