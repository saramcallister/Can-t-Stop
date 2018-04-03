//
//  PlayerTests.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/6/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import XCTest
@testable import Can_t_Stop

class PlayerTests: XCTestCase {
    
    var sara: Player?
    var evan: CantStopPlayer?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        evan = CantStopPlayer(name: "Evan", id: 1)
        sara = Player(name: "Sara", id: 2)
    }
    
    override func tearDown() {
        evan = nil
        sara = nil
        super.tearDown()
    }
    
    func testPlayerInit() {
        XCTAssertTrue(sara?.name == "Sara")
        XCTAssertTrue(sara?.id == 2)
    }
    
    func testCantStopPlayerInit() {
        XCTAssertTrue(evan?.name == "Evan")
        XCTAssertTrue(evan?.id == 1)
        XCTAssertTrue(evan?.color == idToColor(id: 1))
        XCTAssertTrue(evan?.playerScore == 0)
        XCTAssertTrue(evan?.tileLocations[0] == 0)
    }
    
    func testUpdateFromMarkers() {
        let markers1 = [2: 2, 10: 3, 5: 2]
        try? evan?.updateFromMarkers(markers: markers1)
        XCTAssertTrue(evan?.currentTileLocation(column: 2) == 2)
        XCTAssertTrue(evan?.currentTileLocation(column: 10) == 3)
        XCTAssertTrue(evan?.currentTileLocation(column: 5) == 2)
    }
    
    func testUpdateAfterTurn() {
        let locations = [1,2,3,4,5,6,5,4,3,2,1]
        try? evan?.updateAfterTurn(newLocations: locations)
        XCTAssertTrue(evan?.currentTileLocation(column: 2) == 1)
        XCTAssertTrue(evan?.currentTileLocation(column: 8) == 5)
        XCTAssertTrue(evan?.currentTileLocation(column: 11) == 2)
    }
    
}
