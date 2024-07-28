import SwiftUI

struct TaskDetailView: View {
    var focus: Focus
    @Binding var startTime: Date?
    @Binding var logs: [ActivityLog]
    @Binding var focuses: [Focus]

    @State private var elapsedTime: TimeInterval = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text(focus.name)
                .font(.largeTitle)
                .padding()

            Text(timeString(from: elapsedTime))
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()

            Spacer()

            Button(action: {
                if let start = startTime {
                    let log = ActivityLog(focus: focus.name, start: start, end: Date(), color: focus.color)
                    logs.append(log)
                    startTime = nil
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Stop")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                if let index = focuses.firstIndex(where: { $0.id == focus.id }) {
                    focuses.remove(at: index)
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Löschen")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                startTime = nil
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Abbrechen")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Zurück")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        }
    }

    func timeString(from time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(focus: Focus(name: "Sport", color: .blue), startTime: .constant(Date()), logs: .constant([]), focuses: .constant([Focus(name: "Sport", color: .blue)]))
    }
}
