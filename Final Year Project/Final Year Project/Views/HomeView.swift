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
                .padding(.init(top: 0, leading: 60, bottom: 0, trailing: 60))
                VStack (alignment: .leading) {
                    Text("Breakdown")
                        .font(.title)
                        .bold()
                        .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            Button(action: {
                            }) {
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(Color.red)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(0.4, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(Color.red)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "house.fill")
                                            .foregroundColor(Color.red)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text("40%")
                                        .font(.title2)
                                        .bold()
                                    Text("Home")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            Button(action: {
                            }) {
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(Color.green)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(0.2, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(Color.green)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "car.fill")
                                            .foregroundColor(Color.green)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text("20%")
                                        .font(.title2)
                                        .bold()
                                    Text("Transport")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            Button(action: {
                            }) {
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(Color.yellow)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(0.35, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(Color.yellow)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "fork.knife")
                                            .foregroundColor(Color.yellow)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text("35%")
                                        .font(.title2)
                                        .bold()
                                    Text("Diet")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            Button(action: {
                            }) {
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(Color.green)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(0.05, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(Color.green)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "cart.fill")
                                            .foregroundColor(Color.green)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text("5%")
                                        .font(.title2)
                                        .bold()
                                    Text("Shopping")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                        }
                    }
                }
                .background(Color.mint.opacity(0.7))
            }
            .navigationTitle("Home")
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
