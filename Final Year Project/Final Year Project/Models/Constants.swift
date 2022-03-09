//
//  Constants.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 27/02/2022.
//

import Foundation

struct Constants {
    //Average carbon footprint
    static let AVERAGE_FOOTPRINT = 13200.0;
    
    //Average household annual electricity usage
    static let AVERAGE_ANNUAL_KWH = 4200;
    
    //Average household annual heating energy usage
    static let AVERAGE_ANNUAL_HEATING_KWH = 11000;
    
    //Average price of kWh Ireland 2021S1
    static let AVERAGE_KWH_PRICE = 0.2396;
    
    //Heating fuel kgCO2/kWh
    static let COAL_FACTOR = 0.354
    static let NATURAL_GAS_FACTOR = 0.201
    static let ELECTRICITY_FACTOR = 0.0
    static let KEROSENE_FACTOR = 0.257
    static let LPG_FACTOR = 0.227
    static let PEAT_FACTOR = 0.382
    static let BIOMASS_FACTOR = 0.395
    
    //Car fuel kgCO2/l
    static let PETROL_FACTOR = 2.35
    static let DIESEL_FACTOR = 2.65
    
    //Flight kgCO2/passsenger/km 2019
    static let FLIGHT_FACTOR = 0.09
    
    let beefFootprint = 11.44 //kgCO₂eq per 115 grams raw beef
    let porkFootprint = 1.42 //kgCO₂eq per 115 grams raw pork
    let poultryFootprint = 1.14 //kgCO₂eq per 115 grams raw poultry
    let riceFootprint = 0.2225 //kgCO₂eq per 50 grams uncooked rice
    let fishFootprint = 3.08 //kgCO₂eq per 226 grams raw fish
    let coffeeFootprint = 0.57 //kgCO₂eq per 20 grams ground coffee
    let cheeseFootprint = 0.72 //kgCO₂eq per 30 grams cheese
    let milkFootprint = 0.63 //kgCO₂eq per 200 ml milk
    
}

struct Electricity_Supplier: Identifiable {
    let id: UUID
    var name: String
    var factor: Double
    
    init(id: UUID = UUID(), name: String, factor: Double) {
        self.id = id
        self.name = name
        self.factor = factor
    }
}

extension Constants {
    static let ELECTRICITY_SUPPLIERS: [Electricity_Supplier] =
    [
        Electricity_Supplier(name: "Bord Gáis Energy", factor: 0.328),
        Electricity_Supplier(name: "Electric Ireland", factor: 0.179),
        Electricity_Supplier(name: "Energia", factor: 0),
        Electricity_Supplier(name: "Go Power", factor: 0),
        Electricity_Supplier(name: "Panda Power", factor: 0),
        Electricity_Supplier(name: "SSE Airtricity", factor: 0),
        Electricity_Supplier(name: "Naturgy", factor: 0),
        Electricity_Supplier(name: "Iberdrola", factor: 0),
        Electricity_Supplier(name: "Flogas", factor: 0),
        Electricity_Supplier(name: "Glow Power", factor: 0.406),
        Electricity_Supplier(name: "ElectroRoute", factor: 0),
        Electricity_Supplier(name: "Arden Energy", factor: 0),
        Electricity_Supplier(name: "Bright", factor: 0),
        Electricity_Supplier(name: "BRI Green Energy Supply", factor: 0),
        Electricity_Supplier(name: "Prepay Power", factor: 0.406),
        Electricity_Supplier(name: "Other", factor: 0.236),
    ]
}
