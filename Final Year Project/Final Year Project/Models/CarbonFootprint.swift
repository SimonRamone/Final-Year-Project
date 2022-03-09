//
//  CarbonFootprint.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 21/02/2022.
//

import Foundation

struct CarbonFootprint {
    var totalCarbonFootprint: Double
    var beefServings: Double
    var householdSize: Int
    var electricitySupplier: String
    var electricityFactor: Double
    var electricityUsed: Int
    var isElectricityUnitKWH: Bool
    var isUsingAverageElectricity: Bool
    var heatingFuelType: String
    var dieselBurned: Int
    var petrolBurned: Int
    var flights: [Flight]
    
    internal init(totalCarbonFootprint: Double, beefServings: Double, householdSize: Int, electricitySupplier: String, electricityFactor: Double, electricityUsed: Int, isElectricityUnitKWH: Bool, isUsingAverageElectricity: Bool, heatingFuelType: String, dieselBurned: Int, petrolBurned: Int, flights: [Flight]) {
        self.totalCarbonFootprint = totalCarbonFootprint
        self.beefServings = beefServings
        self.householdSize = householdSize
        self.electricitySupplier = electricitySupplier
        self.electricityFactor = electricityFactor
        self.electricityUsed = electricityUsed
        self.isElectricityUnitKWH = isElectricityUnitKWH
        self.isUsingAverageElectricity = isUsingAverageElectricity
        self.heatingFuelType = heatingFuelType
        self.dieselBurned = dieselBurned
        self.petrolBurned = petrolBurned
        self.flights = flights
    }
}

extension CarbonFootprint {
    struct Data {
        var totalCarbonFootprint: Double = 0
        var beefServings: Double = 0
        var householdSize: Int = 1
        var electricitySupplier: String = "SSE Airtricity"
        var electricityFactor: Double = 0.0
        var electricityUsed: Int = 0
        var isElectricityUnitKWH: Bool = false
        var isUsingAverageElectricity: Bool = false
        var heatingFuelType: String = "Kerosene"
        var dieselBurned: Int = 0
        var petrolBurned: Int = 0
        var flights: [Flight] = []
    }
    
    var data: Data {
        Data(totalCarbonFootprint: totalCarbonFootprint, beefServings: beefServings, householdSize: householdSize, electricitySupplier: electricitySupplier, electricityFactor: electricityFactor, electricityUsed: electricityUsed,
             isElectricityUnitKWH: isElectricityUnitKWH, isUsingAverageElectricity: isUsingAverageElectricity, heatingFuelType: heatingFuelType, dieselBurned: dieselBurned, petrolBurned: petrolBurned, flights: flights)
    }
    
    mutating func update(from data: Data) {
        totalCarbonFootprint = data.totalCarbonFootprint
        beefServings = data.beefServings
        householdSize = data.householdSize
        electricitySupplier = data.electricitySupplier
        electricityFactor = data.electricityFactor
        electricityUsed = data.electricityUsed
        isElectricityUnitKWH = data.isElectricityUnitKWH
        isUsingAverageElectricity = data.isUsingAverageElectricity
        heatingFuelType = data.heatingFuelType
        dieselBurned = data.dieselBurned
        petrolBurned = data.petrolBurned
        flights = data.flights
    }
    
    init(data: Data) {
        totalCarbonFootprint = data.totalCarbonFootprint
        beefServings = data.beefServings
        householdSize = data.householdSize
        electricitySupplier = data.electricitySupplier
        electricityFactor = data.electricityFactor
        electricityUsed = data.electricityUsed
        isElectricityUnitKWH = data.isElectricityUnitKWH
        isUsingAverageElectricity = data.isUsingAverageElectricity
        heatingFuelType = data.heatingFuelType
        dieselBurned = data.dieselBurned
        petrolBurned = data.petrolBurned
        flights = data.flights
    }
}

extension CarbonFootprint {
    static let defaultCarbonFootprint: CarbonFootprint = CarbonFootprint(totalCarbonFootprint: 0, beefServings: 0, householdSize: 1, electricitySupplier: "SSE Airtricity", electricityFactor: 0.0, electricityUsed: 0, isElectricityUnitKWH: false, isUsingAverageElectricity: false, heatingFuelType: "Kerosene", dieselBurned: 0, petrolBurned: 0, flights: [])
}
