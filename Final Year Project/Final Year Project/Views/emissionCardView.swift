//
//  emissionCardView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import SwiftUI

struct EmissionCardView: View {
    @Binding var name: String
    @Binding var value: Double
    @Binding var entryType: String
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 30 , height: 70)
            
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        switch (entryType)  {
                        case "Diet":
                            Image(systemName: "fork.knife")
                        case "Travel":
                            Image(systemName: "car.fill")
                        case "Goods":
                            Image(systemName: "cart.fill")
                        case "Home":
                            Image(systemName: "house.fill")
                        default:
                            Image(systemName: "puzzlepiece.extension.fill")
                            
                        }
                        Text(entryType)
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    Text(name)
                        .font(.body)
                }
                Spacer()
                Text(String(format: "%.1f", value) + " kg")
                    .font(.title)
                    .bold()
            }
            .padding(.horizontal)
        }
        .cornerRadius(20)
        .padding(.bottom)
        .padding(.horizontal)
    }
}

struct EmissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmissionCardView(name: .constant("Vegan Meal"), value: .constant(2.3), entryType: .constant("Diet"))
    }
}
