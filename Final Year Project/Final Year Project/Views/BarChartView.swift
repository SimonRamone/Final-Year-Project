//
//  BarChartView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 27/03/2022.
//

import SwiftUI

struct BarChartView: View {
    @Binding var data: [DataPoint]
    @State var barChartData: [DataPoint] = []
    var caption: String
    var unit: String
    @State var maxValue = 0.0
    @State var isFocused = [DataPoint : Bool]()
    @State var isSelected = false
    @State var selected: DataPoint = DataPoint(name: "", value: 0.0)
    var body: some View {
        VStack {
            if maxValue > 0 {
                HStack{
                    VStack(alignment: .leading){
                        Text(caption)
                            .font(.headline)
                        Text(String(format: "%.1f", barChartData.reduce(0){$0 + $1.value}) + " " + unit)
                            .font(.largeTitle)
                    }
                    .foregroundColor(Color.black)
                    Spacer()
                    if isSelected {
                        VStack(alignment: .trailing){
                            Text(selected.name)
                                .font(.headline)
                            Text(String(format: "%.1f", selected.value) + " " + unit)
                                .font(.largeTitle)
                        }
                        .foregroundColor(Color.blue)
                    }
                }
                GeometryReader { geo in
                    HStack {
                        ForEach(barChartData) { dataPoint in
                            let barHeight = geo.size.height * dataPoint.value * 0.9 / maxValue
                            VStack {
                                Spacer()
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(!isSelected && !(isFocused[dataPoint] ?? false) ? .blue : isFocused[dataPoint] ?? false ? .blue : .gray.opacity(0.2))
                                    .frame(height: min(UIScreen.main.bounds.height, max(barHeight, 0.0)))
                                    .padding(.top, dataPoint.value == maxValue ? -15.5 : 0)
                                Text(dataPoint.name)
                                    .font(.caption)
                                    .truncationMode(.tail)
                                    .lineLimit(1)
                            }
                            .onTapGesture {
                                if(!isSelected){
                                    isFocused[dataPoint]?.toggle()
                                    selected = dataPoint
                                    isSelected.toggle()
                                } else if (isFocused[dataPoint] ?? false) {
                                    isFocused[dataPoint]?.toggle()
                                    selected = dataPoint
                                    isSelected.toggle()
                                } else if (!(isFocused[dataPoint] ?? false)) {
                                    for dataPoint in data {
                                        isFocused[dataPoint] = false
                                    }
                                    isFocused[dataPoint]?.toggle()
                                    selected = dataPoint
                                }
                            }
                        }
                    }
                }
            }
            else {
                Text("No Data")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onChange(of: data) { data in
            for dataPoint in data {
                isFocused[dataPoint] = false
            }
            barChartData = data
            isSelected = false
            maxValue = barChartData.map { $0.value }.max()!
        }
        .onAppear(){
            for dataPoint in data {
                isFocused[dataPoint] = false
            }
            barChartData = data
            isSelected = false
            maxValue = barChartData.map { $0.value }.max()!
        }
    }
}
