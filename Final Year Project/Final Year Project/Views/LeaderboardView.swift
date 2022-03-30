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
    var body: some View {
            List {
                Section("My Rank"){
                    HStack{
                        Text("Rank: \(leaderboard.localPlayerScore?.rank ?? 0)")
                            .bold()
                        Spacer()
                        Text(leaderboard.localPlayerScore?.formattedScore ?? "")
                    }
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
                                }
                                Spacer()
                                Text(entry.formattedScore)
                            }
                        }
                }
            }
            .onAppear {
                leaderboard.load(leaderBoardID: leaderBoardID)
            }
            .navigationTitle("Leaderboard")
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(leaderBoardID: "lowestCarbonEmitters")
    }
}
