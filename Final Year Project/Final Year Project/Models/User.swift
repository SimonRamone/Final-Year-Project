//
//  User.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/03/2022.
//

import Foundation

struct User: Codable {
    
    var quizScores = [String : Int]()
    var hasCompleted = [String : Bool]()
    var hasUnlocked = [String : Bool]()
    var carbonFootprint: CarbonFootprint = CarbonFootprint(data: CarbonFootprint.Data())
    var actions : [Action] = []
}
