import Foundation
import SwiftUI

struct Story: Identifiable, Codable {
    let id = UUID()
    let title: String
    let subtitle: String
    let coverImage: String
    let unlocks: [String]
    let slides: [Slide]
    var isCompleted: Bool = false
    
    init(title: String, subtitle: String, coverImage: String, unlocks: [String], slides: [Slide]) {
        self.title = title
        self.subtitle = subtitle
        self.coverImage = coverImage
        self.unlocks = unlocks
        self.slides = slides
    }
    
    init() {
        self.title = ""
        self.subtitle = ""
        self.coverImage = ""
        self.unlocks = []
        self.slides = []
    }
    
    private enum CodingKeys : String, CodingKey { case title, subtitle, coverImage, unlocks, slides}
}

extension Story {
    struct Slide: Codable {
        let image: String
        let caption: String
    }
}

extension Story {
    static let sampleData: Story = Story(title: "Lesson 1", subtitle: "Methane Emissions", coverImage: "cows", unlocks: ["Badge 1"], slides: [Slide(image: "lesson 1-1", caption: "THis is the first slide"), Slide(image: "lesson 1-2", caption: "THis is the second slide")])
    static let stories: [Story] = []
//    [
//        Lesson(title: "Lesson 1", subtitle: "Methane Emissions", coverImage: "cows", slides: [Slide(image: "lessons 1-1", caption: "THis is the first slide"), Slide(image: "secondImage", caption: "THis is the second slide")]),
//        Lesson(title: "Lesson 2", subtitle: "Air Travel", coverImage: "airplane", slides: [Slide(image: "3rdimage", caption: "THis is the 3rd slide"), Slide(image: "4thimage", caption: "THis is the 4th slide")])
//    ]
//        Lesson(title: "Lesson 3", subtitle: "Insulating Your Home", coverImage: "insulation"),
//    ]
}
