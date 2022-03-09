//
//  DietFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 16/02/2022.
//

import SwiftUI

struct DietFootprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var numberOfQuestions = 3
    @State var questionNr = 0
    
    @Binding var data: CarbonFootprint.Data
    @ObservedObject var carbonFootprintCalculator: CarbonFootprintCalculator
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                switch (questionNr)  {
                case 0:
                    VStack{
                        Text("Select the **diet** that is closest to yours." )
                            .font(.largeTitle)
                        Picker("Diet", selection: $data.dietEmissions) {
                            Text("Meat Eater")
                                .tag(Constants.DietEmissions.MediumMeat)
                            Text("Vegetarian")
                                .tag(Constants.DietEmissions.Vegetarian)
                            Text("Vegan")
                                .tag(Constants.DietEmissions.Vegan)
                            Text("Pescatarian")
                                .tag(Constants.DietEmissions.Pescatarian)
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "A pescatarian is someone who does not eat meat with the exception of fish."
                    }
                    .onDisappear(){
                        if data.dietEmissions == Constants.DietEmissions.Vegan || data.dietEmissions == Constants.DietEmissions.Vegetarian || data.dietEmissions == Constants.DietEmissions.Pescatarian {
                            questionNr = 2
                        }
                    }
                case 1:
                    VStack{
                        Text("How often do you eat **meat** in a week?" )
                            .font(.largeTitle)
                        Picker("Diet", selection: $data.dietEmissions) {
                            Text("Daily")
                                .tag(Constants.DietEmissions.HighMeat)
                            Text("Every Other Day")
                                .tag(Constants.DietEmissions.MediumMeat)
                            Text("Sometimes")
                                .tag(Constants.DietEmissions.LowMeat)
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "One serving of beef is responsible for \(Constants.BEEF_FOOTPRINT)kgCO2e."
                    }
                case 2:
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
                        popUpMessage = "The average amount of food wasted per person is \(Constants.AVERAGE_WEEKLY_FOOD_WASTE)kg every week."
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
                        }) {
                            Text("Done")
                        }
                    } else {
                        Button(action: {
                            questionNr += 1
                        }) {
                            Text("Next")
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
        .onDisappear(){
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
        }
    }
}

struct DietFootprintView_Previews: PreviewProvider {
    static var previews: some View {
        DietFootprintView(data: .constant(CarbonFootprint.defaultCarbonFootprint.data), carbonFootprintCalculator: CarbonFootprintCalculator(), isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""))
    }
}
