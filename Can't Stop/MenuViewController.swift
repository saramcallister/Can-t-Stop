//
//  MenuViewController.swift
//  Can't Stop
//
//  Created by Sara McAllister on 2/6/18.
//  Copyright © 2018 Sara McAllister. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var onePlayerButton: UIButton!
    @IBOutlet weak var twoPlayersButton: UIButton!
    @IBOutlet weak var threePlayersButton: UIButton!
    @IBOutlet weak var fourPlayersButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for button in [onePlayerButton, twoPlayersButton, threePlayersButton, fourPlayersButton] {
            button!.layer.cornerRadius = 10
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
