//
//  BadgeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 07/02/2022.
//

import SwiftUI

struct BadgeView: View {
    @Binding var data: Badge.Data
    var body: some View {
        VStack{
            Image(data.image)
                .resizable()
                .scaledToFill()
                .padding(50)
                .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
            
            Text(data.title)
                .font(.largeTitle)
                .padding()
            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

        }
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(data: .constant(Badge.sampleData[0].data))
    }
}
