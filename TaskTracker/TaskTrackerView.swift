import SwiftUI

struct TaskTrackerView: View {
    @Binding var logs: [ActivityLog]
    @Binding var focuses: [Focus]
    @Binding var events: [Event]
    
    @State private var selectedFocus: Focus?
    @State private var startTime: Date?
    @State private var isShowingDetail = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Task Tracker")
                    .font(.largeTitle)
                    .padding()
                
                List {
                    ForEach(focuses) { focus in
                        HStack {
                            Circle()
                                .fill(focus.color)
                                .frame(width: 20, height: 20)
                            
                            Text(focus.name)
                            
                            Spacer()
                            
                            if startTime == nil {
                                Button(action: {
                                    startTime = Date()
                                    selectedFocus = focus
                                }) {
                                    Text("Start")
                                        .padding(5)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            } else if selectedFocus == focus {
                                NavigationLink(destination: TaskDetailView(focus: focus, startTime: $startTime, logs: $logs, focuses: $focuses)) {
                                    Text("Details")
                                        .padding(5)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                
                HStack {
                    Button(action: {
                        let newEvent = Event(name: "New Event", timestamp: Date(), color: .gray)
                        events.append(newEvent)
                    }) {
                        Text("Ereignis hinzufügen")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    Button(action: {
                        let newFocus = Focus(name: "New Focus", color: .green)
                        focuses.append(newFocus)
                    }) {
                        Text("Fokus hinzufügen")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct TaskTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTrackerView(logs: .constant([]), focuses: .constant([Focus(name: "Sport", color: .blue)]), events: .constant([]))
    }
}
