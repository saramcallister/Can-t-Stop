//
//  Rule28AITests.swift
//  Can't StopTests
//
//  Created by Sara McAllister on 4/19/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import XCTest
@testable import Can_t_Stop

class Rule28AITests: XCTestCase {
    var ai1: Rule28AI?
    var ai2: Rule28AI?
    var ai3: Rule28AI?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let gameBoard1 = GameBoard(numberPlayers: 1)
        let gameBoard2 = GameBoard(numberPlayers: 2)
        ai1 = Rule28AI(playerId: 0, gameBoard: gameBoard1)
        ai2 = Rule28AI(playerId: 0, gameBoard: gameBoard2)
        ai3 = Rule28AI(playerId: 1, gameBoard: gameBoard2)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumMarkersAvailable() {
        XCTAssert(ai1!.numMarkersAvailable() == 3)
        XCTAssert(ai2!.numMarkersAvailable() == 3)
        XCTAssert(ai3!.numMarkersAvailable() == 3)
        
        ai1!.gameBoard.markers = [2: 1, 4: 5]
        ai2!.gameBoard.markers = [2: 1, 4: 5, 9: 1]
        XCTAssert(ai1!.numMarkersAvailable() == 1)
        XCTAssert(ai2!.numMarkersAvailable() == 0)
        XCTAssert(ai3!.numMarkersAvailable() == 0)
    }
    
    func testMoveScore() {
        let score1 = ai1!.moveScore(sum: 7, numMarkersAvail: 3)
        let score2 = ai1!.moveScore(sum: 12, numMarkersAvail: 3)
        let score3 = ai1!.moveScore(sum: 2, numMarkersAvail: 3)
        
        XCTAssertEqual(score1, 0)
        XCTAssertEqual(score2, -5)
        XCTAssertEqual(score3, -5)
        
        ai1!.gameBoard.markers = [2: 1, 4: 5]
        ai2!.gameBoard.markers = [2: 1, 4: 5, 9: 1]
        
        let score4 = ai1!.moveScore(sum: 4, numMarkersAvail: 1)
        let score5 = ai1!.moveScore(sum: 7, numMarkersAvail: 1)
        let score6 = ai2!.moveScore(sum: 9, numMarkersAvail: 0)
        let score7 = ai2!.moveScore(sum: 11, numMarkersAvail: 0)
        
        XCTAssertEqual(score4, 3)
        XCTAssertEqual(score5, 0)
        XCTAssertEqual(score6, 4)
        XCTAssertEqual(score7, 0)
    }
    
    func testCalculateProgressValue() {
        let value1 = ai1!.calculateProgressValue()
        XCTAssertEqual(value1, 0)
        
        ai1!.gameBoard.markers = [2:1]
        ai2!.gameBoard.markers = [7:1, 8:2]
        try? ai3!.gameBoard.players[ai3!.playerId].updateFromMarkers(markers: [8:1])
        let value2 = ai1!.calculateProgressValue()
        let value3 = ai2!.calculateProgressValue()
        let value4 = ai3!.calculateProgressValue()
        
        XCTAssertEqual(value2, 12)
        XCTAssertEqual(value3, 2 + 6)
        XCTAssertEqual(value4, 2 + 4)
    }
    
    func testRuleOf28Verdict() {
        try? ai1!.gameBoard.players[ai1!.playerId].updateFromMarkers(markers: [4: 3, 6: 7, 10: 2])
        ai1!.gameBoard.markers = [4: 5, 6: 10, 10: 3]
        let value = ai1!.calculateProgressValue()
        XCTAssertEqual(value, 28)
        XCTAssertTrue(ai1!.ruleOf28Verdict())
    }
    
}
