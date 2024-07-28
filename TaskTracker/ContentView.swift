import SwiftUI

struct ContentView: View {
    @State private var focuses: [Focus] = [Focus(name: "Sport", color: .blue)]
    @State private var events: [Event] = []
    @State private var logs: [ActivityLog] = []

    var body: some View {
        TabView {
            TaskTrackerView(logs: $logs, focuses: $focuses, events: $events)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FocusStatisticsView(focus: "Sport", logs: logs)
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar")
                }

            DailyView(logs: $logs, events: $events)
                .tabItem {
                    Label("Daily", systemImage: "calendar")
                }

            DataLogView(focuses: $focuses, events: $events)
                .tabItem {
                    Label("Data Log", systemImage: "doc.text")
                }

            AddFocusView(focuses: $focuses, events: $events)
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
