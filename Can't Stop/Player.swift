//
//  Player.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/5/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import Foundation
import UIKit

enum PlayerError: Error {
    case invalidSizeArray(sizeNeeded: Int)
}

/**
 Finds the color corresponding to id number
 
 - Parameter id: integer representing the id number
 
 - Returns: UIColor

 */
func idToColor(id: Int) -> UIColor {
    switch id {
    case 0:
        return UIColor.blue
    case 1:
        return UIColor.green
    case 2:
        return UIColor.yellow
    case 3, 7:
        return UIColor.orange
    default:
        return UIColor.clear
    }
}

// generic player class that is not specific to game
class Player {
    // need to store information about individual (eg. id, name)
    var name: String
    var id: Int
    init(name:String, id:Int) {
        self.name = name
        self.id = id
    }
}

class CantStopPlayer: Player {
    // Where tiles are for each column from previous moves
    var tileLocations = Array(repeating: 0, count: numberBoardColumns)
    // Total captures columns (need 3 to win)
    var playerScore = 0
    var color: UIColor
    
    override init(name:String, id:Int) {
        self.color = idToColor(id: id)
        super.init(name: name, id: id)
    }
    
    /**
     Updates the can't stop players information after a turn
     
     - Parameter newLocations: A 11 Int array that represents the new locations of the board tiles
     
     - Throws: `PlayerError.invalidSizeArray` if newLocations is not of size 11
      */
    func updateAfterTurn(newLocations: [Int]) throws {
        guard newLocations.count == numberBoardColumns else { throw PlayerError.invalidSizeArray(sizeNeeded: numberBoardColumns)}
        tileLocations = newLocations
        for col in 0...tileLocations.count {
            if (numRowsInGameColumn(col: col) == tileLocations[col]) {
                playerScore += 1
            }
        }
    }
    
    /**
     Returns current location of player's piece in a specific column
     
     - Parameter column: One of 11 columns
    */
    func currentTileLocation(column: Int) -> Int {
        return tileLocations[column]
    }
    
    func updateFromMarkers(markers: [Int: Int]) {
        for (loc, number) in markers {
            tileLocations[loc-1] = number
        }
    }
}
