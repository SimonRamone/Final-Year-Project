//
//  Lesson.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import Foundation

struct Lesson: Identifiable, Codable {
    let id = UUID()
    let story: Story
    let quiz: Quiz
    
    init(story: Story, quiz: Quiz) {
        self.story = story
        self.quiz = quiz
    }
    
    init() {
        self.story = Story()
        self.quiz = Quiz()
    }
    
    private enum CodingKeys : String, CodingKey { case story, quiz}
}

extension Lesson {
    static let lessons: [Lesson] = []
}
