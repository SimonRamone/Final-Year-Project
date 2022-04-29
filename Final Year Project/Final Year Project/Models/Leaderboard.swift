//
//  Leaderboard.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 28/03/2022.
//

import GameKit

class Leaderboard: ObservableObject {
    private var leaderboard: GKLeaderboard?
    @Published var localPlayerScore: GKLeaderboard.Entry?
    @Published var topScores: [GKLeaderboard.Entry]?
    @Published var title: String = ""
    private var leaderBoardID: String = ""
    
    func load(leaderBoardID: String) {
        self.leaderBoardID = leaderBoardID
        if nil == leaderboard {
            GKLeaderboard.loadLeaderboards(IDs: [leaderBoardID]) { [weak self] (leaderboards, error) in
                self?.title = leaderboards?.first?.title ?? ""
                self?.leaderboard = leaderboards?.first
                self?.loadScores()
            }
        } else {
            self.loadScores()
        }
    }
    
    func loadScores() {
        leaderboard?.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 100),
                                 completionHandler: { [weak self] (localPlayer, scores, count, error) in
            DispatchQueue.main.async {
                self?.localPlayerScore = localPlayer
                self?.topScores = scores
            }
        })
    }
}
