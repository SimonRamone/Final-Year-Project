//
//  ContentView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI

struct MenuTab: View {
    @Binding var lessons: [Lesson]
    @Binding var badges: [Badge]
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            TrackView()
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Track")
                }
            LearnView(lessons: $lessons)
                .tabItem {
                    Image(systemName: "book")
                    Text("Learn")
                }
            AwardsView(badges: $badges)
                .tabItem {
                    Image(systemName: "crown.fill")
                    Text("Awards")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTab(lessons: .constant(Lesson.sampleData), badges: .constant(Badge.sampleData))
    }
}
