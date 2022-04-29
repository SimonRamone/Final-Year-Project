//
//  AwardsView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct AwardsView: View {
    @State private var data = Badge.Data()
    @State private var isPresentingBadgeView = false
    
    @Binding var badges: [Badge]
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    @Binding var user: User
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                    ForEach(badges) { badge in
                        if user.hasUnlocked[badge.title] ?? false {
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
                                popUpMessage = badge.achieveBy
                                isPresentingInfoPopUp.toggle()
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
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView(badges: .constant(Badge.sampleData), isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""), user: .constant(User()))
    }
}
