//
//  BarChartView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 27/03/2022.
//

import SwiftUI

struct BarChartView: View {
    @Binding var data: [DataPoint]
    @State var maxValue = 0.0
    @State var isFocused = [DataPoint : Bool]()
    @State var isSelected = false
    var body: some View {
        GeometryReader { geo in
        HStack {
            ForEach(data) { dataPoint in
                let barHeight = geo.size.height * dataPoint.value * 0.8 / maxValue
                    VStack {
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(!isSelected && !(isFocused[dataPoint] ?? false) ? .blue : isFocused[dataPoint] ?? false ? .blue : .gray.opacity(0.2))
                                .frame(height: barHeight)
                            if((isFocused[dataPoint] ?? false) && barHeight > 15){
                                Text(String(format: "%.1f", dataPoint.value))
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                    .truncationMode(.tail)
                                    .lineLimit(1)
                            }
                        }
                        .onTapGesture {
                            if(!isSelected){
                                isFocused[dataPoint]?.toggle()
                                isSelected.toggle()
                            } else if (isFocused[dataPoint] ?? false) {
                                isFocused[dataPoint]?.toggle()
                                isSelected.toggle()
                            } else if (!(isFocused[dataPoint] ?? false)) {
                                for dataPoint in data {
                                    isFocused[dataPoint] = false
                                }
                                isFocused[dataPoint]?.toggle()
                                
                            }
                        }
                        Text(dataPoint.name)
                            .font(.caption)
                            .truncationMode(.tail)
                            .lineLimit(1)
                }
            }
        }
    }
        .edgesIgnoringSafeArea(.all)
        .onAppear(){
            for dataPoint in data {
                isFocused[dataPoint] = false
            }
            isSelected = false
            maxValue = data.map { $0.value }.max()!
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: .constant(DataPoint.sampleData))
    }
}
