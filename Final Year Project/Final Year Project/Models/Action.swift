//
//  Action.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 03/04/2022.
//

import Foundation

struct Action: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var type: String
    var value: Double
    var date: Date = Date()
    
    
    init(name: String, type: String, value: Double) {
        self.name = name
        self.type = type
        self.value = value
    }
    
    init() {
        self.name = ""
        self.type = ""
        self.date = Date()
        self.value = 0.0
    }
    
    private enum CodingKeys : String, CodingKey { case name, type, date, value}
}

extension Action {
    static let dietActions: [Action] =
    [
        Action(name: "Beefless Meal", type: "Diet", value: Constants.BEEF_FOOTPRINT),
        Action(name: "Skip Coffee", type: "Diet", value: Constants.COFFEE_FOOTPRINT),
        Action(name: "Plant-Based Milk", type: "Diet", value: Constants.MILK_FOOTPRINT)
    ]
    static let homeActions: [Action] =
    [
        Action(name: "Wash Clothes on Cold", type: "Home", value: 0.06)
    ]
    static let travelActions: [Action] =
    [
        Action(name: "Cycled 1km", type: "Travel", value: 0.2),
        Action(name: "Cycled 5km", type: "Travel", value: 1.0),
        Action(name: "Cycled 10km", type: "Travel", value: 2.0)
    ]
    static let goodsActions: [Action] =
    [
        Action(name: "Recycled 10kg of Electronics", type: "Goods", value: 23.6),
        Action(name: "Second-Hand clothing", type: "Goods", value: Constants.CLOTHING_FOOTPRINT * 50.0)
    ]
    static let miscActions: [Action] =
    [
        Action(name: "Offset 10kg CO₂", type: "Misc", value: 10.0)
    ]
}
