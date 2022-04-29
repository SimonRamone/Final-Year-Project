import Foundation
import SwiftUI

struct Badge: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var achieveBy: String
    var image: String
    var earned: Bool
    
    init(id: UUID = UUID(), title: String, description: String, achieveBy: String, image:String, earned:Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.achieveBy = achieveBy
        self.image = image
        self.earned = earned
    }
}

extension Badge {
    struct Data {
        var title: String = ""
        var description: String = ""
        var achieveBy: String = ""
        var image: String = ""
    }
    
    var data: Data {
        Data(title: title, description: description, image: image)
    }
    
}

extension Badge {
    static let sampleData: [Badge] =
    [
        Badge(title: "Badge 1", description: "Well done! You completed the first lesson.", achieveBy: "Complete first lesson.", image: "badge0", earned: false),
        Badge(title: "Badge 2", description: "Well done! You completed the second lesson.", achieveBy: "Complete second lesson.", image: "badge1", earned: false),
        Badge(title: "Badge 3", description: "Well done! You completed the third lesson.", achieveBy: "Complete third lesson.", image: "badge2", earned: false),
        Badge(title: "Badge 4", description: "Well done! You completed the second lesson.", achieveBy: "Complete second lesson.", image: "badge3", earned: false),
        Badge(title: "Badge 5", description: "Well done! You completed the third lesson.", achieveBy: "Complete third lesson.", image: "badge4", earned: false)
    ]
}
