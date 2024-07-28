import SwiftUI

struct Focus: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var color: Color
    
    static func == (lhs: Focus, rhs: Focus) -> Bool {
        return lhs.id == rhs.id
    }
}
