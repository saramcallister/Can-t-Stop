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
    var nextPlayerNum = 0
    
    init(numberPlayers: Int) {
        for i in stride(from: 0, to: numberPlayers, by: 1) {
            players.append(CantStopPlayer(name: "", id: i))
        }
    }
    
    private func claimColumn(col: Int, player: CantStopPlayer) {
        claimedColumns[col] = player.id
    }

}
