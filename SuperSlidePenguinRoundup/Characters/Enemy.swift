//
//  Enemy.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-25.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "Farley2feet")
        
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Player"
        //physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1), center: CGPoint(x: 0, y: -15))
        physicsBody?.restitution = 0
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.Penguin
        physicsBody?.collisionBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin
        physicsBody?.contactTestBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin
        
    }
}
