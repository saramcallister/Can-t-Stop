//
//  GameBoard.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/5/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import Foundation

// number of columns in board
let numberBoardColumns = 11

enum GameBoardError: Error {
    case invalidColumnInBoard()
}

/**
 Find number of rows given a column nubmer from 0 to 10, (0 corresponds to the displayed 2 column)
 
 - Parameter col: integer representing the desired column number
 
 - Returns: number of rows in column including final square
 */
func numRowsInGameColumn(col: Int) -> Int{
    switch col {
    case 0, 10:
        return 3
    case 1, 9:
        return 5
    case 2, 8:
        return 7
    case 3, 7:
        return 9
    case 4, 6:
        return 11
    case 7:
        return 13
    default:
        return 0
    }
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
        claimedColumns[col] = player.id
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
                markers[diceSum] = players[currentPlayer].currentTileLocation(column: diceSum - 2) + 1
                return true
            }
        }
        markers[diceSum]! += 1
        return true
    }
    
    func saveMarkers() {
        players[currentPlayer].updateFromMarkers(markers: markers)
    }
    
    func playerTileLocation(player: Int, column: Int) -> Int {
        return players[player].currentTileLocation(column: column)
    }

}
