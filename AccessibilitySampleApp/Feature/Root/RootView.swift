import SwiftUI

struct RootView: View {
    @StateObject private var store = TaskStore()

    var body: some View {
        TabView {
            NavigationStack {
                TaskListView()
            }
            .tabItem {
                Label("タスク", systemImage: "checklist")
            }

            NavigationStack {
                WCAGDemoView()
            }
            .tabItem {
                Label("WCAGデモ", systemImage: "book")
            }
        }
        .tint(DesignTokens.Color.primary)
        .environmentObject(store)
    }
}

#Preview {
    RootView()
}
