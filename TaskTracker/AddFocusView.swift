import SwiftUI

struct AddFocusView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var customFocuses: [Focus]
    @State private var focusName: String = ""
    @State private var selectedColor: Color = .blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fokus-Name")) {
                    TextField("Name", text: $focusName)
                }
                
                Section(header: Text("Fokus-Farbe")) {
                    ColorPicker("Wähle eine Farbe", selection: $selectedColor)
                }
                
                Button(action: addFocus) {
                    Text("Hinzufügen")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Eigene Fokus hinzufügen")
            .navigationBarItems(trailing: Button("Abbrechen") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    func addFocus() {
        let newFocus = Focus(id: UUID(), name: focusName, color: selectedColor)
        customFocuses.append(newFocus)
        presentationMode.wrappedValue.dismiss()
    }
}

struct Focus: Identifiable {
    var id: UUID
    var name: String
    var color: Color
}

struct AddFocusView_Previews: PreviewProvider {
    static var previews: some View {
        AddFocusView(customFocuses: .constant([]))
    }
}
