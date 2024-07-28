import SwiftUI

struct DataLogView: View {
    @Binding var focuses: [Focus]
    @Binding var events: [Event]
    
    var body: some View {
        VStack {
            Text("Daten-Log")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(focuses) { focus in
                    VStack(alignment: .leading) {
                        Text(focus.name)
                            .font(.headline)
                            .padding(.top)
                        
                        WeeklyBarChartView(focus: focus.name, logs: []) // Placeholder logs, should be filtered logs for this focus
                        
                        Text("Gesamtzeit: ...") // Placeholder, calculate total time for this focus
                    }
                    .padding(.bottom)
                }
                
                ForEach(events) { event in
                    HStack {
                        Text(event.timestamp, style: .time)
                        Text(event.name)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}

struct DataLogView_Previews: PreviewProvider {
    static var previews: some View {
        DataLogView(focuses: .constant([Focus(name: "Sport", color: .blue)]), events: .constant([]))
    }
}
