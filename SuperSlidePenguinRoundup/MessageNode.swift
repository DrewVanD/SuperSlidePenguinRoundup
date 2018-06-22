//
//  MessageNode.swift
//  CatNap
//
//  Created by Drew Vandyke on 2018-06-13.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit

class MessageNode: SKLabelNode {
    convenience init(message:String) {
        self.init(fontNamed: "AvenirNext-Regular")
        
        text = message
        fontSize = 20.0
        fontColor = SKColor.black
        zPosition = 100
        
        let front = SKLabelNode(fontNamed: "AvenirNext-Regular")
        front.text = message
        front.fontSize = 256.0
        front.fontColor = SKColor.white
        front.position = CGPoint(x: -2, y: -2)
        addChild(front)
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody!.collisionBitMask = PhysicsCategory.Rock
        physicsBody!.categoryBitMask = PhysicsCategory.Rock
        
        physicsBody!.restitution = 0.7
        
    }
}
