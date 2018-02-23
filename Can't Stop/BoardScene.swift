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
    var background = SKSpriteNode(imageNamed: "table")
    var gameBoardImage = SKSpriteNode(imageNamed: "can'tstopboard")
    var playerNum: Int
    
    init(size: CGSize, numPlayers: Int) {
        self.playerNum = 1
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        background.scale(to: self.size)
        let aspectRatio = gameBoardImage.size.width/gameBoardImage.size.height
        gameBoardImage.size = CGSize(width: background.size.width - 20, height: (background.size.width - 20)/aspectRatio)
        gameBoardImage.anchorPoint.y -= 0.25
        gameBoardImage.zPosition = 1.0
        
        addChild(background)
        addChild(gameBoardImage)
        
    }
}
