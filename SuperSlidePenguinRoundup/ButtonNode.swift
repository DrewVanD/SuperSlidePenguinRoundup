//
//  ButtonNode.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-14.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    static let buttonTappedNotification = "buttonTappedNotification"
    var buttonName: String!
    func didMoveToScene() {
        isUserInteractionEnabled = true
        
       
    }
    
    func interact() {
        //sends what button is being pressed back to the game scene
        NotificationCenter.default.post(name: NSNotification.Name(ButtonNode.buttonTappedNotification), object: nil, userInfo: [AnyHashable("button"): buttonName])
    }
    //reads the screen and tell which button node is being touched
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
       
        if let name = touchedNode.name {
            buttonName = name
        }
        interact()
    }
   
}
