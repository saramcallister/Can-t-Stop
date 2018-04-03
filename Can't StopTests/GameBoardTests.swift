//
//  GameBoardTests.swift
//  Can't StopTests
//
//  Created by Sara McAllister on 2/6/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import XCTest
@testable import Can_t_Stop

class GameBoardTests: XCTestCase {
    
    var onePlayer: GameBoard?
    var twoPlayers: GameBoard?
    var threePlayers: GameBoard?
    var fourPlayers: GameBoard?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        onePlayer = GameBoard(numberPlayers: 1)
        twoPlayers = GameBoard(numberPlayers: 2)
        threePlayers = GameBoard(numberPlayers: 3)
        fourPlayers = GameBoard(numberPlayers: 4)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        onePlayer = nil
        twoPlayers = nil
        threePlayers = nil
        fourPlayers = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
        
}
