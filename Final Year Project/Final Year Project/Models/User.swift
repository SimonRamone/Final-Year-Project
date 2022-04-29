//
//  User.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/03/2022.
//

import Foundation

struct User: Codable {
    
    var quizScores = [String : Int]()
    var hasCompleted = [String : Bool]()    // completed lessons
    var hasUnlocked = [String : Bool]()     // unlocked badges
    var carbonFootprint: CarbonFootprint = CarbonFootprint(data: CarbonFootprint.Data())        // carbon footprint calculator answers
    var actions : [Action] = []             // tracked actions
    
    private var _hasAcceptedTerms: Bool?            // has accepted leaderboard terms
    var hasAcceptedTerms: Bool {
        get {
            _hasAcceptedTerms ?? false
        }
        set {
            _hasAcceptedTerms = newValue
        }
    }
}
