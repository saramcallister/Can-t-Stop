//
//  GameViewController.swift
//  Can't Stop
//
//  Created by Sara McAllister on 12/24/17.
//  Copyright © 2017 Sara McAllister. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var farLeftDiceImageView: UIImageView!
    @IBOutlet weak var centerRightDiceImageView: UIImageView!
    @IBOutlet weak var bottomLeftDiceImageView: UIImageView!
    @IBOutlet weak var bottomRightDiceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    @IBAction func rollButtonTapped(_ sender: UIButton) {
        let numberOne = arc4random_uniform(6) + 1
        let numberTwo = arc4random_uniform(6) + 1
        let numberThree = arc4random_uniform(6) + 1
        let numberFour = arc4random_uniform(6) + 1
        farLeftDiceImageView.image = UIImage(named: "Dice\(numberOne)")
        centerRightDiceImageView.image = UIImage(named: "Dice\(numberTwo)")
        bottomLeftDiceImageView.image = UIImage(named: "Dice\(numberThree)")
        bottomRightDiceImageView.image = UIImage(named: "Dice\(numberFour)")
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
