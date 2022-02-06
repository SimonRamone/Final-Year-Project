import Foundation
import SwiftUI

struct Lesson: Identifiable {
    let id: UUID
    var title: String
    var subtitle: String
    var coverImage: String
    
    init(id: UUID = UUID(), title: String, subtitle: String, coverImage:String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coverImage = coverImage
    }
}

extension Lesson {
    static let sampleData: [Lesson] =
    [
        Lesson(title: "Lesson 1", subtitle: "Methane Emissions", coverImage: "cows"),
        Lesson(title: "Lesson 2", subtitle: "Air Travel", coverImage: "airplane"),
        Lesson(title: "Lesson 3", subtitle: "Insulating Your Home", coverImage: "insulation"),
    ]
}
