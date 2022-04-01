//
//  Flight.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 07/03/2022.
//

import Foundation
import SwiftUI

struct Flight: Identifiable, Codable, Equatable {
    internal init(id: UUID = UUID(), fromAirport: Flight.Airport, toAirport: Flight.Airport, isReturn: Bool, numberOfTrips: Int) {
        self.id = id
        self.fromAirport = fromAirport
        self.toAirport = toAirport
        self.isReturn = isReturn
        self.numberOfTrips = numberOfTrips
    }
    
    let id: UUID
    var fromAirport: Airport
    var toAirport: Airport
    var isReturn: Bool
    var numberOfTrips: Int
}

extension Flight {
    struct Data {
        var fromAirport = Airport()
        var toAirport = Airport()
        var isReturn = true
        var numberOfTrips = 1
    }
    
    var data: Data {
        Data(fromAirport: fromAirport, toAirport: toAirport, isReturn: isReturn, numberOfTrips: numberOfTrips)
    }
    
    mutating func update(from data: Data) {
        fromAirport = data.fromAirport
        toAirport = data.toAirport
        isReturn = data.isReturn
        numberOfTrips = data.numberOfTrips
    }
    
    init(data: Data) {
        id = UUID()
        fromAirport = data.fromAirport
        toAirport = data.toAirport
        isReturn = data.isReturn
        numberOfTrips = data.numberOfTrips
    }
}

extension Flight {
    struct Airport: Codable, Identifiable, Hashable, Equatable {
        internal init(id: Int = 0, name: String = "", code: String = "", latitude: Double = 0.0, longitude: Double = 0.0) {
            self.id = id
            self.name = name
            self.code = code
            self.latitude = latitude
            self.longitude = longitude
        }
        
        let id: Int
        var name: String
        var code: String
        var latitude: Double
        var longitude: Double
    }
}
