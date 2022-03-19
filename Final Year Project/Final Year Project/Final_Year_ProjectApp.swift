//
//  Final_Year_ProjectApp.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI

@main
struct Final_Year_ProjectApp: App {
    @State private var lessons = Lesson.lessons
    @State private var badges = Badge.sampleData
    @State private var profile = Profile.sampleData
    @State private var carbonFootprint = CarbonFootprint.defaultCarbonFootprint
    
    init() {
        parseLessons()
    }
    
    var body: some Scene {
        WindowGroup {
            MenuTabView(lessons: $lessons, badges: $badges, profile: $profile, carbonFootprint: $carbonFootprint)
        }
    }
    
    func parseLessons() {
        do {
//                        let jsonData = try JSONEncoder().encode(lessons)
//                        let jsonString = String(data: jsonData, encoding: .utf8)!
            print("HERE:")
            //print(jsonString) // [{"sentence":"Hello world","lang":"en"},{"sentence":"Hallo Welt","lang":"de"}]
            
            // and decode it back
            lessons = try JSONDecoder().decode([Lesson].self, from: NSDataAsset(name: "lessons-data", bundle: Bundle.main)!.data)
            print(lessons)
        } catch { print(error) }
    }

}
