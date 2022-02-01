//
//  ContentView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI

struct MenuTab: View {
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
            LearnView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Learn")
                }
            AwardsView()
                .tabItem {
                    Image(systemName: "crown.fill")
                    Text("Awards")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTab()
    }
}
