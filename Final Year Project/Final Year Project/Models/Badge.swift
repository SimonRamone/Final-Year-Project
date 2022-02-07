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
    struct Data {
        var title: String = ""
        var description: String = ""
        var image: String = ""
    }
    
    var data: Data {
        Data(title: title, description: description, image: image)
    }
    
}

extension Badge {
    static let sampleData: [Badge] =
    [
        Badge(title: "Badge 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec posuere risus massa, eu pharetra ipsum pretium non. Nunc id mi sed ante maximus iaculis. Phasellus at ante a magna luctus tempor id ac eros. Nullam venenatis id sapien fermentum scelerisque. Mauris a leo turpis. Ut eget imperdiet augue. Vivamus vulputate quis felis ac cursus.", image: "badge0", earned: true),
        Badge(title: "Badge 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec posuere risus massa, eu pharetra ipsum pretium non. Nunc id mi sed ante maximus iaculis. Phasellus at ante a magna luctus tempor id ac eros. Nullam venenatis id sapien fermentum scelerisque. Mauris a leo turpis. Ut eget imperdiet augue. Vivamus vulputate quis felis ac cursus.", image: "badge1", earned: true),
        Badge(title: "Badge 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec posuere risus massa, eu pharetra ipsum pretium non. Nunc id mi sed ante maximus iaculis. Phasellus at ante a magna luctus tempor id ac eros. Nullam venenatis id sapien fermentum scelerisque. Mauris a leo turpis. Ut eget imperdiet augue. Vivamus vulputate quis felis ac cursus.", image: "badge2", earned: false),
        Badge(title: "Badge 4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec posuere risus massa, eu pharetra ipsum pretium non. Nunc id mi sed ante maximus iaculis. Phasellus at ante a magna luctus tempor id ac eros. Nullam venenatis id sapien fermentum scelerisque. Mauris a leo turpis. Ut eget imperdiet augue. Vivamus vulputate quis felis ac cursus.", image: "badge3", earned: false)

    ]
}
