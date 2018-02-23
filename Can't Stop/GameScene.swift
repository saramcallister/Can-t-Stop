//
//  GameScene.swift
//  Can't Stop
//
//  Created by Sara McAllister on 12/24/17.
//  Copyright © 2017 Sara McAllister. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let label = SKLabelNode(text: "Can you STOP?")
    
    override func didMove(to view: SKView) {
        label.fontSize = 100
        label.fontColor = SKColor.red
        label.fontName = "AvenirNext-Bold"
        
        addChild(label)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveByAction = SKAction.moveBy(x: sceneLocation.x - label.position.x, y: sceneLocation.y - label.position.y, duration: 1)
        
        let moveByReversedAction = moveByAction.reversed()
        let moveByActions = [moveByAction, moveByReversedAction]
        let moveSequence = SKAction.sequence(moveByActions)
        
        label.run(moveSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == label {
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                let scene:SKScene = MenuScene(size: self.size)
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
}
