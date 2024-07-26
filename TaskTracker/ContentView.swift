import SwiftUI

struct ContentView: View {
    @State private var logs: [ActivityLog] = []

    var body: some View {
        TabView {
            TaskTrackerView(logs: $logs)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            DataLogView(logs: $logs)
                .tabItem {
                    Label("Data Log", systemImage: "list.bullet")
                }

            DailyView(logs: $logs)
                .tabItem {
                    Label("Daily", systemImage: "calendar")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
