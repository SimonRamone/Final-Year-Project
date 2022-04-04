//
//  TrackEmissionView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import SwiftUI

struct TrackEmissionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var user : User
    @State var newAction : Action = Action()
    @State var selection: String = ""
    var body: some View {

        Form{
            Section(header: Label("Home", systemImage: "house.fill")) {
                ForEach(Action.homeActions) { action in
                    Button(action: {
                        newAction = action
                        newAction.date = Date()
                        user.actions.append(newAction)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(action.name).foregroundColor(.black)
                    }
                }
            }
            Section(header: Label("Transport", systemImage: "car.fill")) {
                ForEach(Action.travelActions) { action in
                    Button(action: {
                        newAction = action
                        newAction.date = Date()
                        user.actions.append(newAction)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(action.name).foregroundColor(.black)
                    }
                }
            }
            Section(header: Label("Diet", systemImage: "fork.knife")) {
                ForEach(Action.dietActions) { action in
                    Button(action: {
                        newAction = action
                        newAction.date = Date()
                        user.actions.append(newAction)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(action.name).foregroundColor(.black)
                    }
                }
            }
            Section(header: Label("Shopping", systemImage: "cart.fill")) {
                ForEach(Action.goodsActions) { action in
                    Button(action: {
                        newAction = action
                        newAction.date = Date()
                        user.actions.append(newAction)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(action.name).foregroundColor(.black)
                    }
                }
            }
            Section(header: Label("miscellaneous", systemImage: "puzzlepiece.extension.fill")) {
                ForEach(Action.miscActions) { action in
                    Button(action: {
                        newAction = action
                        newAction.date = Date()
                        user.actions.append(newAction)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(action.name).foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct TrackEmissionView_Previews: PreviewProvider {
    static var previews: some View {
        TrackEmissionView(user: .constant(User()))
    }
}
