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
    case invalidColumn()
}

let numberBoardColumns = 11

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
    case 5:
        return 13
    default:
        return 0
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
        for col in 0 ..< tileLocations.count {
            if (numRowsInGameColumn(col: col) == tileLocations[col]) {
                playerScore += 1
            }
        }
    }
    
    /**
     Returns current location of player's piece in a specific column
     
     - Parameter column: One of 11 columns (numbered how they are on the board)
    */
    func currentTileLocation(column: Int) -> Int {
        return tileLocations[column-2]
    }
    
    func updateFromMarkers(markers: [Int: Int]) throws {
        for (loc, number) in markers {
            guard (loc >= 2 && loc <= 12 ) else {throw PlayerError.invalidColumn()}
            tileLocations[loc-2] = number
        }
    }
    
    /**
     - Returns: the all columns where the player has reached the maximum height
    */
    func getMaxCols() -> [Int] {
        var cols = [Int]()
        for num in 0 ..< numberBoardColumns {
            if tileLocations[num] == numRowsInGameColumn(col: num) {
                cols.append(num + 2)
            }
        }
        return cols
    }
}
