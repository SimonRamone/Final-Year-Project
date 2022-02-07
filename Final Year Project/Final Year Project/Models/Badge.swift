import Foundation
import SwiftUI

struct Badge: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var image: String
    var earned: Bool
    
    init(id: UUID = UUID(), title: String, description: String, image:String, earned:Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.earned = earned
    }
}

extension Badge {
    static let sampleData: [Badge] =
    [
        Badge(title: "Badge 1", description: "Methane Emissions", image: "badge0", earned: true),
        Badge(title: "Badge 2", description: "Methane Emissions", image: "badge1", earned: true),
        Badge(title: "Badge 3", description: "Methane Emissions", image: "badge2", earned: false),
        Badge(title: "Badge 4", description: "Methane Emissions", image: "badge3", earned: false)

    ]
}
