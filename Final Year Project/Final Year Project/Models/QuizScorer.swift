//
//  QuizScorer.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import Foundation

class QuizScorer: ObservableObject {
    
    @Published var totalScore: Int = 0
    @Published var questionScore: Int = 0
    
    func addPoints(points: Int, factor: Double) {
        questionScore = Int(Double(points) * factor)
        totalScore += questionScore
    }
    
    func finaliseScore(maxScore: Int){
        self.totalScore = min(totalScore, maxScore)
    }
    
    func reset() {
        questionScore = 0
        totalScore = 0
    }
}
