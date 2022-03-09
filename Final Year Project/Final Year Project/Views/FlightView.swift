//
//  FlightView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 08/03/2022.
//

import SwiftUI

struct FlightView: View {
    @Binding var airports: [Flight.Airport]
    @Binding var flight: Flight
    var body: some View {
        Form {
            Section(header: Text("Flight Info")) {
                Toggle("Return Trip", isOn: $flight.isReturn)
                HStack{
                    Label("From", systemImage: "airplane.departure")
                    AirportPicker(selection: $flight.fromAirport, airports: $airports)
                
                }
                HStack{
                    Label("To", systemImage: "airplane.arrival")
                    AirportPicker(selection: $flight.toAirport, airports: $airports)
                }
                Stepper("Trips: \(flight.numberOfTrips)", value: $flight.numberOfTrips, in: 1...100)
            }
        }
    }
}
