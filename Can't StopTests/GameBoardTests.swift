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
    
    func testGameBoardInit() {
        XCTAssertTrue(onePlayer?.numPlayers == 1)
        XCTAssertTrue(twoPlayers?.numPlayers == 2)
        XCTAssertTrue(threePlayers?.numPlayers == 3)
        XCTAssertTrue(fourPlayers?.numPlayers == 4)
    }
    
    func testClaimColumn() {
        onePlayer?.claimColumn(col: 3, player: onePlayer!.getCurrentPlayer())
        twoPlayers?.claimColumn(col: 7, player: twoPlayers!.getCurrentPlayer())
        threePlayers?.nextPlayer()
        threePlayers?.claimColumn(col: 11, player: threePlayers!.getCurrentPlayer())
        fourPlayers?.nextPlayer()
        fourPlayers?.nextPlayer()
        fourPlayers?.claimColumn(col: 12, player: fourPlayers!.getCurrentPlayer())
        
        XCTAssertTrue(onePlayer?.claimedColumns[1] == 0)
        XCTAssertTrue(twoPlayers?.claimedColumns[5] == 0)
        XCTAssertTrue(threePlayers?.claimedColumns[9] == 1)
        XCTAssertTrue(fourPlayers?.claimedColumns[10] == 2)
    }
    
    func testMoveUpPiece() {
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 11))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 10))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 7))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 7))
        XCTAssertFalse(twoPlayers!.moveUpPiece(diceSum: 2))
        
        twoPlayers?.nextPlayer()
        
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 11))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 2))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 7))
        XCTAssertFalse(twoPlayers!.moveUpPiece(diceSum: 5))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 2))
    }
    
    func testSaveMarkers() {
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 11))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 10))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 7))
        XCTAssertTrue(twoPlayers!.moveUpPiece(diceSum: 7))
        XCTAssertFalse(twoPlayers!.moveUpPiece(diceSum: 2))
        XCTAssertFalse(twoPlayers!.saveMarkers())
        
        let tileLocations = twoPlayers!.players[0].tileLocations
        XCTAssertTrue(tileLocations[0] == 0)
        XCTAssertTrue(tileLocations[9] == 1)
        XCTAssertTrue(tileLocations[8] == 1)
        XCTAssertTrue(tileLocations[5] == 2)
        
        XCTAssertTrue(twoPlayers?.playerTileLocation(player: 0, column: 2) == 0)
        XCTAssertTrue(twoPlayers?.playerTileLocation(player: 0, column: 7) == 2)
        XCTAssertTrue(twoPlayers?.playerTileLocation(player: 0, column: 10) == 1)
        XCTAssertTrue(twoPlayers?.playerTileLocation(player: 0, column: 11) == 1)
    }
        
}
