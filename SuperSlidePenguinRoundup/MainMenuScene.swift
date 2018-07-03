//
//  MainMenuScene.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-07-03.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import Foundation
import SpriteKit


class MainMenuScene: SKScene {
    
   override func didMove(to view: SKView){
    //sets up and observers to read when a buttonNode has been clicked
    NotificationCenter.default.addObserver(self, selector: #selector(buttonSelect), name: Notification.Name(ButtonNode.buttonTappedNotification), object: nil)
    
    //collects all the childNodes available in the scene
    enumerateChildNodes(withName: "//*"){ node, _ in
        if let interactiveNode = node as? ButtonNode {
            interactiveNode.didMoveToScene()
        }
    }
    
    }
    
    @objc func buttonSelect(notification: NSNotification) {
        guard let buttonName: String = notification.userInfo?["button"] as? String else {
            return
        }
        
        switch buttonName {
        case "Play" :
            let scene = MainMenuScene(fileNamed: "WorldSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Info" : break
        case "Options" : break
        case "MMBack" :
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "WSBack" :
            let scene = MainMenuScene(fileNamed: "WorldSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "World1" :
            let scene = MainMenuScene(fileNamed: "World1LevelSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "World2" :
            let scene = MainMenuScene(fileNamed: "World2LevelSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "World3" :
            let scene = MainMenuScene(fileNamed: "World3LevelSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "World4" :
            let scene = MainMenuScene(fileNamed: "World4LevelSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Dlevel1" :
            let scene = GameScene(fileNamed: "DLevel1")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
            print("level1")
        case "Dlevel2" :
            let scene = GameScene(fileNamed: "DLevel2")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Dlevel3" :
            let scene = GameScene(fileNamed: "DLevel3")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Dlevel4" :
            let scene = GameScene(fileNamed: "DLevel4")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Dlevel5" :
            let scene = GameScene(fileNamed: "DLevel5")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        default:
            break
        }
        
        }
    
       
    }

