//
//  HomeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct HomeView: View {
    @State var carbonEmissionsValue: Float = 13.2
    @State private var isPresentingProfileView = false
    @Binding var profile: Profile
    var body: some View {
        NavigationView {
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
                .padding(60)
            }
            .navigationTitle("Home 👋")
            .navigationBarItems(
                leading:
                    Text("Welcome, \(profile.name)!")
                    .font(.body)
                    .foregroundColor(Color(.systemGray)),
                trailing:
                    Button(action: {
                        isPresentingProfileView.toggle()
                    }) {
                        Image(profile.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    }
                    .sheet(isPresented: $isPresentingProfileView) {
                        ProfileView(profile: $profile)
                    }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profile: .constant(Profile.sampleData))
    }
}
