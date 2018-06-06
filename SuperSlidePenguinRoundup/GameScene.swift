//
//  GameScene.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-05.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var background: SKTileMapNode!
    var player: SKSpriteNode!
    let playerMovePointsPerSec: CGFloat = 20.0
    var canMove = true
    var velocityX = CGPoint.zero
    var velocityY = CGPoint.zero
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    var lastTouchLocation: CGPoint?
    
    override func didMove(to view: SKView){
        loadSceneNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        background =
            childNode(withName: "level 1") as! SKTileMapNode
    }
    
    func loadSceneNodes(){
        guard let player = childNode(withName: "Penguin") as? SKSpriteNode else {
            fatalError("Sprite Nodes not loaded")
        }
        self.player = player
        
        guard let background = childNode(withName: "level 1") as? SKTileMapNode else {
            fatalError("Background not loaded")
        }
        self.background = background
        
    }
    
    override init(size: CGSize){
        //let maxAspectRatio: CGFloat = 16.0/9.0
        
        super.init(size: size)
    }
    
    
    
    func sceneTouched(touchLocation: CGPoint){
        lastTouchLocation = touchLocation
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            deltaTime = currentTime - lastUpdateTime
        }
        else{
            deltaTime = 0
        }
        lastUpdateTime = currentTime
        
        let position = player.position
        let column = background.tileColumnIndex(fromPosition: position)
        let row = background.tileColumnIndex(fromPosition: position)
        let tile = background.tileDefinition(atColumn: column, row: row)
        if tile == nil {
            canMove = false
        }
        else{
            canMove = true
        }
        
        /*if (lastTouchLocation?.x)! <= player.position.x && canMove {
            player.position.x -= 1
        }
        if (lastTouchLocation?.x)! >= player.position.x && canMove {
            player.position.x += 1
        }
        if (lastTouchLocation?.y)! <= player.position.y && canMove {
            player.position.y -= 1
        }
        if (lastTouchLocation?.y)! <= player.position.y && canMove {
            player.position.y += 1
        }*/
        
        
        
    }
}
