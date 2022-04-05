//
//  CarbonFootprintCalculator.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/02/2022.
//

import Foundation
import SwiftUI
import GameKit

class CarbonFootprintCalculator: ObservableObject {
    @Published var carbonFootprint = 0.0
    @Published var homeCarbonFootprint = 0.0
    @Published var transportCarbonFootprint = 0.0
    @Published var dietCarbonFootprint = 0.0
    @Published var goodsCarbonFootprint = 0.0
    @Published var percentHome = 0.0
    @Published var percentTransport = 0.0
    @Published var percentDiet = 0.0
    @Published var percentGoods = 0.0
    
    private(set) var carbonFootprintData: CarbonFootprint.Data
    private var heatingFactor: Double = 0.0
    private var electricityFactor: Double = 0.0
    private var electricityEmissions: Double = 0.0
    private var heatingEmissions: Double = 0.0
    private var flightEmissions: Double = 0.0
    private var carEmissions: Double = 0.0
    private var foodWasteEmissions: Double = 0.0
    private var dietEmissions: Double = 0.0
    
    internal init(carbonFootprintData: CarbonFootprint.Data = CarbonFootprint.Data()) {
        self.carbonFootprintData = carbonFootprintData
    }
    
    func updateCarbonFootprintData(carbonFootprintData: CarbonFootprint.Data) {
        self.carbonFootprintData = carbonFootprintData
    }
    
    func recalculateCarbonFootprint() {
        calculateHomeCarbonFootprint()
        calculateTransportCarbonFootprint()
        calculateDietCarbonFootprint()
        calculateGoodsCarbonFootprint()
        calculateCarbonFootprint()
    }
    
    func calculateCarbonFootprint() {
        carbonFootprint = homeCarbonFootprint + transportCarbonFootprint + dietCarbonFootprint + goodsCarbonFootprint
        percentHome = carbonFootprint > 0 ? homeCarbonFootprint/carbonFootprint : 0.0
        percentTransport = carbonFootprint > 0 ? transportCarbonFootprint/carbonFootprint : 0.0
        percentDiet = carbonFootprint > 0 ? dietCarbonFootprint/carbonFootprint : 0.0
        percentGoods = carbonFootprint > 0 ? goodsCarbonFootprint/carbonFootprint : 0.0
    }
    
    func calculateGoodsCarbonFootprint() {
        goodsCarbonFootprint = carbonFootprintData.goodsEmissions.mobileDataUsage * Constants.MOBILE_DATA_FOOTPRINT * 12 + carbonFootprintData.goodsEmissions.expensesClothing * Constants.CLOTHING_FOOTPRINT * 12 + carbonFootprintData.goodsEmissions.expensesElectronics * Constants.ELECTRONICS_FOOTPRINT + carbonFootprintData.goodsEmissions.expensesStreaming * Constants.STREAMING_FOOTPRINT * 12
    }
    
    func calculateDietCarbonFootprint() {
        calculateFoodWasteEmissions()
        calculateHighEmissionFoodsFootprint()
        dietCarbonFootprint = dietEmissions < carbonFootprintData.dietEmissions.rawValue ? carbonFootprintData.dietEmissions.rawValue : dietEmissions
        dietCarbonFootprint += foodWasteEmissions;
    }
    
    func calculateFoodWasteEmissions() {
        foodWasteEmissions = carbonFootprintData.foodWaste * Constants.FOOD_WASTE_FACTOR * 52
    }
    
    func calculateHighEmissionFoodsFootprint() {
        dietEmissions = carbonFootprintData.highEmissionFoods.beefServings * Constants.BEEF_FOOTPRINT + carbonFootprintData.highEmissionFoods.porkServings * Constants.PORK_FOOTPRINT + carbonFootprintData.highEmissionFoods.poultryServings * Constants.POULTRY_FOOTPRINT + carbonFootprintData.highEmissionFoods.riceServings * Constants.RICE_FOOTPRINT + carbonFootprintData.highEmissionFoods.fishServings * Constants.FISH_FOOTPRINT + carbonFootprintData.highEmissionFoods.coffeeServings * Constants.COFFEE_FOOTPRINT + carbonFootprintData.highEmissionFoods.cheeseServings * Constants.CHEESE_FOOTPRINT + carbonFootprintData.highEmissionFoods.milkServings * Constants.MILK_FOOTPRINT;
        dietEmissions = dietEmissions * 52;
    }
    
    func calculateTransportCarbonFootprint() {
        calculateCarEmissions()
        calculateFlightEmissions()
        transportCarbonFootprint = carEmissions + flightEmissions
    }
    
    func calculateCarEmissions() {
        carEmissions = Double(carbonFootprintData.petrolBurned * 52) * Constants.PETROL_FACTOR + Double(carbonFootprintData.dieselBurned * 52) * Constants.DIESEL_FACTOR
    }
    
    func calculateFlightEmissions() {
        flightEmissions = 0
        for flight in carbonFootprintData.flights {
            var thisFlightsEmissions = haversine(longitudeDegrees1: flight.fromAirport.longitude, latitudeDegrees1: flight.fromAirport.latitude, longitudeDegrees2: flight.toAirport.longitude, latitudeDegrees2: flight.toAirport.latitude) * Constants.FLIGHT_FACTOR
            if flight.isReturn {
                thisFlightsEmissions *= 2.0
            }
            thisFlightsEmissions *= Double(flight.numberOfTrips)
            flightEmissions += thisFlightsEmissions
        }
    }
    
    //Calculate the great circle distance between two points on the earth (specified in decimal degrees)
    func haversine(longitudeDegrees1: Double, latitudeDegrees1: Double, longitudeDegrees2: Double, latitudeDegrees2: Double) -> Double {
        //convert decimal degrees to radians
        let longitude1 = degreesToRadians(longitudeDegrees1)
        let longitude2 = degreesToRadians(longitudeDegrees2)
        let latitude1 = degreesToRadians(latitudeDegrees1)
        let latitude2 = degreesToRadians(latitudeDegrees2)
        
        //haversine formula
        let dlon = longitude2 - longitude1
        let dlat = latitude2 - latitude1
        let a = pow(sin(dlat/2), 2) + cos(latitude1) * cos(latitude2) * pow(sin(dlon/2), 2)
        let c = 2 * asin(sqrt(a))
        let r = 6371.0 //Radius of earth in kilometers.
        return c * r
    }
    
    func degreesToRadians(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func calculateHomeCarbonFootprint() {
        calculateElectricityEmissions()
        calculateHeatingEmissions()
        homeCarbonFootprint = electricityEmissions + heatingEmissions
    }
    
    func calculateElectricityEmissions() {
        calculateElectricityFactor()
        if carbonFootprintData.isUsingAverageElectricity {
            electricityEmissions = Double(Constants.AVERAGE_ANNUAL_KWH) * electricityFactor / Double(carbonFootprintData.householdSize)
        } else if carbonFootprintData.isElectricityUnitKWH {
            electricityEmissions = (Double(12 * carbonFootprintData.electricityUsed) * electricityFactor) / Double(carbonFootprintData.householdSize)
        } else {
            electricityEmissions = Double(12 * carbonFootprintData.electricityUsed) / Constants.AVERAGE_KWH_PRICE * electricityFactor / Double(carbonFootprintData.householdSize)
        }
    }
    
    func calculateHeatingEmissions() {
        calculateHeatingFactor()
        heatingEmissions = (heatingFactor * Double(Constants.AVERAGE_ANNUAL_HEATING_KWH)) / Double(carbonFootprintData.householdSize)
    }
    
    func calculateElectricityFactor() {
        for electricitySupplier in Constants.ELECTRICITY_SUPPLIERS {
            if electricitySupplier.name == carbonFootprintData.electricitySupplier {
                electricityFactor = electricitySupplier.factor
            }
        }
    }
    
    func calculateHeatingFactor() {
        switch (carbonFootprintData.heatingFuelType)  {
        case "Coal":
            heatingFactor = Constants.COAL_FACTOR
        case "Natural Gas":
            heatingFactor = Constants.NATURAL_GAS_FACTOR
        case "Electricity":
            heatingFactor = Constants.ELECTRICITY_FACTOR
        case "Kerosene":
            heatingFactor = Constants.KEROSENE_FACTOR
        case "LPG":
            heatingFactor = Constants.LPG_FACTOR
        case "Peat":
            heatingFactor = Constants.PEAT_FACTOR
        case "Biomass":
            heatingFactor = Constants.BIOMASS_FACTOR
        default:
            heatingFactor = 0.0
        }
    }
}

extension CarbonFootprint {
    var calculator: CarbonFootprintCalculator {
        CarbonFootprintCalculator(carbonFootprintData: Data())
    }
}
