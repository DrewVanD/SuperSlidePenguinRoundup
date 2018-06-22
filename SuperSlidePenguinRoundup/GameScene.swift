//
//  GameScene.swift
//  SuperSlidePenguinRoundup
//
//  Created by Drew Vandyke on 2018-06-05.
//  Copyright © 2018 Drew Vandyke. All rights reserved.
//

import SpriteKit
import GameplayKit

typealias TileCoordinates = (column: Int, row: Int)

protocol InteractiveNode {
    func interact()
}

protocol EventListenerNode {
    func didMoveToScene()
}

struct PhysicsCategory{
    static let None: UInt32 = 0 //0
    static let Rock: UInt32 = 0b1 //1
    static let Penguin: UInt32 = 0b10 //2
    static let BabyPenguin: UInt32 = 0b100 //4
    static let Finish: UInt32 = 0b1000 //8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Tile Maps
    var rockTileMap: SKTileMapNode?
    
    //Player Variables
    var startPoint: SKSpriteNode!
    var player = Player()
    var canMove = true
    var isMoving = false
    var currentLevel: Int = 0
    
    //Timers
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    
    class func level(levelNum: Int) -> GameScene? {
        //let scene = GameScene(fileNamed: "Level\(levelNum)")!
        let scene = GameScene(fileNamed: "Level\(levelNum)")
        scene?.currentLevel = levelNum
        scene?.scaleMode = .aspectFill
        return scene
    }
    
    override func didMove(to view: SKView){
        
        startPoint = childNode(withName: "StartPoint") as! SKSpriteNode
        addChild(player)
        player.position = startPoint.position
        player.zPosition = 1
        player.physicsBody?.categoryBitMask = 2
        player.physicsBody?.collisionBitMask = 3
        player.scale(to: CGSize(width: 30, height: 30))
        physicsWorld.contactDelegate = self
        
        enumerateChildNodes(withName: "//*"){ node, _ in
            if let interactiveNode = node as? ButtonNode {
                interactiveNode.didMoveToScene()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerMovement), name: Notification.Name(ButtonNode.buttonTappedNotification), object: nil)
        setupCamera()
        rockTileMap = childNode(withName: "Rock") as? SKTileMapNode
        setupObstaclePhysics()
    }
    
    
    func didBegin(_ contact: SKPhysicsContact ){
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.BabyPenguin {
            print("Win!")
            win()
        }
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.Rock{
        print("Contact Made!")
          player.stop()
            isMoving = false
        }
        
        
    }
    
    func setupCamera(){
        guard let camera = camera else { return }
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        
        camera.constraints = [playerConstraint]
    }
    
    func setupObstaclePhysics(){
        guard let rockTileMap = rockTileMap else { return }
        var physicsBodies = [SKPhysicsBody]()
        
        for row in 0..<rockTileMap.numberOfRows {
            for column in 0..<rockTileMap.numberOfColumns{
                guard let tile = tile(in: rockTileMap, at: (column, row)) else { continue }
                let center = rockTileMap.centerOfTile(atColumn: column, row: row)
                let body = SKPhysicsBody(rectangleOf: tile.size, center: center)
                physicsBodies.append(body)
            }
        }
        rockTileMap.physicsBody = SKPhysicsBody(bodies: physicsBodies)
        rockTileMap.physicsBody?.isDynamic = false
        rockTileMap.physicsBody?.friction = 1
        rockTileMap.physicsBody?.restitution = 0
        rockTileMap.physicsBody?.categoryBitMask = PhysicsCategory.Rock
        rockTileMap.physicsBody?.collisionBitMask = PhysicsCategory.Penguin
        rockTileMap.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        
    }
    
    func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition? {
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
   
    @objc func playerMovement(notification: NSNotification) {
        guard let buttonName: String = notification.userInfo?["button"] as? String else {
            return
        }
        
        print(buttonName)
        
        if buttonName == "Up" {
            player.zRotation = CGFloat(180).degreesToRadians()
        }
        else if buttonName == "Down"{
            player.zRotation = CGFloat(0).degreesToRadians()
        }
        else if buttonName == "Left"{
            player.zRotation = CGFloat(-90).degreesToRadians()
        }
        else if buttonName == "Right"{
            player.zRotation = CGFloat(90).degreesToRadians()
        }
        else if buttonName == "Slide"
        {
            if !isMoving {
            player.move()
            isMoving = true
            }
        }
        print(player.zRotation)
    }
    
    func win() {
        inGameMessage(text: "You Win, Buddy!")
      run(SKAction.afterDelay(3, runBlock: newGame))
    }
    
    func inGameMessage(text:String){
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
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
    
    func newGame(){
        currentLevel += 1
        view!.presentScene(GameScene.level(levelNum: currentLevel))
    }
}
