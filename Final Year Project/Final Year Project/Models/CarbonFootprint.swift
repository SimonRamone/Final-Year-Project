//
//  CarbonFootprint.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 21/02/2022.
//

import Foundation

struct CarbonFootprint {
    var totalCarbonFootprint: Double
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
    var dietEmissions: Constants.DietEmissions
    var foodWaste: Double
    
    internal init(totalCarbonFootprint: Double, householdSize: Int, electricitySupplier: String, electricityFactor: Double, electricityUsed: Int, isElectricityUnitKWH: Bool, isUsingAverageElectricity: Bool, heatingFuelType: String, dieselBurned: Int, petrolBurned: Int, flights: [Flight], dietEmissions: Constants.DietEmissions, foodWaste: Double) {
        self.totalCarbonFootprint = totalCarbonFootprint
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
        self.dietEmissions = dietEmissions
        self.foodWaste = foodWaste
    }
}

extension CarbonFootprint {
    struct Data {
        var totalCarbonFootprint: Double = 0
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
        var dietEmissions: Constants.DietEmissions = .MediumMeat
        var foodWaste: Double = 0.0
    }
    
    var data: Data {
        Data(totalCarbonFootprint: totalCarbonFootprint, householdSize: householdSize, electricitySupplier: electricitySupplier, electricityFactor: electricityFactor, electricityUsed: electricityUsed,
             isElectricityUnitKWH: isElectricityUnitKWH, isUsingAverageElectricity: isUsingAverageElectricity, heatingFuelType: heatingFuelType, dieselBurned: dieselBurned, petrolBurned: petrolBurned, flights: flights, dietEmissions: dietEmissions, foodWaste: foodWaste)
    }
    
    mutating func update(from data: Data) {
        totalCarbonFootprint = data.totalCarbonFootprint
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
        dietEmissions = data.dietEmissions
        foodWaste = data.foodWaste
    }
    
    init(data: Data) {
        totalCarbonFootprint = data.totalCarbonFootprint
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
        dietEmissions = data.dietEmissions
        foodWaste = data.foodWaste
    }
}

extension CarbonFootprint {
    static let defaultCarbonFootprint: CarbonFootprint = CarbonFootprint(totalCarbonFootprint: 0, householdSize: 1, electricitySupplier: "SSE Airtricity", electricityFactor: 0.0, electricityUsed: 0, isElectricityUnitKWH: false, isUsingAverageElectricity: false, heatingFuelType: "Kerosene", dieselBurned: 0, petrolBurned: 0, flights: [], dietEmissions: Constants.DietEmissions.MediumMeat, foodWaste: 0)
}
