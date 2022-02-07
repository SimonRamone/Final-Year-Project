//
//  BadgeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 07/02/2022.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profile: Profile
    var body: some View {
        VStack{
            Image(profile.image)
            .resizable()
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .padding(.init(top: 30, leading: 0, bottom: 0, trailing: 0))
            Text("\(profile.name) \(profile.surname)")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: .constant(Profile.sampleData))
    }
}
