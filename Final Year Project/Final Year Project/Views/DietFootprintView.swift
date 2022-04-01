//
//  DietFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 16/02/2022.
//

import SwiftUI
import GameKit

struct DietFootprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var numberOfQuestions = 4
    @State var questionNr = 0
    
    @State var data = CarbonFootprint.Data()
    @Binding var user: User
    @ObservedObject var carbonFootprintCalculator: CarbonFootprintCalculator
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    @Binding var currentSurvey: String
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                switch (questionNr)  {
                case 0:
                    VStack{
                        Image(systemName: "fork.knife")
                            .font(.system(size: 100))
                        Text("Diet Footprint Survey")
                            .font(.headline)
                        Text("3 Questions")
                    }
                case 1:
                    VStack{
                        Text("Select the **diet** that is closest to yours." )
                            .font(.largeTitle)
                        Picker("Diet", selection: $data.dietEmissions) {
                            Text("Meat Daily 🥩")
                                .tag(Constants.DietEmissions.HighMeat)
                            Text("Meat Every Other Day")
                                .tag(Constants.DietEmissions.MediumMeat)
                            Text("Meat Sometimes")
                                .tag(Constants.DietEmissions.LowMeat)
                            Text("Vegan 🥦")
                                .tag(Constants.DietEmissions.Vegan)
                            Text("Vegetarian")
                                .tag(Constants.DietEmissions.Vegetarian)
                            Text("Pescatarian 🐟")
                                .tag(Constants.DietEmissions.Pescatarian)
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "A pescatarian is someone who does not eat meat with the exception of fish."
                    }
                case 2:
                    VStack{
                            Text("How many **high emission** foods do you eat in a week?")
                                .font(.largeTitle)
                        if data.dietEmissions != Constants.DietEmissions.Vegan && data.dietEmissions != Constants.DietEmissions.Vegetarian && data.dietEmissions != Constants.DietEmissions.Pescatarian {
                            Stepper("🥩 Beef Servings: \(data.highEmissionFoods.beefServings.formatted())", value: $data.highEmissionFoods.beefServings, in: 0...100)
                            Stepper("🥓 Pork Servings: \(data.highEmissionFoods.porkServings.formatted())", value: $data.highEmissionFoods.porkServings, in: 0...100)
                            Stepper("🍗 Poultry Servings: \(data.highEmissionFoods.poultryServings.formatted())", value: $data.highEmissionFoods.poultryServings, in: 0...100)
                        }
                        if data.dietEmissions != Constants.DietEmissions.Vegan && data.dietEmissions != Constants.DietEmissions.Vegetarian {
                            Stepper("🐟 Fish Servings: \(data.highEmissionFoods.fishServings.formatted())", value: $data.highEmissionFoods.fishServings, in: 0...100)
                        }
                        if data.dietEmissions != Constants.DietEmissions.Vegan {
                            Stepper("🧀 Cheese Slices: \(data.highEmissionFoods.cheeseServings.formatted())", value: $data.highEmissionFoods.cheeseServings, in: 0...100)
                            Stepper("🥛 Milk Glasses: \(data.highEmissionFoods.milkServings.formatted())", value: $data.highEmissionFoods.milkServings, in: 0...100)
                        }
                            Stepper("🍚 Rice Bowls: \(data.highEmissionFoods.riceServings.formatted())", value: $data.highEmissionFoods.riceServings, in: 0...100)
                            Stepper("☕️ Coffee Cups: \(data.highEmissionFoods.coffeeServings.formatted())", value: $data.highEmissionFoods.coffeeServings, in: 0...100)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "A pescatarian is someone who does not eat meat with the exception of fish."
                    }
                case 3:
                    VStack{
                        Text("How much food did you **throw out** in the past week?" )
                            .font(.largeTitle)
                        Text("\(data.foodWaste, specifier: "%.1f") kg")
                            .padding(.top)
                        Slider(value: $data.foodWaste, in: 0...6, step: 0.1) {
                            Text("Kg Wasted")
                        }
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "The average amount of food wasted per person is \(Constants.AVERAGE_WEEKLY_FOOD_WASTE) kg every week."
                    }
                default:
                    onAppear(){questionNr = 0}
                }
                Spacer()
                HStack{
                    Button(action: {
                        questionNr -= 1
                    }) {
                        Text("Previous")
                    }.disabled(questionNr <= 0)
                    Spacer()
                    if questionNr == numberOfQuestions-1 {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            currentSurvey = "Goods"
                        }) {
                            Text("Done")
                        }
                    } else {
                        Button(action: {
                            questionNr += 1
                        }) {
                            if questionNr == 0 {
                                Text("Start")
                            }
                            else {
                                Text("Next")
                            }
                        }.disabled(questionNr >= numberOfQuestions-1)
                    }
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
            }
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isPresentingInfoPopUp.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                    })
            )
        }
        .navigationTitle("Diet Footprint")
        .onChange(of: data.dietEmissions){ _ in
            data.highEmissionFoods = CarbonFootprint.HighEmissionFoods(beefServings: 0, porkServings: 0, poultryServings: 0, riceServings: 0, fishServings: 0, coffeeServings: 0, cheeseServings: 0, milkServings: 0)
        }
        .onAppear(){
            data = user.carbonFootprint.data
        }
        .onDisappear(){
            user.carbonFootprint.update(from: data)
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            carbonFootprintCalculator.calculateDietCarbonFootprint()
            carbonFootprintCalculator.calculateCarbonFootprint()
            GKLeaderboard.submitScore(
                Int(carbonFootprintCalculator.carbonFootprint),
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: ["grp.lowestCarbonPolluters"]
            ) { error in
                //print(error)
            }
        }
    }
}

//struct DietFootprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        DietFootprintView(data: .constant(CarbonFootprint.defaultCarbonFootprint.data), carbonFootprintCalculator: CarbonFootprintCalculator(), isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""), currentSurvey: .constant("Diet"))
//    }
//}
