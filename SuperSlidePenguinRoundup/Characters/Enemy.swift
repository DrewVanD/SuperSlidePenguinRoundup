//
//  Enemy.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-25.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit

enum EnemySettings {
    static let enemySpeed: CGFloat = 200.0
}

class Enemy: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "Bear")
        
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Enemy"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1), center: CGPoint(x: 0, y: -15))
        physicsBody?.restitution = 0
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.Bear
        physicsBody?.collisionBitMask = PhysicsCategory.Penguin | PhysicsCategory.Bear90TurnNode | PhysicsCategory.Bear180TurnNode
        physicsBody?.contactTestBitMask = PhysicsCategory.Penguin | PhysicsCategory.Bear90TurnNode | PhysicsCategory.Bear180TurnNode
        
    }
    
    func move(){
        guard let physicsBody = physicsBody else { return }
        
        let newVelocity: CGVector
        if zRotation > 3 && zRotation < 3.2 || zRotation < -3 && zRotation > -3.2  {
            newVelocity = CGVector(dx: 0, dy: 1) * EnemySettings.enemySpeed
        }
        else if zRotation == 0.0 { // Working
            newVelocity = CGVector(dx: 0, dy: -1) * EnemySettings.enemySpeed
        }
        else if zRotation < -1.4 && zRotation > -1.6 {
            newVelocity = CGVector(dx: -1, dy: 0) * EnemySettings.enemySpeed
        }
        else if zRotation > 1.4 && zRotation < 1.6 { //Working
            newVelocity = CGVector(dx: 1, dy: 0) * EnemySettings.enemySpeed
        }
        else{
            newVelocity = CGVector.zero
        }
        physicsBody.velocity = newVelocity
    }
}
