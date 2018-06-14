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
    var rockTileMapNode: SKTileMapNode = SKTileMapNode()
    var iceTileMapNode: SKTileMapNode = SKTileMapNode()
    var iceRockTileMapNode: SKTileMapNode = SKTileMapNode()
    var player: SKSpriteNode!
    var canMove = true

    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    
    override func didMove(to view: SKView){
        
        player = childNode(withName: "Farley") as! SKSpriteNode
        for node in self.children {
            if node.name == "Ice" {
                iceTileMapNode = node as! SKTileMapNode
            }
            else if node.name == "Rock" {
                rockTileMapNode = node as! SKTileMapNode
            }
            else if node.name == "IceRock" {
                iceRockTileMapNode = node as! SKTileMapNode
            }
        }
     
        setupCamera()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
   
    
    override init(size: CGSize){
        //let maxAspectRatio: CGFloat = 16.0/9.0
        
        super.init(size: size)
    }
    
    func setupCamera(){
        guard let camera = camera else { return }
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        
        camera.constraints = [playerConstraint]
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            deltaTime = currentTime - lastUpdateTime
        }
        else{
            deltaTime = 0
        }
        lastUpdateTime = currentTime
        
        
    }
}
