//
//  AchievementReporter.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 02/04/2022.
//

import Foundation
import GameKit

class AchievementReporter {
    var achievement = GKAchievement()
    
    func reportAchievement(identifier: String){
        achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement])
    }
    
}
