//
//  Final_Year_ProjectApp.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI

@main
struct Final_Year_ProjectApp: App {
    @State private var lessons = Lesson.sampleData
    @State private var badges = Badge.sampleData
    @State private var profile = Profile.sampleData
    @State private var carbonFootprint = CarbonFootprint.defaultCarbonFootprint
    var body: some Scene {
        WindowGroup {
            MenuTabView(lessons: $lessons, badges: $badges, profile: $profile, carbonFootprint: $carbonFootprint)
        }
    }
}
