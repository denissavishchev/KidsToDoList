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
    var type: TaskType

    init(name: String,
         details: String,
         color: String,
         deadline: Date,
         status: Status,
         type: TaskType) {
        self.name = name
        self.details = details
        self.color = color
        self.deadline = deadline
        self.status = status
        self.type = type
    }
}

enum Status: String, Codable, CaseIterable {
    case done = "Done"
    case inProgress = "In Progress"
    case archive = "Archive"
}

enum TaskType: String, Codable, CaseIterable {
    case school = "School"
    case hobby = "Hobby"
    case family = "Family"
    case friends = "Friends"
}
