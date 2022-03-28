//
//  TrackEmissionView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import SwiftUI

struct TrackEmissionView: View {
    var body: some View {
        Form {
            Section(header: Label("Home", systemImage: "house.fill")) {
                Text("Vegan Meal")
            }
            Section(header: Label("Transport", systemImage: "car.fill")) {
                Text("Cycle to Work")
                Text("Carpool")
            }
            Section(header: Label("Diet", systemImage: "fork.knife")) {
                Text("Vegan Meal")
                Text("Plant-based Milk")
                Text("Skip Coffee")
            }
            Section(header: Label("Shopping", systemImage: "cart.fill")) {
                Text("Recycle Electronics")
            }
            Section(header: Label("miscellaneous", systemImage: "puzzlepiece.extension.fill")) {
                Text("Offset Emissions")
            }
        }
    }
}

struct TrackEmissionView_Previews: PreviewProvider {
    static var previews: some View {
        TrackEmissionView()
    }
}
