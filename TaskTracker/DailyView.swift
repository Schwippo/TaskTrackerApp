import SwiftUI

struct DailyView: View {
    @Binding var logs: [ActivityLog]
    @Binding var events: [Event]
    @State private var dailyLogs: [ActivityLog] = []

    var body: some View {
        VStack {
            Text("Tägliche Übersicht")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(dailyLogs) { log in
                    HStack {
                        Text("\(timeFormatter.string(from: log.start))")
                            .frame(width: 80, alignment: .leading)

                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(log.color)
                                .frame(width: CGFloat(log.end.timeIntervalSince(log.start)) / 3600 * 100, height: 20)
                                .overlay(Text(log.focus)
                                            .foregroundColor(.white)
                                            .padding(.leading, 5)
                                            .padding(.trailing, 5)
                                            .frame(maxWidth: .infinity, alignment: .leading))
                            Text("\(timeFormatter.string(from: log.start)) - \(timeFormatter.string(from: log.end))")
                        }
                    }
                    .padding(.vertical, 5)
                }

                ForEach(events) { event in
                    HStack {
                        Text("\(timeFormatter.string(from: event.timestamp))")
                            .frame(width: 80, alignment: .leading)

                        Rectangle()
                            .fill(event.color)
                            .frame(width: 100, height: 20)
                            .overlay(Text(event.name)
                                        .foregroundColor(.white)
                                        .padding(.leading, 5)
                                        .padding(.trailing, 5)
                                        .frame(maxWidth: .infinity, alignment: .leading))
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .onAppear {
            updateDailyLogs()
        }
    }

    private func updateDailyLogs() {
        let calendar = Calendar.current
        let today = Date()
        let startOfDay = calendar.startOfDay(for: today)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        dailyLogs = logs.filter { $0.start >= startOfDay && $0.end < endOfDay }
    }
}

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(logs: .constant([ActivityLog(focus: "Sport", start: Date().addingTimeInterval(-3600), end: Date(), color: .blue)]), events: .constant([]))
    }
}
