//
//  Final_Year_ProjectApp.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI

@main
struct Final_Year_ProjectApp: App {
    @StateObject private var dataStore = DataStore()
    
    @State private var lessons = Lesson.lessons
    @State private var badges = Badge.sampleData
    
    init() {
        parseLessons()
    }
    
    var body: some Scene {
        WindowGroup {
            MenuTabView(lessons: $lessons, badges: $badges, user: $dataStore.user)
            {
                DataStore.save(user: dataStore.user) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .onAppear {
                DataStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let user):
                        dataStore.user = user
                    }
                }
                
                print(dataStore.user)
            }
        }
    }
    
    func parseLessons() {
        do {
            lessons = try JSONDecoder().decode([Lesson].self, from: NSDataAsset(name: "lessons-data", bundle: Bundle.main)!.data)
            print(lessons)
        } catch { print(error) }
    }
    
}
