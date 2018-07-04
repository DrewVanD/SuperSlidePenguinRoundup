//
//  GameViewController.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-05.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
<<<<<<< HEAD
            if let scene = GameScene.level(levelNum: 8) {
=======

            //if let scene = GameScene.level(levelNum: 1) {
            if let scene = MainMenuScene(fileNamed: "MainMenu") {

>>>>>>> 97e8a01a49c9e4c2b5edc79758e82a2f29559842
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }                           //get your aluminum hats!!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
