//
//  StoryScene.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-07-05.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import Foundation
import SpriteKit


class StoryScene: SKScene {
    var Page1: SKSpriteNode!
    var Page2: SKSpriteNode!
    var Page3: SKSpriteNode!
    var Page4: SKSpriteNode!
    var Page5: SKSpriteNode!
    var Page6: SKSpriteNode!
    var Page7: SKSpriteNode!
    var Page8: SKSpriteNode!
    var NextButton: SKSpriteNode!
    var currentPage: Int = 1
    
    override func didMove(to view: SKView){
        Page1 = childNode(withName: "Page1") as! SKSpriteNode
        Page2 = childNode(withName: "Page2") as! SKSpriteNode
        Page3 = childNode(withName: "Page3") as! SKSpriteNode
        Page4 = childNode(withName: "Page4") as! SKSpriteNode
        Page5 = childNode(withName: "Page5") as! SKSpriteNode
        Page6 = childNode(withName: "Page6") as! SKSpriteNode
        Page7 = childNode(withName: "Page7") as! SKSpriteNode
        Page8 = childNode(withName: "Page8") as! SKSpriteNode
        NextButton = childNode(withName: "Next") as! SKSpriteNode
        SKTAudio.sharedInstance().playBackgroundMusic("Ice_cavern.m4a")
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
        case "MMBack" :
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        case "Next" :
            turnPage()
            NextButton.run(SKAction.hide())
        case "Prev" : break
        default:
        break
            }
    }
    
    func turnPage() {
        let flip = SKAction.scaleX(to: -1, duration: 1.0)
        let hide = SKAction.hide()
        switch currentPage {
            case 1 :
            Page1.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 2 :
            Page2.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 3 :
            Page3.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 4 :
            Page4.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 5 :
            Page5.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 6 :
            Page7.run(SKAction.afterDelay(1.5, performAction: SKAction.unhide()))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 7 :
            Page6.run(SKAction.sequence([flip, hide]))
            Page7.run(SKAction.sequence([flip, hide]))
            currentPage += 1
            NextButton.run(SKAction.afterDelay(1, performAction: SKAction.unhide()))
        case 8 :
            Page8.run(SKAction.sequence([flip, hide]))
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        default : break
        }
    }
}
