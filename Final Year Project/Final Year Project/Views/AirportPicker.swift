//
//  AirportPicker.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 08/03/2022.
//

import SwiftUI

struct AirportPicker: View {
    @Binding var selection: Flight.Airport
    @Binding var airports: [Flight.Airport]
    
    @State var filteredAirports: [Flight.Airport] = []
    @State private var searchText = ""
    
    var body: some View {
        Picker("", selection: $selection) {
            SearchBar(text: $searchText, placeholder: "Search Airports")
            ForEach(filteredAirports) { airport in
                Text(airport.name).tag(airport)
            }
        }
        .onChange(of: searchText) { searchText in
            if !searchText.isEmpty {
                filteredAirports = airports.filter { $0.name.lowercased().starts(with: searchText.lowercased()) }
                if filteredAirports.isEmpty {
                    filteredAirports = airports.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
            } else {
                filteredAirports = []
            }
        }
    }
}
