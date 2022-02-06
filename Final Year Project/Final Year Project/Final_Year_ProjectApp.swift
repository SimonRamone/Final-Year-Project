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
    var body: some Scene {
        WindowGroup {
            MenuTab(lessons: $lessons)
        }
    }
}
