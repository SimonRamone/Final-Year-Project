//
//  HomeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct HomeView: View {
    @State var carbonEmissionsValue: Float = 13.2
        
        var body: some View {
            ZStack {
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20.0)
                            .opacity(0.6)
                            .foregroundColor(Color.red)

                        VStack {
                            Text(String(format: "%.1f CO\u{2082}e", carbonEmissionsValue))
                                .font(.largeTitle)
                                .bold()
                            Text("Tonnes per annum")
                        }
                    }
                }
            }
            .padding(60)
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
