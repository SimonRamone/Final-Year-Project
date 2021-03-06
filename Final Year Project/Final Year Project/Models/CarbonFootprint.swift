//
//  CarbonFootprint.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 21/02/2022.
//

import Foundation

struct CarbonFootprint: Codable {
    var totalCarbonFootprint: Double = 0.0
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
    var dietEmissions: Constants.DietEmissions = Constants.DietEmissions.MediumMeat
    var foodWaste: Double = 0.0
    var highEmissionFoods: HighEmissionFoods = HighEmissionFoods()
    var goodsEmissions: GoodsEmissions = GoodsEmissions()
    
    internal init(totalCarbonFootprint: Double, householdSize: Int, electricitySupplier: String, electricityFactor: Double, electricityUsed: Int, isElectricityUnitKWH: Bool, isUsingAverageElectricity: Bool, heatingFuelType: String, dieselBurned: Int, petrolBurned: Int, flights: [Flight], dietEmissions: Constants.DietEmissions, foodWaste: Double, highEmissionFoods: HighEmissionFoods, goodsEmissions: GoodsEmissions) {
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
        self.highEmissionFoods = highEmissionFoods
        self.goodsEmissions = goodsEmissions
    }
}

extension CarbonFootprint {
    struct Data: Codable, Equatable {
        var totalCarbonFootprint: Double = 0
        var householdSize: Int = 1
        var electricitySupplier: String = ""
        var electricityFactor: Double = 0.0
        var electricityUsed: Int = 0
        var isElectricityUnitKWH: Bool = false
        var isUsingAverageElectricity: Bool = false
        var heatingFuelType: String = ""
        var dieselBurned: Int = 0
        var petrolBurned: Int = 0
        var flights: [Flight] = []
        var dietEmissions: Constants.DietEmissions = .none
        var foodWaste: Double = 0.0
        var highEmissionFoods: HighEmissionFoods = HighEmissionFoods(beefServings: 0, porkServings: 0, poultryServings: 0, riceServings: 0, fishServings: 0, coffeeServings: 0, cheeseServings: 0, milkServings: 0)
        var goodsEmissions: GoodsEmissions = GoodsEmissions(expensesClothing: 0, expensesElectronics: 0, expensesPaper: 0, expensesStreaming: 0, mobileDataUsage: 0)
    }
    
    var data: Data {
        Data(totalCarbonFootprint: totalCarbonFootprint, householdSize: householdSize, electricitySupplier: electricitySupplier, electricityFactor: electricityFactor, electricityUsed: electricityUsed,
             isElectricityUnitKWH: isElectricityUnitKWH, isUsingAverageElectricity: isUsingAverageElectricity, heatingFuelType: heatingFuelType, dieselBurned: dieselBurned, petrolBurned: petrolBurned, flights: flights, dietEmissions: dietEmissions, foodWaste: foodWaste, highEmissionFoods: highEmissionFoods, goodsEmissions: goodsEmissions)
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
        highEmissionFoods = data.highEmissionFoods
        goodsEmissions = data.goodsEmissions
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
        highEmissionFoods = data.highEmissionFoods
        goodsEmissions = data.goodsEmissions
    }
}

extension CarbonFootprint {
    struct HighEmissionFoods: Codable, Equatable {
        var beefServings = 0.0;
        var porkServings = 0.0;
        var poultryServings = 0.0;
        var riceServings = 0.0;
        var fishServings = 0.0;
        var coffeeServings = 0.0;
        var cheeseServings = 0.0;
        var milkServings = 0.0;
    }
    
    struct GoodsEmissions: Codable, Equatable {
        var expensesClothing = 0.0;
        var expensesElectronics = 0.0;
        var expensesPaper = 0.0;
        var expensesStreaming = 0.0;
        var mobileDataUsage = 0.0;
    }
}

extension CarbonFootprint {
    static let defaultCarbonFootprint: CarbonFootprint = CarbonFootprint(totalCarbonFootprint: 0, householdSize: 1, electricitySupplier: "SSE Airtricity", electricityFactor: 0.0, electricityUsed: 0, isElectricityUnitKWH: false, isUsingAverageElectricity: false, heatingFuelType: "Kerosene", dieselBurned: 0, petrolBurned: 0, flights: [], dietEmissions: Constants.DietEmissions.MediumMeat, foodWaste: 0, highEmissionFoods: HighEmissionFoods(beefServings: 0, porkServings: 0, poultryServings: 0, riceServings: 0, fishServings: 0, coffeeServings: 0, cheeseServings: 0, milkServings: 0), goodsEmissions: GoodsEmissions(expensesClothing: 0, expensesElectronics: 0, expensesPaper: 0, expensesStreaming: 0, mobileDataUsage: 0))
}
