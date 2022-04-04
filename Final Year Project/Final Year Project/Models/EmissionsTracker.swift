//
//  EmissionsTracker.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 03/04/2022.
//

import Foundation

class EmissionTracker: ObservableObject {
    
    @Published var totalEmissionsAvoided: Double = 0.0
    @Published var thisWeeksData: [DataPoint] = []
    @Published var mondayTotal = 0.0
    @Published var tuesdayTotal = 0.0
    @Published var wednesdayTotal = 0.0
    @Published var thursdayTotal = 0.0
    @Published var fridayTotal = 0.0
    @Published var saturdayTotal = 0.0
    @Published var sundayTotal = 0.0
    
    private var actions : [Action] = []
    
    func updateActions (actions: [Action]){
        self.actions = actions
    }
    
    func calculateTotal() {
        totalEmissionsAvoided = 0.0
        for action in actions {
            totalEmissionsAvoided += action.value
        }
    }
    
    func getThisWeeksData() {
        let monday = getMonday(myDate: Date())
        let tuesday = monday.advanced(by: 86400)
        let wednesday = tuesday.advanced(by: 86400)
        let thursday = wednesday.advanced(by: 86400)
        let friday = thursday.advanced(by: 86400)
        let saturday = friday.advanced(by: 86400)
        let sunday = saturday.advanced(by: 86400)
        
        mondayTotal  = 0.0
        tuesdayTotal = 0.0
        wednesdayTotal  = 0.0
        thursdayTotal = 0.0
        fridayTotal  = 0.0
        saturdayTotal = 0.0
        sundayTotal = 0.0
        
        for action in actions {
            if Calendar.current.dateComponents([.day], from: action.date, to: monday).day == 0 {
                mondayTotal += action.value
            }
            print(mondayTotal)
            if Calendar.current.dateComponents([.day], from: action.date, to: tuesday).day == 0 {
                tuesdayTotal += action.value
            }
            if Calendar.current.dateComponents([.day], from: action.date, to: wednesday).day == 0 {
                wednesdayTotal += action.value
            }
            if Calendar.current.dateComponents([.day], from: action.date, to: thursday).day == 0 {
                thursdayTotal += action.value
            }
            if Calendar.current.dateComponents([.day], from: action.date, to: friday).day == 0 {
                fridayTotal += action.value
            }
            if Calendar.current.dateComponents([.day], from: action.date, to: saturday).day == 0 {
                saturdayTotal += action.value
            }
            if Calendar.current.dateComponents([.day], from: action.date, to: sunday).day == 0 {
                sundayTotal += action.value
            }
        }
        
        thisWeeksData = [
            DataPoint(name: "Mon", value: mondayTotal),
            DataPoint(name: "Tue", value: tuesdayTotal),
            DataPoint(name: "Wed", value: wednesdayTotal),
            DataPoint(name: "Thu", value: thursdayTotal),
            DataPoint(name: "Fri", value: fridayTotal),
            DataPoint(name: "Sat", value: saturdayTotal),
            DataPoint(name: "Sun", value: sundayTotal)
        ]
        
        print(thisWeeksData)
    }
    
    func getMonday(myDate: Date) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 3 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
}
