import Foundation
import SwiftUI

struct Event: Identifiable {
    var id = UUID()
    var name: String
    var timestamp: Date
    var color: Color
}

