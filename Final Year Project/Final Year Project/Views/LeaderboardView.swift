//
//  LeaderboardView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 30/03/2022.
//

import SwiftUI
import GameKit

struct LeaderboardView: View {
    @StateObject var leaderboard = Leaderboard()
    var leaderBoardID = ""
    @Binding var user : User
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    var body: some View {
        List {
            if GKLocalPlayer.local.displayName.isEmpty {
                Text("To view the leaderboard you must sign in to Game Center in your device's settings.").font(.headline).padding(.top).padding(.bottom)
            }
            else {
                if user.hasAcceptedTerms {
                    Section("My Rank"){
                        HStack{
                            Text("Rank: \(leaderboard.localPlayerScore?.rank ?? 0)")
                                .bold()
                            Spacer()
                            Text(leaderboard.localPlayerScore?.formattedScore ?? "")
                        }
                    }
                    .onAppear(){
                    }
                    Section(leaderboard.title){
                        ForEach(leaderboard.topScores ?? [], id: \.self) { entry in
                            HStack {
                                if entry.player.teamPlayerID == GKLocalPlayer.local.teamPlayerID {
                                    Text("\(entry.rank). " + entry.player.displayName + " (Me)")
                                        .bold()
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                } else {
                                    Text("\(entry.rank). " + entry.player.displayName)
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                }
                                Spacer()
                                Text(entry.formattedScore)
                            }
                        }
                    }
                } else {
                    Section("Info"){
                        Text("Leaderboards are an online feature and are viewable by other users. If you click **'Accept'** your total carbon footprint and Game Center nickname will be visible to other users.").padding(.top).padding(.bottom)
                    }
                    Section("Game Center Nickname"){
                        Button(GKLocalPlayer.local.displayName) {
                            popUpMessage = "Nickname can be changed in device settings in the Game Center tab."
                            isPresentingInfoPopUp = true
                        }.foregroundColor(.black)
                    }
                    Section{
                        Button("Accept") {
                            user.hasAcceptedTerms = true
                        }
                    }
                }
        }
            }
        .navigationBarItems(
            trailing:
                    Button(action: {
                        popUpMessage = "Your score may take some time to update."
                        isPresentingInfoPopUp.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle.fill").foregroundColor(.gray.opacity(0.7))
                    })
        )
                .onChange(of: user.carbonFootprint.totalCarbonFootprint) {carbonFootprint in
                    if user.hasAcceptedTerms {
                        GKLeaderboard.submitScore(Int(carbonFootprint), context:0, player: GKLocalPlayer.local, leaderboardIDs: ["lowestCarbonPolluters"], completionHandler: {error in})
                    }
                    leaderboard.load(leaderBoardID: leaderBoardID)
                }
                .onAppear {
                    leaderboard.load(leaderBoardID: leaderBoardID)
                }
                .navigationTitle("Leaderboard")
        }
    }

//struct LeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardView(leaderBoardID: "lowestCarbonEmitters", user: .constant(User()))
//    }
//}
