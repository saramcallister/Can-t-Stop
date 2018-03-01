//
//  MenuScene.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/16/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import SpriteKit
import Foundation

class MenuScene: SKScene {
    let title = SKLabelNode(text: "Can't Stop")
    let onePlayer = SKLabelNode(text: "One Player")
    let twoPlayers = SKLabelNode(text: "Two Players")
    let threePlayers = SKLabelNode(text: "Three Players")
    let fourPlayers = SKLabelNode(text: "Four Players")
    
    func formatTextNodes() {
        title.fontSize = 100
        onePlayer.fontSize = 50
        twoPlayers.fontSize = 50
        threePlayers.fontSize = 50
        fourPlayers.fontSize = 50
        
        title.fontName = ("AvenirNext-Bold")
        onePlayer.fontName = ("AvenirNext-Bold")
        twoPlayers.fontName = ("AvenirNext-Bold")
        threePlayers.fontName = ("AvenirNext-Bold")
        fourPlayers.fontName = ("AvenirNext-Bold")
        
        title.fontColor = UIColor.red
        onePlayer.fontColor = UIColor.white
        twoPlayers.fontColor = UIColor.white
        threePlayers.fontColor = UIColor.white
        fourPlayers.fontColor = UIColor.white
        
        title.position = CGPoint(x: self.position.x, y: self.position.y + 175)
        onePlayer.position = CGPoint(x: title.position.x, y: title.position.y - 100)
        twoPlayers.position = CGPoint(x: onePlayer.position.x, y: onePlayer.position.y - 75)
        threePlayers.position = CGPoint(x: twoPlayers.position.x, y: twoPlayers.position.y - 75)
        fourPlayers.position = CGPoint(x: threePlayers.position.x, y: threePlayers.position.y - 75)
    }
    
    override func didMove(to view: SKView) {
        
        formatTextNodes()
        addChild(title)
        addChild(onePlayer)
        addChild(twoPlayers)
        addChild(threePlayers)
        addChild(fourPlayers)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == title {
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                let scene: SKScene = GameScene(size: self.size)
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition: transition)
            } else if [onePlayer, twoPlayers, threePlayers, fourPlayers].contains(node) {
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                
                // Set the number of players for next scene
                var numberPlayers: Int
                if (fourPlayers == node) {numberPlayers = 4}
                else if (twoPlayers == node) {numberPlayers = 2}
                else if (threePlayers == node) {numberPlayers = 3}
                else {numberPlayers = 1}
                
                // create scene and size it correctly
                guard let scene = BoardScene(fileNamed: "BoardScene") else {
                    fatalError("Could not create BoardScene.")
                }
                scene.gameBoard = GameBoard(numberPlayers: numberPlayers)
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition: transition)
            }
            
        }
    }
}
