//
//  DietFootprintView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 16/02/2022.
//

import SwiftUI

struct DietFootprintView: View {
    @State private var isPresentingInfoPopUp: Bool = false
    let beefFootprint = 11.44 //kgCO₂eq per 115 grams raw beef
    let porkFootprint = 1.42 //kgCO₂eq per 115 grams raw pork
    let poultryFootprint = 1.14 //kgCO₂eq per 115 grams raw poultry
    let riceFootprint = 0.2225 //kgCO₂eq per 50 grams uncooked rice
    let fishFootprint = 3.08 //kgCO₂eq per 226 grams raw fish
    let coffeeFootprint = 0.57 //kgCO₂eq per 20 grams ground coffee
    let cheeseFootprint = 0.72 //kgCO₂eq per 30 grams cheese
    let milkFootprint = 0.63 //kgCO₂eq per 200 ml milk
    var numberOfQuestions = 5
    @State var popUpMessage = ""
    @State var questionNr = 0
    
    @Binding var data: CarbonFootprint.Data
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        isPresentingInfoPopUp.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                    }).padding(.trailing, 20)
                }
                Spacer()
                switch (questionNr)  {
                case 0:
                    VStack{
                        Text("How many servings of **beef** did you consume in the past week?" ).padding(.horizontal)
                            .font(.largeTitle)
                        Text("\(Int(data.beefServings)) servings")
                            .padding(.top)
                        Slider(value: $data.beefServings, in: 0...10, step: 1) {
                            Text("Length")
                        }.padding(.horizontal, 20)
                    }
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw beef."
                    }
                case 1:
                    VStack{
                        Text("How many servings of **pork** did you consume in the past week?" )
                            .font(.largeTitle)
                        Text("\(Int(data.beefServings)) servings")
                            .padding(.top)
                        Slider(value: $data.beefServings, in: 0...10, step: 1) {
                            Text("Length")
                        }.padding(.horizontal, 20)
                    }
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw pork."
                    }
                case 2:
                    VStack{
                        Text("How many servings of **poultry** did you consume in the past week?" )
                            .font(.largeTitle)
                        Text("\(Int(data.beefServings)) servings")
                            .padding(.top)
                        Slider(value: $data.beefServings, in: 0...10, step: 1) {
                            Text("Length")
                        }.padding(.horizontal, 20)
                    }
                    .onAppear(){
                        popUpMessage = "One serving is 115 grams of raw poultry."
                    }
                case 3:
                    VStack{
                        Text("How many cups of **coffee** did you consume in the past week?" )
                            .font(.largeTitle)
                        Text("\(Int(data.beefServings)) cups")
                            .padding(.top)
                        Slider(value: $data.beefServings, in: 0...20, step: 1) {
                            Text("Length")
                        }.padding(.horizontal, 20)
                    }
                    .onAppear(){
                        popUpMessage = "One cup is a double espresso or 20 grams of ground coffee."
                    }
                case 4:
                    VStack{
                        Text("How many slices of **cheese** did you consume in the past week?" )
                            .font(.largeTitle)
                        Text("\(Int(data.beefServings)) slices")
                            .padding(.top)
                        Slider(value: $data.beefServings, in: 0...20, step: 2) {
                            Text("Length")
                        }.padding(.horizontal, 20)
                    }
                    .onAppear(){
                        popUpMessage = "Two slices of cheese is 30 grams."
                    }
                default:
                    Text("Default")
                }
                Spacer()
                HStack{

                        Button(action: {
                            questionNr -= 1
                        }) {
                            Text("Previous")
                        }.disabled(questionNr <= 0)
                        Spacer()
                        Button(action: {
                            questionNr += 1
                        }) {
                            Text("Next")
                        }.disabled(questionNr >= numberOfQuestions-1)
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
//                Button(action: {
//                }) {
//                    Text("Submit")
//                        .padding()
//                }
//                .foregroundColor(.white)
//                .background(.blue)
//                .cornerRadius(22)
            }
            PopUpView(isPresented: $isPresentingInfoPopUp, title: "", message: popUpMessage, buttonText: "Got it!")
        }
    }
}

struct DietFootprintView_Previews: PreviewProvider {
    static var previews: some View {
        DietFootprintView(data: .constant(CarbonFootprint.defaultCarbonFootprint.data))
    }
}
