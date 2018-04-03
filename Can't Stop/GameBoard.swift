//
//  GameBoard.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/5/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import Foundation


enum GameBoardError: Error {
    case invalidColumnInBoard()
}

class GameBoard {
    var claimedColumns = Array(repeating: 0, count: 11)
    var players: [CantStopPlayer] = []
    var numPlayers: Int
    var currentPlayer = 0
    var markers = [Int: Int]()
    
    init(numberPlayers: Int) {
        self.numPlayers = numberPlayers
        for i in stride(from: 0, to: numberPlayers, by: 1) {
            players.append(CantStopPlayer(name: "", id: i))
        }
    }
    
    func claimColumn(col: Int, player: CantStopPlayer) {
        claimedColumns[col-2] = player.id
    }
    
    func getCurrentPlayer() -> Int {
        return currentPlayer
    }
    
    func nextPlayer() {
        currentPlayer = (currentPlayer + 1) % numPlayers
    }
    
    /**
     Move up pieces with the firstSum's corresponding piece taking precedence
     
     @param diceSum is an integer representing the sum to increase
     
     @return Returns false if sum cannont be added to the player's score without using more than 3 markers
     */
    func moveUpPiece(diceSum: Int) -> Bool {
        if (markers[diceSum] == nil) {
            if markers.count >= 3 {
                return false
            } else {
                markers[diceSum] = players[currentPlayer].currentTileLocation(column: diceSum) + 1
                return true
            }
        }
        markers[diceSum]! += 1
        return true
    }
    
    func saveMarkers() {
        try? players[currentPlayer].updateFromMarkers(markers: markers)
    }
    
    func playerTileLocation(player: Int, column: Int) -> Int {
        return players[player].currentTileLocation(column: column)
    }

}
