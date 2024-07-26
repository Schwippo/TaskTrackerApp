import SwiftUI

struct DataLogView: View {
    @Binding var logs: [ActivityLog]
    @State private var focusStatistics: [String: [Double]] = [:]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(Set(logs.map { $0.focus })), id: \.self) { focus in
                    NavigationLink(destination: FocusStatisticsView(focus: focus, logs: logs)) {
                        VStack(alignment: .leading) {
                            Text(focus)
                                .font(.headline)
                            
                            WeeklyBarChartView(focus: focus, logs: logs)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Data Log")
        }
        .onAppear {
            calculateFocusStatistics()
        }
    }
    
    private func calculateFocusStatistics() {
        var stats: [String: [Double]] = [:]
        
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        let startOfWeekDate = calendar.date(from: startOfWeek)!
        
        for log in logs {
            let focus = log.focus
            let startOfLogWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: log.start)
            let startOfLogWeekDate = calendar.date(from: startOfLogWeek)!
            
            if startOfWeekDate == startOfLogWeekDate {
                let duration = log.end.timeIntervalSince(log.start)
                let dayOfWeek = calendar.component(.weekday, from: log.start) - 1
                let hours = duration / 3600
                let minutes = (duration.truncatingRemainder(dividingBy: 3600)) / 60
                
                if stats[focus] == nil {
                    stats[focus] = Array(repeating: 0.0, count: 7)
                }
                stats[focus]?[dayOfWeek] += hours + (minutes / 60)
            }
        }
        
        focusStatistics = stats
    }
}

struct WeeklyBarChartView: View {
    var focus: String
    var logs: [ActivityLog]
    @State private var dailyHours: [Double] = Array(repeating: 0.0, count: 7)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Wöchentliche Übersicht")
                .font(.subheadline)
                .padding(.bottom)
            
            HStack {
                ForEach(0..<7, id: \.self) { index in
                    VStack {
                        Text("\(Int(dailyHours[index])) h")
                            .font(.caption)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 20, height: CGFloat(dailyHours[index]) * 20)
                    }
                }
            }
        }
        .onAppear {
            updateDailyHours()
        }
    }
    
    private func updateDailyHours() {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        let startOfWeekDate = calendar.date(from: startOfWeek)!
        
        dailyHours = Array(repeating: 0.0, count: 7)
        
        for log in logs {
            let startOfLogWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: log.start)
            let startOfLogWeekDate = calendar.date(from: startOfLogWeek)!
            
            if startOfWeekDate == startOfLogWeekDate, log.focus == focus {
                let duration = log.end.timeIntervalSince(log.start)
                let dayOfWeek = calendar.component(.weekday, from: log.start) - 1
                let hours = duration / 3600
                let minutes = (duration.truncatingRemainder(dividingBy: 3600)) / 60
                
                dailyHours[dayOfWeek] += hours + (minutes / 60)
            }
        }
    }
}

struct DataLogView_Previews: PreviewProvider {
    static var previews: some View {
        DataLogView(logs: .constant([]))
    }
}
