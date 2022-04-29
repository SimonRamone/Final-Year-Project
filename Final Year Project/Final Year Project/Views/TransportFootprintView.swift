//
//  TransportFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 06/03/2022.
//

import SwiftUI
import TabularData

struct TransportFootprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var numberOfQuestions = 3
    @State var questionNr = 0
    @State var data = CarbonFootprint.Data()
    @Binding var user: User
    @ObservedObject var carbonFootprintCalculator: CarbonFootprintCalculator
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    
    @State var airports: [Flight.Airport] = []
    @State var filteredAirports: [Flight.Airport] = []
    @State private var searchText = ""
    @State var flight = Flight(fromAirport: Flight.Airport(), toAirport: Flight.Airport(), isReturn: true, numberOfTrips: 1)
    @State private var isPresentingFlightView = false
    @State private var selection = "Diesel"
    @Binding var currentSurvey: String
    @Binding var isPresentingSheet: Bool
    let airportsData = NSDataAsset(name: "airports-data", bundle: Bundle.main)
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                switch (questionNr)  {
                case 0:
                    VStack{
                        Image(systemName: "car.fill")
                            .font(.system(size: 100))
                        Text("Travel Footprint Survey")
                            .font(.headline)
                        Text("2 Questions")
                    }
                    .onAppear(){
                        popUpMessage = "This part will calculate emissions related to your travel habits."
                    }
                case 1:
                    VStack{
                        Text("How many litres of **fuel** did you burn last week?")
                            .font(.largeTitle)
                        Picker("Petrol or Diesel", selection: $selection) {
                            Text("Petrol").tag("Petrol")
                            Text("Diesel").tag("Diesel")
                        }
                        .pickerStyle(.segmented)
                        if selection == "Petrol" {
                            TextField("Petrol", value: $data.petrolBurned, format: .number)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        } else {
                            TextField("Diesel", value: $data.dieselBurned, format: .number)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "If you don't own a car or your car is fully electric skip this question. If you carpool divide the litres by the number of people carpooling."
                    }
                case 2:
                    VStack{
                        Text("How many **flights** did you take in the past year?" )
                            .font(.largeTitle)
                        List {
                            Button {
                                isPresentingFlightView.toggle()
                            } label: {
                                Label("Add Flight", systemImage: "plus.circle.fill")
                            }.sheet(isPresented: $isPresentingFlightView) {
                                NavigationView {
                                    FlightView(airports: $airports, flight: $flight)
                                        .toolbar {
                                            ToolbarItem(placement: .cancellationAction) {
                                                Button("Cancel") {
                                                    isPresentingFlightView = false
                                                    flight = Flight(fromAirport: Flight.Airport(), toAirport: Flight.Airport(), isReturn: true, numberOfTrips: 1)
                                                }
                                            }
                                            ToolbarItem(placement: .confirmationAction) {
                                                Button("Done") {
                                                    isPresentingFlightView = false
                                                    if !flight.fromAirport.name.isEmpty && !flight.toAirport.name.isEmpty && flight.fromAirport != flight.toAirport {
                                                        data.flights.append(flight)
                                                    }
                                                    flight = Flight(fromAirport: Flight.Airport(), toAirport: Flight.Airport(), isReturn: true, numberOfTrips: 1)
                                                }
                                            }
                                        }
                                }
                            }
                            Section {
                                ForEach (data.flights) { flight in
                                    HStack {
                                        Label(flight.data.fromAirport.code, systemImage: "airplane.departure")
                                        if flight.data.isReturn {
                                            Image(systemName: "arrow.left.arrow.right")
                                        } else {
                                            Image(systemName: "arrow.right")
                                        }
                                        Label(flight.data.toAirport.code, systemImage: "airplane.arrival")
                                        Spacer()
                                        Text("x \(flight.data.numberOfTrips)")
                                    }
                                    
                                }
                                .onDelete { indices in
                                    data.flights.remove(atOffsets: indices)
                                }
                            }
                        }
                        .frame(maxHeight: 300, alignment: .center)
                        .cornerRadius(25)
                        .onAppear(){
                            UITableView.appearance().showsVerticalScrollIndicator = false
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    .onAppear(){
                        popUpMessage = "Average flight emissions are \(Constants.FLIGHT_FACTOR) kgCO₂ per passenger per km."
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
                            user.carbonFootprint.update(from: data)
                            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
                            self.presentationMode.wrappedValue.dismiss()
                            currentSurvey = "Diet"
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
        .navigationTitle("Travel Footprint")
        .onAppear(){
            data = user.carbonFootprint.data
            if airports.isEmpty {
                do {
                    airports = try JSONDecoder().decode([Flight.Airport].self, from: airportsData!.data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .onChange(of: isPresentingSheet){ item in
            if !isPresentingSheet {
                user.carbonFootprint.update(from: data)
                carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            }
        }
        .onDisappear(){
            user.carbonFootprint.update(from: data)
            carbonFootprintCalculator.updateCarbonFootprintData(carbonFootprintData: data)
            carbonFootprintCalculator.calculateTransportCarbonFootprint()
            carbonFootprintCalculator.calculateCarbonFootprint()
        }
        .onAppear(){
            data = user.carbonFootprint.data
        }
    }
}
