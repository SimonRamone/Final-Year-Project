//
//  TrackView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct TrackView: View {
    @State private var isPresentingNewEmissionView = false
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
                                Text("41.7 kg")
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
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                    
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("This Week")
                                    .font(.headline)
                                Text("11 kg")
                                    .font(.largeTitle)
                            }
                            .padding()
                            .foregroundColor(Color.black)
                            Spacer()
                        }
                        BarChartView(data: .constant(DataPoint.sampleData))
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                .cornerRadius(20)
                .padding(.top)
                .padding(.horizontal)
                .onTapGesture {
//                    isPresentingLesson = true
//                    lessonView = lesson
            }
                HStack {
                    Text("History")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                    emissionCardView(name: .constant("Vegan Meal"), value: .constant(2.7), entryType: .constant("Diet"))
                    emissionCardView(name: .constant("Cycle to Work"), value: .constant(5.3), entryType: .constant("Travel"))
                    emissionCardView(name: .constant("Vegan Meal"), value: .constant(2.7), entryType: .constant("Diet"))
                    emissionCardView(name: .constant("Reduce Heating"), value: .constant(13.3), entryType: .constant("Home"))
                    emissionCardView(name: .constant("Miscellaneous"), value: .constant(1.2), entryType: .constant("Misc"))
                    emissionCardView(name: .constant("Recycle Electronics"), value: .constant(10), entryType: .constant("Goods"))
                
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
                    TrackEmissionView()
                        .navigationTitle("Add Action")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewEmissionView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                }
                            }
                        }
                }
            }
       }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
