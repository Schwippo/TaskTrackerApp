import SwiftUI

struct FocusStatisticsView: View {
    var focus: String
    var logs: [ActivityLog]
    
    var body: some View {
        VStack {
            Text("\(focus) Statistiken")
                .font(.largeTitle)
                .padding()
            
            WeeklyBarChartView(focus: focus, logs: logs)
                .padding()
            
            Spacer()
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
