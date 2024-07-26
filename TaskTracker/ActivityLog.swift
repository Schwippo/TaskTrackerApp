import Foundation
import SwiftUI

struct ActivityLog: Identifiable {
    let id = UUID()
    let focus: String
    let start: Date
    let end: Date
    let color: Color
    
    var durationString: String {
        let duration = end.timeIntervalSince(start)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
