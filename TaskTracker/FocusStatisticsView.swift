import SwiftUI

struct FocusStatisticsView: View {
    var focus: String
    var logs: [ActivityLog]
    
    @State private var dailyHours: [Double] = Array(repeating: 0.0, count: 7)
    
    var body: some View {
        VStack {
            Text("\(focus) Statistiken")
                .font(.largeTitle)
                .padding()
            
            WeeklyBarChartView(focus: focus, logs: logs)
                .padding()
            
            Spacer()
        }
        .onAppear {
            updateDailyHours()
        }
    }
    
    private func updateDailyHours() {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        guard let startOfWeekDate = calendar.date(from: startOfWeek) else { return }
        
        dailyHours = Array(repeating: 0.0, count: 7)
        
        for log in logs {
            let startOfLogWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: log.start)
            guard let startOfLogWeekDate = calendar.date(from: startOfLogWeek) else { continue }
            
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

struct FocusStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        FocusStatisticsView(focus: "Sport", logs: [
            ActivityLog(focus: "Sport", start: Date().addingTimeInterval(-3600), end: Date(), color: .blue),
            ActivityLog(focus: "Sport", start: Date().addingTimeInterval(-7200), end: Date().addingTimeInterval(-3600), color: .blue)
        ])
    }
}
