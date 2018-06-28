//
//  Player.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-06.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import Foundation
import SpriteKit

enum PlayerSettings {
    static let playerSpeed: CGFloat = 400.0
}

class Player: SKSpriteNode {
    
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
        physicsBody?.collisionBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin | PhysicsCategory.Bear | PhysicsCategory.Fish
        physicsBody?.contactTestBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin | PhysicsCategory.Bear | PhysicsCategory.Fish
        
    }
    
    func move(){
        guard let physicsBody = physicsBody else { return }
        
        let newVelocity: CGVector
        if zRotation > 3 && zRotation < 3.2 || zRotation < -3 && zRotation > -3.2  {
           newVelocity = CGVector(dx: 0, dy: 1) * PlayerSettings.playerSpeed
        }
        else if zRotation == 0.0 { // Working
            newVelocity = CGVector(dx: 0, dy: -1) * PlayerSettings.playerSpeed
        }
        else if zRotation < -1.4 && zRotation > -1.6 {
            newVelocity = CGVector(dx: -1, dy: 0) * PlayerSettings.playerSpeed
        }
        else if zRotation > 1.4 && zRotation < 1.6 { //Working
            newVelocity = CGVector(dx: 1, dy: 0) * PlayerSettings.playerSpeed
        }
        else{
            newVelocity = CGVector.zero
        }
        physicsBody.velocity = newVelocity
        print(newVelocity)
    }
    
    func stop(){
        let stopVelocity: CGVector
        stopVelocity = CGVector.zero
        physicsBody?.velocity = stopVelocity
    }
    
    
}

