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
    var body: some Scene {
        WindowGroup {
            MenuTab(lessons: $lessons, badges: $badges, profile: $profile)
        }
    }
}
