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
        case "DLevel1" :
            let scene = GameScene(fileNamed: "DLevel1")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
            print("level1")
        case "DLevel2" :
            let scene = GameScene(fileNamed: "DLevel2")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "DLevel3" :
            let scene = GameScene(fileNamed: "DLevel3")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "DLevel4" :
            let scene = GameScene(fileNamed: "DLevel4")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "DLevel5" :
            let scene = GameScene(fileNamed: "DLevel5")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel1" :
            let scene = GameScene(fileNamed: "LLevel1")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel2" :
            let scene = GameScene(fileNamed: "LLevel2")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel3" :
            let scene = GameScene(fileNamed: "LLevel3")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel4" :
            let scene = GameScene(fileNamed: "LLevel4")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel5" :
            let scene = GameScene(fileNamed: "LLevel5")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel6" :
            let scene = GameScene(fileNamed: "LLevel6")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel7" :
            let scene = GameScene(fileNamed: "LLevel7")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel8" :
            let scene = GameScene(fileNamed: "LLevel8")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel9" :
            let scene = GameScene(fileNamed: "LLevel9")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel10" :
            let scene = GameScene(fileNamed: "LLevel10")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel11" :
            let scene = GameScene(fileNamed: "LLevel11")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel12" :
            let scene = GameScene(fileNamed: "LLevel12")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "LLevel13" :
            let scene = GameScene(fileNamed: "LLevel13")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel1" :
            let scene = GameScene(fileNamed: "SLevel1")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel2" :
            let scene = GameScene(fileNamed: "SLevel2")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel3" :
            let scene = GameScene(fileNamed: "SLevel3")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel4" :
            let scene = GameScene(fileNamed: "SLevel4")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel5" :
            let scene = GameScene(fileNamed: "SLevel5")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "SLevel6" :
            let scene = GameScene(fileNamed: "SLevel6")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "RLevel1" :
            let scene = GameScene(fileNamed: "RLevel1")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "RLevel2" :
            let scene = GameScene(fileNamed: "RLevel2")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "RLevel3" :
            let scene = GameScene(fileNamed: "RLevel3")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "RLevel4" :
            let scene = GameScene(fileNamed: "RLevel4")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "RLevel5" :
            let scene = GameScene(fileNamed: "RLevel5")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        default:
            break
        }
        
        }
    
       
    }

