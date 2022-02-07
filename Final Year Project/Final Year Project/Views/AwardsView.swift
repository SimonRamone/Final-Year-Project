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
    var body: some View {
        ScrollView{
            HStack {
                Text("Badges")
                    .font(.largeTitle)
                    .padding(.leading)
                Spacer()
            }
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
                            BadgeView(data: $data)
                        }
                    }
                    else {
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
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView(badges: .constant(Badge.sampleData))
    }
}
