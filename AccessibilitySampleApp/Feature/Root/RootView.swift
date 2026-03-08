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
                ImplementationSamplesView()
            }
            .tabItem {
                Label("実装サンプル", systemImage: "list.bullet.clipboard")
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
