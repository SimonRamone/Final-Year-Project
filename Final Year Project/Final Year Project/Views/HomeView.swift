//
//  HomeView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI
import GameKit

struct HomeView: View {
    @StateObject private var dataStore = DataStore()
    @State var carbonEmissionsValue: Float = 13.2
    @State var isPresentingSheet = false
    @State var currentSurvey = "Home"
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var isPresentingLoadingView: Bool
    @Binding var popUpMessage: String
    @State var data = CarbonFootprint.Data()
    @Binding var user: User
    @StateObject var carbonFootprintCalculator = CarbonFootprintCalculator()
    let localPlayer = GKLocalPlayer.local
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .foregroundColor(carbonFootprintCalculator.carbonFootprint>Constants.AVERAGE_FOOTPRINT ? Color.red : carbonFootprintCalculator.carbonFootprint<=Constants.GOAL_FOOTPRINT ? Color.green : Color.yellow)
                        .animation(.easeInOut(duration: 2.0), value: carbonFootprintCalculator.carbonFootprint)
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
                        if carbonFootprintCalculator.carbonFootprint>Constants.AVERAGE_FOOTPRINT {
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
                        } else if carbonFootprintCalculator.carbonFootprint<=Constants.GOAL_FOOTPRINT {
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
                .padding(.init(top: 10, leading: 60, bottom: 10, trailing: 60))
                VStack (alignment: .leading) {
                    Text("Breakdown")
                        .font(.title)
                        .bold()
                        .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            NavigationLink(destination: HomeFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Group {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentHome, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "house.fill")
                                            .font(.title)
                                            .padding()
                                        }
                                        .foregroundColor(colorIndicator(percentage: carbonFootprintCalculator.percentHome))
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
                            NavigationLink(destination: TransportFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Group {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentTransport, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "car.fill")
                                            .font(.title)
                                            .padding()
                                        }
                                        .foregroundColor(colorIndicator(percentage: carbonFootprintCalculator.percentTransport))
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
                            NavigationLink(destination: DietFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Group{
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentDiet, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "fork.knife")
                                            .font(.title)
                                            .padding()
                                        }
                                        .foregroundColor(colorIndicator(percentage: carbonFootprintCalculator.percentDiet))
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
                            NavigationLink(destination: GoodsFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet).navigationBarTitleDisplayMode(.inline)){
                                VStack{
                                    ZStack {
                                        Group{
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.5)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(carbonFootprintCalculator.percentGoods, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .rotationEffect(Angle(degrees: 270.0))
                                        Image(systemName: "cart.fill")
                                            .font(.title)
                                            .padding()
                                        }
                                        .foregroundColor(colorIndicator(percentage: carbonFootprintCalculator.percentGoods))
                                    }
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    Text(String(format: "%.0f", carbonFootprintCalculator.percentGoods*100)+"%")
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
            .padding(.top, -60)
            .navigationBarHidden(false)
            //.edgesIgnoringSafeArea([.top])
            .navigationBarItems(
                leading:
                    Button(action: {
                        currentSurvey = "Home"
                        isPresentingSheet = true
                    }, label: {
                        HStack{
                            Image(systemName: "leaf.arrow.triangle.circlepath")
                            Text("Calculate")
                        }
                        .font(.headline)
                        .foregroundColor(.green)
                    }).padding(.bottom),
                trailing:
                    HStack{
                        NavigationLink(destination: LeaderboardView(leaderBoardID: "lowestCarbonEmitters", user: $user, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage), label: {Image(systemName: "chart.bar.fill").foregroundColor(.gray.opacity(0.7))})
                        Button(action: {
                            popUpMessage = "This is an estimate of your total carbon emissions. Click 'calculate' to start the survey."
                            isPresentingInfoPopUp.toggle()
                        }, label: {
                            Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                        })}
                    .padding(.bottom)
            )
        }
        .sheet(isPresented: $isPresentingSheet) {
            NavigationView {
                Group{
                    ZStack{
                    switch (currentSurvey)  {
                    case "Home":
                        HomeFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet)
                    case "Transport":
                    TransportFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet)
                    case "Diet":
                    DietFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet)
                    case "Goods":
                        GoodsFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet)
                    default:
                        HomeFootprintView(user: $user, carbonFootprintCalculator: carbonFootprintCalculator, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, currentSurvey: $currentSurvey, isPresentingSheet: $isPresentingSheet)
                    }
                        PopUpView(isPresented: $isPresentingInfoPopUp, title: "", message: popUpMessage, buttonText: "Got it!")
                            .shadow(color: .gray, radius: 10, x: 0, y: 0)
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline).navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        Button("Dismiss") {
                    isPresentingSheet = false
                }.disabled(isPresentingInfoPopUp))
            }
            .interactiveDismissDisabled(isPresentingInfoPopUp)
        }
        .onChange(of: carbonFootprintCalculator.carbonFootprint) { carbonFootprint in
            user.carbonFootprint.totalCarbonFootprint = carbonFootprint
            if user.hasAcceptedTerms {
                GKLeaderboard.submitScore(Int(carbonFootprint), context:0, player: GKLocalPlayer.local, leaderboardIDs: ["lowestCarbonEmitters"], completionHandler: {error in})
            }
        }
        .onAppear(){
            GKAccessPoint.shared.isActive = false
                data = user.carbonFootprint.data
                carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
                carbonFootprintCalculator.recalculateCarbonFootprint()
            user.carbonFootprint.totalCarbonFootprint = carbonFootprintCalculator.carbonFootprint
        }
        .onChange(of: user.carbonFootprint.data){ data in
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            carbonFootprintCalculator.recalculateCarbonFootprint()
            user.carbonFootprint.totalCarbonFootprint = carbonFootprintCalculator.carbonFootprint
        }
        .onChange(of: isPresentingSheet){ item in
            if !isPresentingSheet {
                carbonFootprintCalculator.recalculateCarbonFootprint()
                user.carbonFootprint.totalCarbonFootprint = carbonFootprintCalculator.carbonFootprint
            }
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

func colorIndicator(percentage: Double) -> Color {
    return percentage>0.40 ? Color.red : percentage>0.25 ? Color.yellow : Color.green
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(isPresentingInfoPopUp: .constant(false), isPresentingLoadingView: .constant(false), popUpMessage: .constant(""), carbonFootprint: .constant(CarbonFootprint.defaultCarbonFootprint))
//    }
//}
