//
//  DietFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 16/02/2022.
//

import SwiftUI

struct HomeFootprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var numberOfQuestions = 5
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
                        Image(systemName: "house.fill")
                            .font(.system(size: 100))
                        Text("Home Energy Footprint Survey")
                            .font(.headline)
                        Text("4 Questions")
                    }
                case 1:
                    VStack{
                        Text("How many **people** live in your household?" )
                            .font(.largeTitle)
                        Stepper("Occupants: \(data.householdSize)", value: $data.householdSize, in: 1...10)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw beef."
                    }
                case 2:
                    VStack{
                        Text("Select your **energy** supplier." )
                            .font(.largeTitle)
                        Picker("Supplier", selection: $data.electricitySupplier) {
                            ForEach(Constants.ELECTRICITY_SUPPLIERS) { Electricity_Supplier in
                                Text(Electricity_Supplier.name)
                                    .tag(Electricity_Supplier.name)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw beef."
                    }
                case 3:
                    VStack{
                        Text("How much **electricity** did your household use in the past month?" )
                            .font(.largeTitle)
                        Picker("kWh or Euros Spent", selection: $data.isElectricityUnitKWH) {
                            Text("kWh").tag(true)
                            Text("€").tag(false)
                        }
                        .disabled(data.isUsingAverageElectricity)
                        .pickerStyle(.segmented)
                        if data.isElectricityUnitKWH {
                            HStack{
                                Spacer()
                                Text("kilowatt-hours (kWh)")
                                    .font(.caption)
                                    .padding(.top, 5)
                                    .foregroundColor(.gray)
                            }
                            TextField("kilowatt-hours (kWh)", value: $data.electricityUsed, format: .number)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                                .disabled(data.isUsingAverageElectricity)
                        } else {
                            HStack{
                                Spacer()
                                Text("EUR (€)")
                                    .font(.caption)
                                    .padding(.top, 5)
                                    .foregroundColor(.gray)
                            }
                            TextField("EUR (€)", value: $data.electricityUsed, format: .number)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                                .disabled(data.isUsingAverageElectricity)
                        }
                        Toggle("Use national average", isOn: $data.isUsingAverageElectricity)
                            .toggleStyle(CheckboxStyle())
                            .padding(.top)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw beef."
                    }
                case 4:
                    VStack{
                        Text("What fuel is used to **heat** your home?" )
                            .font(.largeTitle)
                        Picker("Fuel", selection: $data.heatingFuelType) {
                            Text("Coal")
                                .tag("Coal")
                            Text("Natural Gas")
                                .tag("Natural Gas")
                            Text("Electricity")
                                .tag("Electricity")
                            Text("Kerosene")
                                .tag("Kerosene")
                            Text("LPG")
                                .tag("LPG")
                            Text("Peat")
                                .tag("Peat")
                            Text("Biomass")
                                .tag("Biomass")
                        }
                        .pickerStyle(.wheel)
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw beef."
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
                            currentSurvey = "Transport"
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
        .navigationTitle("Home Energy Footprint")
        .onAppear(){
            data = user.carbonFootprint.data
            print("Home user data")
            print(data)
        }
        .onDisappear(){
            user.carbonFootprint.update(from: data)
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            carbonFootprintCalculator.calculateHomeCarbonFootprint()
            carbonFootprintCalculator.calculateCarbonFootprint()
        }
    }
}

//struct HomeFootprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFootprintView(data: .constant(CarbonFootprint.defaultCarbonFootprint.data), carbonFootprintCalculator: CarbonFootprintCalculator(), isPresentingInfoPopUp: .constant(false), popUpMessage: .constant(""), currentSurvey: .constant("Home"))
//    }
//}
