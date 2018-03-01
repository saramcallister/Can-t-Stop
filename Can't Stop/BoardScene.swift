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
    var currentPlayer = 0;
    var gameBoard: GameBoard?
    var dice0: SKSpriteNode?
    var dice1: SKSpriteNode?
    var dice2: SKSpriteNode?
    var dice3: SKSpriteNode?
    var rollButton: SKSpriteNode?
    var chooseButton: SKSpriteNode?
    var endTurnButton: SKSpriteNode?
    var playerLabel: SKLabelNode?
    var selection = true
    
    private func rollDie() {
        let numberOne = arc4random_uniform(6) + 1
        let numberTwo = arc4random_uniform(6) + 1
        let numberThree = arc4random_uniform(6) + 1
        let numberFour = arc4random_uniform(6) + 1
        dice0!.texture = SKTexture(imageNamed: "Dice\(numberOne)")
        dice1!.texture = SKTexture(imageNamed: "Dice\(numberTwo)")
        dice2!.texture = SKTexture(imageNamed: "Dice\(numberThree)")
        dice3!.texture = SKTexture(imageNamed: "Dice\(numberFour)")
    }
    
    
    override func didMove(to view: SKView) {
        
        // Fetch dice information from BoardScene.sks
        dice0 = (self.childNode(withName: "dice1") as! SKSpriteNode)
        dice1 = (self.childNode(withName: "dice2") as! SKSpriteNode)
        dice2 = (self.childNode(withName: "dice3") as! SKSpriteNode)
        dice3 = (self.childNode(withName: "dice4") as! SKSpriteNode)
        
        // Set font and size of text labels
        playerLabel = (self.childNode(withName: "player_label") as! SKLabelNode)
        playerLabel!.text = "Player: \(currentPlayer)"
        
        // Keep track of other necessary nodes
        rollButton = (self.childNode(withName: "rollButton") as! SKSpriteNode)
        chooseButton = (self.childNode(withName: "chooseButton") as! SKSpriteNode)
        endTurnButton = (self.childNode(withName: "endTurnButton") as! SKSpriteNode)
        
        // Start with random dice faces
        rollDie()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == rollButton && !selection {
                for die in [dice0, dice1, dice2, dice3] {
                    die!.color = .white
                }
                rollDie()
            } else if node == dice0 {
                if dice0!.color == .yellow {
                    dice0!.color = .white
                } else {
                    dice0!.color = .yellow
                }
            } else if node == dice1 {
                if dice1!.color == .yellow {
                    dice1!.color = .white
                } else {
                    dice1!.color = .yellow
                }
            } else if node == dice2 {
                if dice2!.color == .yellow {
                    dice2!.color = .white
                } else {
                    dice2!.color = .yellow
                }
            } else if node == dice3 {
                if dice3!.color == .yellow {
                    dice3!.color = .white
                } else {
                    dice3!.color = .yellow
                }
            }
        }
    }
}
