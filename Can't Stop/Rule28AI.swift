//
//  Rule28AI.swift
//  Can't Stop
//
//  Created by Sara McAllister on 4/17/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import Foundation

class Rule28AI {
    var playerId: Int
    var gameBoard: GameBoard
    
    init(playerId: Int, gameBoard: GameBoard) {
        self.playerId = playerId
        self.gameBoard = gameBoard
    }
    
    func calculateProgressValue() -> Int {
        let markers = gameBoard.getMarkers()
        var sum = 0
        for (col, loc) in markers {
            let progress = loc - gameBoard.playerTileLocation(player: playerId, column: col)
            sum += (progress + 1)*(abs(7 - col) + 1)
        }
        return sum
    }
    
    func ruleOf28Verdict() -> Bool {
        let markers = gameBoard.getMarkers()
        var progressValue = calculateProgressValue()
        var allEven = true
        var allGreaterThan7 = true
        var allLessThan7 = true
        for (col, _) in markers {
            if (col % 2) == 1 {
                allEven = false
            }
            if (col >= 7) {
                allLessThan7 = false
            }
            if (col <= 7) {
                allGreaterThan7 = false
            }
        }
        if allEven {
            progressValue -= 2
        }
        if allGreaterThan7 || allLessThan7 {
            progressValue += 4
        }
        return (progressValue < 28)
    }
    
    func moveScore(sum: Int, numMarkersAvail: Int) -> Int {
        let markers = gameBoard.getMarkers()
        var markerValue = 0
        if (markers[sum] == nil) {
            if (numMarkersAvail == 0) {
                return 0
            }
            markerValue = 1
        }
        return (6 - abs(7 - sum) - 6 * markerValue)
    }
    
    func numMarkersAvailable() -> Int {
        let markers = gameBoard.getMarkers()
        return (3 - markers.count)
    }
    
    /**
     Returns the dice numbers that represent the best option given the dice
     
     @param diceValue List of 4 integers representing the dice values
     
     @return Dice numbers representing the best option
     */
    func calculateMovePair(diceValues: [Int]) -> [Int] {
        let numMarker = numMarkersAvailable()
        let totalSum = diceValues.reduce(0, +)
        var bestOption = [0, 0]
        var bestScore = -1000
        for i in 1 ..< 3 {
            let sum = diceValues[0] + diceValues[i]
            let score1 = moveScore(sum: sum, numMarkersAvail: numMarker)
            let score2 = moveScore(sum: totalSum - sum, numMarkersAvail: numMarker)
            var currentScore = score1 + score2
            if (numMarker == 1) {
                currentScore = max(score2, score1)
            }
            if currentScore > bestScore {
                bestScore = currentScore
                bestOption = [0, 1]
            }
        }
        return bestOption
    }
}
