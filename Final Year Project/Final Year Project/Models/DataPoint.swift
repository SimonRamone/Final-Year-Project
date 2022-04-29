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
        DataPoint(name: "Mon", value: 11.4),
        DataPoint(name: "Tue", value: 14.0),
        DataPoint(name: "Wed", value: 8.0),
        DataPoint(name: "Thu", value: 17.5),
        DataPoint(name: "Fri", value: 0.0),
        DataPoint(name: "Sat", value: 6.0),
        DataPoint(name: "Sun", value: 8.0)
    ]
}
