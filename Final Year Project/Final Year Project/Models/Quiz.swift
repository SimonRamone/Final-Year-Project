//
//  Quiz.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 20/03/2022.
//

import Foundation
import SwiftUI


    
struct Quiz: Identifiable, Codable {
    let id = UUID()
    let title: String
    let subtitle: String
    let questions: [Question]
    var isComplete: Bool = false
    
    init(title: String, subtitle: String, questions: [Question]) {
        self.title = title
        self.subtitle = subtitle
        self.questions = questions
    }
    
    init() {
        self.title = ""
        self.subtitle = ""
        self.questions = []
    }
    
    //private enum CodingKeys : String, CodingKey { case title, subtitle, coverImage, slides}
}

extension Quiz {
    struct Question: Codable {
        let image: String
        let prompt: String
        let answers: [Answer]
    }
    
    struct Answer: Identifiable, Codable {
        let id = UUID()
        let text: String
        let isCorrect: Bool
    }
}

extension Quiz {
    static let sampleQuiz: Quiz = Quiz(title: "First Quiz", subtitle: "Methane Emissions",
                                       questions: [
                                        Question(image: "lesson 1-1", prompt: "This is the first question. This is the first question. This is the first question. This is the first question. This is the first question.",
                                                 answers: [
                                                    Answer(text: "Answer 1", isCorrect: true),
                                                    Answer(text: "Answer 2", isCorrect: false),
                                                    Answer(text: "Answer 3", isCorrect: false)
                                                 ]),
                                        Question(image: "lesson 1-2", prompt: "This is the second question. This is the first question. This is the first question.",
                                                 answers: [
                                                    Answer(text: "Answer 1", isCorrect: false),
                                                    Answer(text: "Answer 2", isCorrect: true)
                                                 ]),
                                        Question(image: "lesson 1-3", prompt: "This is the third question.",
                                                 answers: [
                                                    Answer(text: "Answer 1", isCorrect: false),
                                                    Answer(text: "Answer 2", isCorrect: true),
                                                    Answer(text: "Answer 3", isCorrect: false),
                                                    Answer(text: "Answer 4", isCorrect: false)
                                                 ])
                                       ])
    static let sampleData: [Quiz] = [Quiz(title: "First Quiz", subtitle: "Methane Emissions",
                                          questions: [
                                            Question(image: "lesson 1-1", prompt: "This is the first question. This is the first question. This is the first question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: true),
                                                        Answer(text: "Answer 2", isCorrect: false),
                                                        Answer(text: "Answer 3", isCorrect: false)
                                                     ]),
                                            Question(image: "lesson 1-2", prompt: "This is the second question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true)
                                                     ]),
                                            Question(image: "lesson 1-3", prompt: "This is the third question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true),
                                                        Answer(text: "Answer 3", isCorrect: false),
                                                        Answer(text: "Answer 4", isCorrect: false)
                                                     ])
                                          ]),
                                     Quiz(title: "Second Quiz", subtitle: "Travel Emissions",
                                          questions: [
                                            Question(image: "lesson 1-1", prompt: "This is the first question. This is the first question. This is the first question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: true),
                                                        Answer(text: "Answer 2", isCorrect: false),
                                                        Answer(text: "Answer 3", isCorrect: false)
                                                     ]),
                                            Question(image: "lesson 1-2", prompt: "This is the second question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true)
                                                     ]),
                                            Question(image: "lesson 1-3", prompt: "This is the third question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true),
                                                        Answer(text: "Answer 3", isCorrect: false),
                                                        Answer(text: "Answer 4", isCorrect: false)
                                                     ])
                                          ]),
                                     Quiz(title: "Third Quiz", subtitle: "Home Heating",
                                          questions: [
                                            Question(image: "lesson 1-1", prompt: "This is the first question. This is the first question. This is the first question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: true),
                                                        Answer(text: "Answer 2", isCorrect: false),
                                                        Answer(text: "Answer 3", isCorrect: false)
                                                     ]),
                                            Question(image: "lesson 1-2", prompt: "This is the second question. This is the first question. This is the first question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true)
                                                     ]),
                                            Question(image: "lesson 1-3", prompt: "This is the third question.",
                                                     answers: [
                                                        Answer(text: "Answer 1", isCorrect: false),
                                                        Answer(text: "Answer 2", isCorrect: true),
                                                        Answer(text: "Answer 3", isCorrect: false),
                                                        Answer(text: "Answer 4", isCorrect: false)
                                                     ])
                                          ])
    ]
    //static let lessons: [Lesson] = []
    //    [
    //        Lesson(title: "Lesson 1", subtitle: "Methane Emissions", coverImage: "cows", slides: [Slide(image: "lessons 1-1", caption: "THis is the first slide"), Slide(image: "secondImage", caption: "THis is the second slide")]),
    //        Lesson(title: "Lesson 2", subtitle: "Air Travel", coverImage: "airplane", slides: [Slide(image: "3rdimage", caption: "THis is the 3rd slide"), Slide(image: "4thimage", caption: "THis is the 4th slide")])
    //    ]
    //        Lesson(title: "Lesson 3", subtitle: "Insulating Your Home", coverImage: "insulation"),
    //    ]
}

