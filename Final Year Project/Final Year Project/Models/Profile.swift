import Foundation
import SwiftUI

struct Profile {
    var name: String
    var surname: String
    var image: String
    
    init(name: String, surname: String, image:String) {
        self.name = name
        self.surname = surname
        self.image = image
    }
}

extension Profile {
    static let sampleData: Profile = Profile(name: "Simonas", surname: "Ramonas", image: "default-avatar")
}
