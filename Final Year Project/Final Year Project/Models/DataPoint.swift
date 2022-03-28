//
//  DataPoint.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 27/03/2022.
//

import Foundation

struct DataPoint: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let value: Double
}



extension DataPoint {
    static var sampleData: [DataPoint] = [
        DataPoint(name: "Mon", value: 1.1),
        DataPoint(name: "Tue", value: 2.0),
        DataPoint(name: "Wed", value: 4.0),
        DataPoint(name: "Thu", value: 1.0),
        DataPoint(name: "Fri", value: 0.0),
        DataPoint(name: "Sat", value: 2.0),
        DataPoint(name: "Sun", value: 0.5)
    ]
}
