import SwiftUI
import Combine

// MARK: - Color hex extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b)
    }
}

enum Priority: String, CaseIterable, Identifiable {
    case low, medium, high

    var id: String { rawValue }

    var label: String {
        switch self {
        case .low: return "低"
        case .medium: return "中"
        case .high: return "高"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .low:    return DesignTokens.Color.background
        case .medium: return DesignTokens.Color.warningSurface
        case .high:   return DesignTokens.Color.dangerSurface
        }
    }

    var foregroundColor: Color {
        switch self {
        case .low:    return DesignTokens.Color.textSecondary
        case .medium: return DesignTokens.Color.warning
        case .high:   return DesignTokens.Color.danger
        }
    }
}

struct TodoTask: Identifiable {
    let id: UUID
    var title: String
    var priority: Priority
    var completed: Bool
    var description: String

    init(id: UUID = UUID(), title: String, priority: Priority, completed: Bool = false, description: String = "") {
        self.id = id
        self.title = title
        self.priority = priority
        self.completed = completed
        self.description = description
    }
}

@MainActor
final class TaskStore: ObservableObject {
    @Published var tasks: [TodoTask] = [
        TodoTask(title: "牛乳を買う", priority: .high, completed: false, description: "近所のスーパーで低脂肪牛乳を購入する。"),
        TodoTask(title: "メール返信", priority: .low, completed: true, description: "田中さんからのメールに返信する。"),
        TodoTask(title: "企画書作成", priority: .medium, completed: false, description: "新規プロジェクトの企画書を作成する。締め切りは金曜日。"),
    ]

    func toggle(_ task: TodoTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].completed.toggle()
    }

    func delete(_ task: TodoTask) {
        tasks.removeAll { $0.id == task.id }
    }

    func add(title: String, priority: Priority, description: String = "") {
        let task = TodoTask(title: title, priority: priority, description: description)
        tasks.append(task)
    }

    func moveUp(_ task: TodoTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }), index > 0 else { return }
        tasks.swapAt(index - 1, index)
    }

    func moveDown(_ task: TodoTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }), index < tasks.count - 1 else { return }
        tasks.swapAt(index, index + 1)
    }

    func changePriority(_ task: TodoTask, to priority: Priority) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].priority = priority
    }
}
