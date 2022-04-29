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
                Button(action: {
                    isPresentingNewEmissionView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
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
