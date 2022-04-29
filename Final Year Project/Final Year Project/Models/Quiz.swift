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
    var isCompleted: Bool = false
    var score: Int = 0
    
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
    
    private enum CodingKeys : String, CodingKey { case title, subtitle, questions}
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
        
        private enum CodingKeys : String, CodingKey { case text, isCorrect}
    }
}

