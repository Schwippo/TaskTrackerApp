import SwiftUI

struct AddFocusView: View {
    @Binding var focuses: [Focus]
    @Binding var events: [Event]
    @State private var focusName: String = ""
    @State private var selectedColor: Color = .blue
    @State private var isEvent: Bool = false
    
    var body: some View {
        VStack {
            TextField("Name", text: $focusName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            ColorPicker("Farbe", selection: $selectedColor)
                .padding()
            
            Toggle("Ereignis", isOn: $isEvent)
                .padding()
            
            Button(action: {
                if isEvent {
                    let newEvent = Event(name: focusName, timestamp: Date(), color: selectedColor)
                    events.append(newEvent)
                } else {
                    let newFocus = Focus(name: focusName, color: selectedColor)
                    focuses.append(newFocus)
                }
                focusName = ""
            }) {
                Text("Hinzufügen")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct AddFocusView_Previews: PreviewProvider {
    static var previews: some View {
        AddFocusView(focuses: .constant([Focus(name: "Sport", color: .blue)]), events: .constant([]))
    }
}
