import SwiftData
import Foundation

@Model
class Task {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var details: String
    var color: String
    var deadline: Date
    var status: Status
    var image: String

    init(name: String = "",
         details: String = "",
         color: String = "",
         deadline: Date = .now,
         status: Status = .inProgress,
         image: String = ""
    ) {
        self.name = name
        self.details = details
        self.color = color
        self.deadline = deadline
        self.status = status
        self.image = image
    }
}

enum Status: String, Codable, CaseIterable {
    case done = "Done"
    case inProgress = "In Progress"
    case archive = "Archive"
}

