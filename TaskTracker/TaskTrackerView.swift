import SwiftUI

struct TaskTrackerView: View {
    @Binding var logs: [ActivityLog]
    @State private var selectedFocus: String? = nil
    @State private var startTime: Date? = nil
    @State private var timer: Timer? = nil
    @State private var elapsedTime: TimeInterval = 0
    @State private var customFocuses: [Focus] = []
    @State private var showAddFocusView = false
    @State private var currentDateTime = Date()
    @State private var selectedFocusColor: Color? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text("Aktuelle Uhrzeit und Datum:")
                    .font(.headline)
                    .padding(.top)

                Text(currentDateTimeString)
                    .font(.title)
                    .foregroundColor(.blue)
                    .bold()
                    .padding(.bottom)
                    .onAppear {
                        startDateTimeUpdater()
                    }

                Text("Wähle einen Fokus:")
                    .font(.largeTitle)
                    .padding()

                ScrollView {
                    VStack {
                        HStack {
                            FocusButton(focus: "Sport", color: .blue, action: { selectFocus("Sport", color: .blue) })
                            FocusButton(focus: "Lesen", color: .green, action: { selectFocus("Lesen", color: .green) })
                            FocusButton(focus: "Mahlzeit", color: .orange, action: { selectFocus("Mahlzeit", color: .orange) })
                        }
                        HStack {
                            FocusButton(focus: "Arbeit", color: .red, action: { selectFocus("Arbeit", color: .red) })
                            FocusButton(focus: "Laufen", color: .purple, action: { selectFocus("Laufen", color: .purple) })
                            FocusButton(focus: "Me-Time", color: .pink, action: { selectFocus("Me-Time", color: .pink) })
                        }
                        HStack {
                            FocusButton(focus: "Family-Time", color: .yellow, action: { selectFocus("Family-Time", color: .yellow) })
                        }
                        ForEach(customFocuses) { focus in
                            FocusButton(focus: focus.name, color: focus.color, action: { selectFocus(focus.name, color: focus.color) })
                        }
                    }
                }

                if let selectedFocus = selectedFocus, let color = selectedFocusColor {
                    Text("Fokus: \(selectedFocus)")
                        .font(.title)
                        .padding()

                    Text(timerString())
                        .font(.largeTitle)
                        .padding()

                    if selectedFocus == "Tabletten Einnahme" {
                        Button(action: trackTime) {
                            Text("Zeit tracken")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        if timer == nil {
                            Button(action: startTracking) {
                                Text("Starten")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        } else {
                            Button(action: stopTracking) {
                                Text("Beenden")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }

                List(logs) { log in
                    Text("\(log.focus) gestartet um \(log.start, formatter: dateFormatter) und beendet um \(log.end, formatter: dateFormatter) - Dauer: \(log.durationString)")
                }

                Button(action: { showAddFocusView.toggle() }) {
                    Text("Eigene Fokus hinzufügen")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showAddFocusView) {
                    AddFocusView(customFocuses: $customFocuses)
                }
            }
            .navigationTitle("Task Tracker")
        }
    }

    var currentDateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: currentDateTime)
    }

    func startDateTimeUpdater() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentDateTime = Date()
        }
    }

    func selectFocus(_ focus: String, color: Color) {
        selectedFocus = focus
        selectedFocusColor = color
        startTime = nil
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
    }

    func startTracking() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }

    func stopTracking() {
        if let start = startTime, let color = selectedFocusColor {
            let endTime = Date()
            let log = ActivityLog(focus: selectedFocus ?? "", start: start, end: endTime, color: color)
            logs.append(log)
            startTime = nil
            timer?.invalidate()
            timer = nil
            elapsedTime = 0
        }
    }

    func trackTime() {
        if let color = selectedFocusColor {
            let log = ActivityLog(focus: selectedFocus ?? "", start: Date(), end: Date(), color: color)
            logs.append(log)
        }
    }

    func timerString() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

struct FocusButton: View {
    var focus: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(focus)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct TaskTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTrackerView(logs: .constant([]))
    }
}
