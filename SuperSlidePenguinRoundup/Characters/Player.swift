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
    static let playerSpeed: CGFloat = 2.0
}

class Player: SKSpriteNode {
    static let position = CGPoint(x: 0, y: 0)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init() {
        let texture = SKTexture(imageNamed: "Penguin")
        
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Player"
        zPosition = 50
    }
    
    
}

