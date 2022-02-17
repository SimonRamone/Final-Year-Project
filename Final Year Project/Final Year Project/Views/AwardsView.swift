//
//  AwardsView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct AwardsView: View {
    @Binding var badges: [Badge]
    
    @State private var data = Badge.Data()
    @State private var isPresentingBadgeView = false
    @State private var isPresentingInfoPopUp = false
    
    @State private var badgeAchievement = ""
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                        ForEach(badges) { badge in
                            if badge.earned {
                                Button(action: {
                                    isPresentingBadgeView.toggle()
                                    data = badge.data
                                }) {
                                    Image(badge.image)
                                        .resizable()
                                        .scaledToFill()
                                        .padding()
                                }
                                .sheet(isPresented: $isPresentingBadgeView) {
                                    NavigationView {
                                        BadgeView(data: $data)
                                            .navigationBarItems(trailing:
                                                                    Button("Done") {
                                                isPresentingBadgeView = false
                                            }
                                            )
                                    }
                                }
                            }
                            else {
                                Button(action: {
                                    isPresentingInfoPopUp.toggle()
                                    badgeAchievement = badge.achieveBy
                                }) {
                                    Image(badge.image)
                                        .resizable()
                                        .scaledToFill()
                                        .padding()
                                        .grayscale(1)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Awards")
            }
            PopUpView(isPresented: $isPresentingInfoPopUp, title: "", message: badgeAchievement, buttonText: "Got it!")
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView(badges: .constant(Badge.sampleData))
    }
}
