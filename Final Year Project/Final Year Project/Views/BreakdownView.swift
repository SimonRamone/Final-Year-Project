//
//  CircularProgressView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 29/04/2022.
//

import SwiftUI

struct BreakdownView: View {
    var percentage : Double
    var color : Color
    var icon : String
    var caption : String
    var body: some View {
        VStack{
            ZStack {
                Group {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.5)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(percentage, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270.0))
                Image(systemName: icon)
                    .font(.title)
                    .padding()
                }
                .foregroundColor(color)
            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(String(format: "%.0f", percentage*100)+"%")
                .font(.title2)
                .bold()
            Text(caption)
                .font(.subheadline)
        }
        .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
        .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .foregroundColor(Color.primary)
        .background(Color.white)
        .cornerRadius(5)
    }
}
