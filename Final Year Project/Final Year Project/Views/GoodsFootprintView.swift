//
//  GoodsFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 13/03/2022.
//

import SwiftUI

struct GoodsFootprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var numberOfQuestions = 5
    @State var questionNr = 0
    
    @Binding var data: CarbonFootprint.Data
    @ObservedObject var carbonFootprintCalculator: CarbonFootprintCalculator
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    @Binding var currentSurvey: String
    @Binding var isPresentingSheet: Bool
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                switch (questionNr)  {
                case 0:
                    VStack{
                        Image(systemName: "cart.fill")
                            .font(.system(size: 100))
                        Text("Goods & Services Footprint Survey")
                            .font(.headline)
                        Text("4 Questions")
                    }
                case 1:
                    VStack{
                        Text("How much do you spend on **new electronics** per year?")
                            .font(.largeTitle)
                        HStack{
                            Spacer()
                            Text("EUR (€)")
                                .font(.caption)
                                .padding(.top, 5)
                                .foregroundColor(.gray)
                        }
                        TextField("EUR (€)", value: $data.goodsEmissions.expensesElectronics, format: .number)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "The average amount of food wasted per person is \(Constants.AVERAGE_WEEKLY_FOOD_WASTE) kg every week."
                    }
                case 2:
                    VStack{
                        Text("How much do you spend on **new clothing** per month?")
                            .font(.largeTitle)
                        HStack{
                            Spacer()
                            Text("EUR (€)")
                                .font(.caption)
                                .padding(.top, 5)
                                .foregroundColor(.gray)
                        }
                        TextField("EUR (€)", value: $data.goodsEmissions.expensesClothing, format: .number)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "The average amount of food wasted per person is \(Constants.AVERAGE_WEEKLY_FOOD_WASTE) kg every week."
                    }
                case 3:
                    VStack{
                        Text("How much do you spend on **video streaming** services per month?")
                            .font(.largeTitle)
                        HStack{
                            Spacer()
                            Text("EUR (€)")
                                .font(.caption)
                                .padding(.top, 5)
                                .foregroundColor(.gray)
                        }
                        TextField("EUR (€)", value: $data.goodsEmissions.expensesStreaming, format: .number)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "The average amount of food wasted per person is \(Constants.AVERAGE_WEEKLY_FOOD_WASTE) kg every week."
                    }
                case 4:
                    VStack{
                        Text("How much **mobile data** do you use per month?")
                            .font(.largeTitle)
                        HStack{
                            Spacer()
                            Text("gigabyte (GB)")
                                .font(.caption)
                                .padding(.top, 5)
                                .foregroundColor(.gray)
                        }
                        TextField("gigabyte (GB)", value: $data.goodsEmissions.mobileDataUsage, format: .number)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
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
                            isPresentingSheet = false
                            self.presentationMode.wrappedValue.dismiss()
                            currentSurvey = "Home"
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
        .navigationTitle("Goods & Services Footprint")
        .onDisappear(){
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            carbonFootprintCalculator.calculateGoodsCarbonFootprint()
            carbonFootprintCalculator.calculateCarbonFootprint()
        }
    }
}

struct GoodsFootprintView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsFootprintView(data: .constant(CarbonFootprint.defaultCarbonFootprint.data), carbonFootprintCalculator: CarbonFootprintCalculator(), isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""), currentSurvey: .constant("Goods"), isPresentingSheet: .constant(false))
    }
}
