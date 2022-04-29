//
//  QuizScorer.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import Foundation

class QuizScorer: ObservableObject {
    
    @Published var totalScore: Int = 0
    @Published var questionScore: Double = 0.0
    
    func addPoints(points: Double, factor: Double, maxPerQuestion: Double) {
        questionScore = min((points * factor), maxPerQuestion)
        totalScore += Int(questionScore.rounded(.up))
    }
    
    func finaliseScore(maxScore: Int){
        self.totalScore = min(totalScore, maxScore)
    }
    
    func reset() {
        questionScore = 0
        totalScore = 0
    }
}
