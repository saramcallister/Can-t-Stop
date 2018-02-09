//
//  Game.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/6/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import Foundation

class Game {
    var gameBoard = GameBoard()
    var numPlayers: Int
    var players: [CantStopPlayer]
    var nextPlayer: Int
    
    init(numberPlayers: Int, names: [String]) {
        self.numPlayers = numberPlayers
        self.players = [CantStopPlayer]()
        for i in 0...numPlayers {
            self.players.append(CantStopPlayer(name: names[i], id: i+1))
        }
        self.nextPlayer = 0
    }
    
    
}
