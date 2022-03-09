//
//  HomeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI
import GameKit

struct HomeView: View {
    @State var carbonEmissionsValue: Float = 13.2
    @State var isPresentingProfileView = false
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    @Binding var profile: Profile
    @State var data = CarbonFootprint.Data()
    @Binding var carbonFootprint: CarbonFootprint
    @StateObject var carbonFootprintCalculator = CarbonFootprintCalculator()
    let localPlayer = GKLocalPlayer.local
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .foregroundColor(carbonFootprintCalculator.carbonFootprint>Constants.AVERAGE_FOOTPRINT+3000 ? Color.red : carbonFootprintCalculator.carbonFootprint<Constants.AVERAGE_FOOTPRINT-3000 ? Color.green : Color.yellow)
                    VStack {
                        Text(String(format: "%.1f CO\u{2082}e", carbonFootprintCalculator.carbonFootprint/1000))
                            .font(.largeTitle)
                            .bold()
                        HStack {
                            Text("Tonnes per annum")
                            Button(action: {
                                popUpMessage = "A carbon dioxide equivalent is all greenhouse gases rolled into one."
                                isPresentingInfoPopUp.toggle()
                            }, label: {
                                Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                            })
                        }
                        if carbonFootprintCalculator.carbonFootprint>Constants.AVERAGE_FOOTPRINT+3000 {
                            Label {
                                Text("Action Required")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            } icon: {
                                ZStack{
                                    Image(systemName: "octagon.fill")
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .foregroundColor(Color.red)
                                        .font(.title)
                                }
                            }
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 15))
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(25)
                        } else if carbonFootprintCalculator.carbonFootprint<Constants.AVERAGE_FOOTPRINT-3000 {
                            Label {
                                Text("OK")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            } icon: {
                                ZStack{
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color.green)
                                        .font(.title)
                                }
                            }
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 15))
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(25)
                        } else {
                            Label {
                                Text("Improve Now")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            } icon: {
                                ZStack{
                                    Image(systemName: "triangle.fill")
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(Color.yellow)
                                        .font(.title)
                                }
                            }
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 15))
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(25)
                        }
                    }.padding(.top)
                }
                .padding(.init(top: 30, leading: 60, bottom: 10, trailing: 60))
                VStack (alignment: .leading) {
                    Text("Breakdown")
                        .font(.title)
                        .bold()
                        .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            NavigationLink(destination: HomeFootprintView(data: $data, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(carbonFootprintCalculator.percentHome>0.6 ? Color.red : carbonFootprintCalculator.percentHome>0.4 ? Color.yellow : Color.green)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentHome, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(carbonFootprintCalculator.percentHome>0.6 ? Color.red : carbonFootprintCalculator.percentHome>0.4 ? Color.yellow : Color.green)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "house.fill")
                                            .foregroundColor(carbonFootprintCalculator.percentHome>0.6 ? Color.red : carbonFootprintCalculator.percentHome>0.4 ? Color.yellow : Color.green)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text(String(format: "%.0f", carbonFootprintCalculator.percentHome*100)+"%")
                                        .font(.title2)
                                        .bold()
                                    Text("Home")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            NavigationLink(destination: TransportFootprintView(data: $data, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(carbonFootprintCalculator.percentTransport>0.6 ? Color.red : carbonFootprintCalculator.percentTransport>0.4 ? Color.yellow : Color.green)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentTransport, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(carbonFootprintCalculator.percentTransport>0.6 ? Color.red : carbonFootprintCalculator.percentTransport>0.4 ? Color.yellow : Color.green)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "car.fill")
                                            .foregroundColor(carbonFootprintCalculator.percentTransport>0.6 ? Color.red : carbonFootprintCalculator.percentTransport>0.4 ? Color.yellow : Color.green)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text(String(format: "%.0f", carbonFootprintCalculator.percentTransport*100)+"%")
                                        .font(.title2)
                                        .bold()
                                    Text("Transport")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            NavigationLink(destination: DietFootprintView(data: $data, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                            .foregroundColor(carbonFootprintCalculator.percentDiet>0.6 ? Color.red : carbonFootprintCalculator.percentDiet>0.4 ? Color.yellow : Color.green)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentDiet, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(carbonFootprintCalculator.percentDiet>0.6 ? Color.red : carbonFootprintCalculator.percentDiet>0.4 ? Color.yellow : Color.green)
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "fork.knife")
                                            .foregroundColor(carbonFootprintCalculator.percentDiet>0.6 ? Color.red : carbonFootprintCalculator.percentDiet>0.4 ? Color.yellow : Color.green)
                                            .font(.title)
                                            .padding()
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text(String(format: "%.0f", carbonFootprintCalculator.percentDiet*100)+"%")
                                        .font(.title2)
                                        .bold()
                                    Text("Diet")
                                        .font(.subheadline)
                                }
                                .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 150)
                                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
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
                                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(Color.primary)
                                .background(Color.white)
                                .cornerRadius(5)
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
                        }
                    }
                }
                .background(Color.teal.opacity(0.5))
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top])
            //                .navigationBarItems(
            //                    leading:
            //                        Text("Welcome, \(profile.name)!")
            //                        .font(.body)
            //                        .foregroundColor(Color(.systemGray)),
            //                    trailing:
            //                        Button(action: {
            //                            isPresentingProfileView.toggle()
            //                        }) {
            //                            Image(uiImage: playerImage.image ?? defaultimg)
            //                                .resizable()
            //                                .frame(width: 40, height: 40)
            //                                .clipShape(Circle())
            //                        }
            //                        .sheet(isPresented: $isPresentingProfileView) {
            //                            ProfileView(profile: $profile)
            //                        }
            //                )
            
            // }
            //PopUpView(isPresented: $isPresentingInfoPopUp, title: "", message: "A carbon dioxide equivalent is all greenhouse gases rolled into one.", buttonText: "Got it!")
        }
        .onAppear(){
            GKAccessPoint.shared.isActive = false
            
        }
    }
}

let defaultimg = UIImage(named: "default-avatar")!
let playerImage = UIImageView()

func loadUserImage() {
    let localPlayer = GKLocalPlayer.local
    localPlayer.loadPhoto(for: .normal, withCompletionHandler: {(photo: UIImage?, error: Error?) -> Void in
        if !(error != nil) {
            playerImage.image! = photo!
        }
        else {
            print("Error loading image")
        }
    })
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""), profile: .constant(Profile.sampleData), carbonFootprint: .constant(CarbonFootprint.defaultCarbonFootprint))
    }
}
