//
//  BoardScene.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/20/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import UIKit
import SpriteKit

class BoardScene: SKScene {
    var gameBoard: GameBoard?
    var dice = [SKSpriteNode]()
    var rollButton: SKSpriteNode?
    var chooseButton: SKSpriteNode?
    var endTurnButton: SKSpriteNode?
    var playerLabel: SKLabelNode?
    var pieceLocations: SKNode?
    var selection = true
    
    //Variables to keep track of dice position
    var diceCurrentlyShowing = [1,2,3,4]
    var selectedDice = [Int]()
    
    /**
     Sets each die to a random number between 1 and 6 inclusive
     */
    private func rollDice() {
        print("In roll Dice")
        
        let numberZero = arc4random_uniform(6) + 1
        let numberOne = arc4random_uniform(6) + 1
        let numberTwo = arc4random_uniform(6) + 1
        let numberThree = arc4random_uniform(6) + 1
        dice[0].texture = SKTexture(imageNamed: "Dice\(numberZero)")
        dice[1].texture = SKTexture(imageNamed: "Dice\(numberOne)")
        dice[2].texture = SKTexture(imageNamed: "Dice\(numberTwo)")
        dice[3].texture = SKTexture(imageNamed: "Dice\(numberThree)")
        diceCurrentlyShowing = [Int(numberZero), Int(numberOne), Int(numberTwo), Int(numberThree)]
    }
    
    
    override func didMove(to view: SKView) {
        print("Did move")
        
        // Fetch dice information from BoardScene.sks
        dice.append(self.childNode(withName: "dice1") as! SKSpriteNode)
        dice.append(self.childNode(withName: "dice2") as! SKSpriteNode)
        dice.append(self.childNode(withName: "dice3") as! SKSpriteNode)
        dice.append(self.childNode(withName: "dice4") as! SKSpriteNode)
        
        // Set font and size of text labels
        playerLabel = (self.childNode(withName: "player_label") as! SKLabelNode)
        playerLabel!.text = "Player: \(gameBoard!.getCurrentPlayer() + 1)"
        playerLabel!.color = idToColor(id: gameBoard!.getCurrentPlayer())
        
        // Keep track of other necessary nodes
        rollButton = (self.childNode(withName: "rollButton") as! SKSpriteNode)
        rollButton!.children[0].isUserInteractionEnabled = false
        chooseButton = (self.childNode(withName: "chooseButton") as! SKSpriteNode)
        chooseButton!.children[0].isUserInteractionEnabled = false
        endTurnButton = (self.childNode(withName: "endTurnButton") as! SKSpriteNode)
        endTurnButton!.children[0].isUserInteractionEnabled = false
        
        rollButton!.isHidden = true
        endTurnButton!.isHidden = true
        
        // Add tile nodes
        pieceLocations = self.childNode(withName: "pieceLocations")
        
        // Start with random dice faces
        rollDice()
        
    }
    
    /**
     Change the selected status of a die
     
     @param Die number to change
     */
    private func changeDieSelection(dieNumber: Int) {
        print("Changing selection of die number \(dieNumber)")
        if (dice[dieNumber].color == .yellow){
            dice[dieNumber].color = .white
            if let index = selectedDice.index(of:dieNumber) {
                selectedDice.remove(at: index)
            }
        } else if (selectedDice.count < 2){
            dice[dieNumber].color = .yellow
            selectedDice.append(dieNumber)
        }
    }
    
    private func updateAllTiles() {
        for col in 0 ..< numberBoardColumns {
            let numRows = numRowsInGameColumn(col: col)
            var playerLocs = [Int](repeating: 0, count: gameBoard!.numPlayers)
            for player in 0 ..< gameBoard!.numPlayers {
                playerLocs[player] = gameBoard!.playerTileLocation(player: player, column: col)
            }
            for loc in 1 ..< (numRows + 1) {
                let tileNode = pieceLocations!.children[col].children[loc - 1] as! SKSpriteNode
                if (playerLocs.contains(loc)){
                    tileNode.color = idToColor(id: playerLocs.index(of: loc)!)
                } else {
                    tileNode.color = UIColor.clear
                }
            }
        }
    }
    
    private func nextPlayer(saveMarkers: Bool) {
        print("Moving to next player")
        if saveMarkers {gameBoard!.saveMarkers()}
        updateAllTiles()
        
        gameBoard!.nextPlayer()
        playerLabel!.text = "Player: \(gameBoard!.getCurrentPlayer() + 1)"
        playerLabel!.color = idToColor(id: gameBoard!.getCurrentPlayer())
        
        
        for die in dice {
            die.color = .white
        }
        selectedDice = []
        
        rollDice()
        selection = true
        chooseButton?.isHidden = false
        rollButton?.isHidden = true
        endTurnButton?.isHidden = true
        
        
    }
    
    private func clickedChooseButton() {
        if (selectedDice.count != 2) {
            return
        }
        let sum1: Int = diceCurrentlyShowing[selectedDice[0]] + diceCurrentlyShowing[selectedDice[1]]
        let sum2: Int = diceCurrentlyShowing.reduce(0, { x, y in x + y})  - sum1
        let return1 = gameBoard!.moveUpPiece(diceSum: sum1)
        let return2 = gameBoard!.moveUpPiece(diceSum: sum2)
        print("sum1 is \(sum1) and sum2 is \(sum2)")
        selectedDice = [Int]()
        selection = false
        
        // Change what operations player can choose
        rollButton?.isHidden = false
        endTurnButton?.isHidden = false
        chooseButton?.isHidden = true
        
        // Move to next player if no marker can be moved up
        if !return1 && !return2 {
            nextPlayer(saveMarkers: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            print("Number dice selected is \(selectedDice.count)")
            print("Selection is \(selection)")
            let allNodes = nodes(at: node.position)
            print("Nodes at position are \(allNodes)")
            
            if node == rollButton || node == rollButton?.children[0] && !selection {
                for die in dice {
                    die.color = .white
                }
                selectedDice = []
                selection = true
                chooseButton?.isHidden = false
                rollButton?.isHidden = true
                endTurnButton?.isHidden = true
                rollDice()
            } else if node == dice[0] && selection {
                changeDieSelection(dieNumber: 0)
            } else if node == dice[1] && selection {
                changeDieSelection(dieNumber: 1)
            } else if node == dice[2] && selection {
                changeDieSelection(dieNumber: 2)
            } else if node == dice[3] && selection {
                changeDieSelection(dieNumber: 3)
            } else if node == chooseButton || node == chooseButton?.children[0] && selectedDice.count == 2 {
                print("Clicked choose button")
                self.clickedChooseButton()
            } else if node == endTurnButton || node == endTurnButton?.children[0] && !selection {
                nextPlayer(saveMarkers: true)
            }
        }
    }
}
