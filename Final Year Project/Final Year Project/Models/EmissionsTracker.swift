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
    var mondayTotal = 0.0
    var tuesdayTotal = 0.0
    var wednesdayTotal = 0.0
    var thursdayTotal = 0.0
    var fridayTotal = 0.0
    var saturdayTotal = 0.0
    var sundayTotal = 0.0
    
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
            if Calendar.current.isDate(action.date, inSameDayAs:monday) {
                mondayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:tuesday) {
                tuesdayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:wednesday) {
                wednesdayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:thursday) {
                thursdayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:friday) {
                fridayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:saturday) {
                saturdayTotal += action.value
            }
            if Calendar.current.isDate(action.date, inSameDayAs:sunday) {
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
    }
    
    func getMonday(myDate: Date) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 2 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek.advanced(by: 3600)
    }
}
