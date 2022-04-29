//
//  TrackView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct TrackView: View {
    @StateObject private var emissionTracker = EmissionTracker()
    @Binding var user : User
    @State private var isPresentingNewEmissionView = false
    @State private var data : [DataPoint] = []
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    var body: some View {
        NavigationView {
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 30 , height: 100)
                    
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Total Emissions Avoided")
                                    .font(.headline)
                                Text(String(format: "%.2f", emissionTracker.totalEmissionsAvoided) + " kg")
                                    .font(.largeTitle)
                            }
                            .padding()
                            .foregroundColor(Color.black)
                            Spacer()
                        }
                    }
                }
                .cornerRadius(20)
                .padding(.top)
                .padding(.horizontal)
                if !user.actions.isEmpty {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                        
                        BarChartView(data: $data, caption: "This Week", unit: "kg")
                            .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                    .cornerRadius(20)
                    .padding(.top)
                    .padding(.horizontal)
                }
                if !user.actions.isEmpty{
                    HStack {
                        Text("History")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                ForEach($user.actions.reversed()){ action in
                    EmissionCardView(name: action.name, value: action.value, entryType: action.type)
                }             
            }
            .onAppear(){
                emissionTracker.updateActions(actions: user.actions)
                emissionTracker.calculateTotal()
                emissionTracker.getThisWeeksData()
                data = emissionTracker.thisWeeksData
            }
            .onChange(of: user.actions) { item in
                emissionTracker.updateActions(actions: user.actions)
                emissionTracker.calculateTotal()
                emissionTracker.getThisWeeksData()
                data = emissionTracker.thisWeeksData
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Track Emissions")
            .toolbar {
                HStack{
                    Button(action: {
                        isPresentingNewEmissionView = true
                    }, label: {
                        HStack{
                            Text("Add Action")
                            Image(systemName: "plus")
                        }
                        .font(.headline)
                    })
                    Button(action: {
                        popUpMessage = "✅ Only track an action when it replaces a high emissions action. ❌ Don't track actions you already do on a daily basis."
                        isPresentingInfoPopUp.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                    })}
            }
            .sheet(isPresented: $isPresentingNewEmissionView) {
                NavigationView {
                    TrackEmissionView(user: $user)
                        .navigationTitle("Add Action")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewEmissionView = false
                                }
                            }
                        }
                }
            }
        }
    }
}
