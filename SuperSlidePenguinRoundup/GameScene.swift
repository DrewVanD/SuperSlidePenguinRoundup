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

struct PhysicsCategory{ //set the the physics Masks
    static let None: UInt32 = 0 //0
    static let Rock: UInt32 = 0b1 //1
    static let Penguin: UInt32 = 0b10 //2
    static let BabyPenguin: UInt32 = 0b100 //4
    static let Bear: UInt32 = 0b1000 //8
    static let Fish: UInt32 = 0b10000 //16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Tile Maps
    var rockTileMap: SKTileMapNode?
    
    //Player Variables
    var startPoint: SKSpriteNode!
    var player = Player()
    var canMove = true //lets the player move if it is time to
    var isMoving = false //tells the movement func if the player is already moving
    var contactMade = false
    var gameOver = false
    var fish1: SKSpriteNode!
    var fish2: SKSpriteNode!
    var fish3: SKSpriteNode!
    var fish1Node: SKSpriteNode!
    var fish2Node: SKSpriteNode!
    var fish3Node: SKSpriteNode!
    var fish: Int = 0
    var fishCollected = false
    var fishNumLabel: SKLabelNode!
    
    //Timers
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    

    
    override func didMove(to view: SKView){
        
        //Finds and unwraps the Spawn point of the player
        startPoint = childNode(withName: "StartPoint") as! SKSpriteNode

       
        //Player positioning settings
        addChild(player)
        player.position = startPoint.position
        player.zPosition = 1
        player.physicsBody?.categoryBitMask = PhysicsCategory.Penguin
        player.physicsBody?.collisionBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin | PhysicsCategory.Bear
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Rock | PhysicsCategory.BabyPenguin | PhysicsCategory.Bear | PhysicsCategory.Fish
        player.scale(to: CGSize(width: 30, height: 30))
        physicsWorld.contactDelegate = self
        
        //Fish
    
        fish1 = childNode(withName: "fish1") as! SKSpriteNode
        fish1.physicsBody?.categoryBitMask = PhysicsCategory.Fish
        fish1.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        fish1.zPosition = 1
        fish2 = childNode(withName: "fish2") as! SKSpriteNode
        fish2.physicsBody?.categoryBitMask = PhysicsCategory.Fish
        fish2.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        fish2.zPosition = 1
        fish3 = childNode(withName: "fish3") as! SKSpriteNode
        fish3.physicsBody?.categoryBitMask = PhysicsCategory.Fish
        fish3.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        fish3.zPosition = 1
        fish1Node = camera?.childNode(withName: "fish1Node") as! SKSpriteNode
        fish2Node = camera?.childNode(withName: "fish2Node") as! SKSpriteNode
        fish3Node = camera?.childNode(withName: "fish3Node") as! SKSpriteNode
        //fishNumLabel = camera?.childNode(withName: "fishNumLabel") as! SKLabelNode
        //fishNumLabel.text = String("\(fish)")
        //addChild(fishNumLabel)
        
        
        //sets up and observers to read when a buttonNode has been clicked
        NotificationCenter.default.addObserver(self, selector: #selector(playerMovement), name: Notification.Name(ButtonNode.buttonTappedNotification), object: nil)
        
        //collects all the childNodes available in the scene
        enumerateChildNodes(withName: "//*"){ node, _ in
            if let interactiveNode = node as? ButtonNode {
                interactiveNode.didMoveToScene()
            }
        }
        SKTAudio.sharedInstance().playBackgroundMusic("Ice_cavern.m4a")
        setupCamera()
        //Unwraps the Rocktile map to make it available for Physics
        rockTileMap = childNode(withName: "Rock") as? SKTileMapNode
        setupObstaclePhysics()
        
    }
    
    //When contact is made checks to see what two objects connected and fires accordingly
    func didBegin(_ contact: SKPhysicsContact ){
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.Bear {
            print("Lose!")
            
            player.stop()
            lose()
            gameOver = true
            
        }
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.BabyPenguin {
            print("Win!")
            player.stop()
            if fishCollected {
                win()
            }
            else {
                
                inGameMessage(text: "Your baby is hungry get more fish!")
                print("messagePrinted")
            }
        }
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.Rock{
        print("Contact Made!")
            if player.zRotation == 180{
                player.position.y += 2
            }
            else if player.zRotation == 0{
                player.position.y -= 2
            }
            if player.zRotation == 90 {
                player.position.x += 2
            }
            else if player.zRotation == -90 {
                player.position.x -= 2
            }
            player.stop()
            isMoving = false
            
        }
        
        if collision == PhysicsCategory.Penguin | PhysicsCategory.Fish {
            //print("FISH!")
            
            if contact.bodyB.node?.name == "fish1" {
                fish1.run(SKAction.hide())
                fish1Node.run(SKAction.unhide())
                fish += 1
                //print("\(fish)")
            }
            if contact.bodyB.node?.name == "fish2" {
                fish2.run(SKAction.hide())
                fish2Node.run(SKAction.unhide())
                fish += 1
                //print("\(fish)")
            }
            if contact.bodyB.node?.name == "fish3" {
                fish3.run(SKAction.hide())
                fish3Node.run(SKAction.unhide())
                fish += 1
               // print("\(fish)")
            }
            if fish == 3 {
                fishCollected = true
            }
            //fishNumLabel.removeFromParent()
            //fishNumLabel.text = String("\(fish)")
           // addChild(fishNumLabel)
        }
        
    }
    //Camera Follows the player
    func setupCamera(){
        guard let camera = camera else { return }
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
     
            camera.constraints = [playerConstraint]
        
        fish1Node.run(SKAction.hide())
        fish2Node.run(SKAction.hide())
        fish3Node.run(SKAction.hide())
    }
    //Goes through the Rock Tile Map and gives each tile its own physics body
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
        //RockTile Physic Settings
        rockTileMap.physicsBody = SKPhysicsBody(bodies: physicsBodies)
        rockTileMap.physicsBody?.isDynamic = false
        rockTileMap.physicsBody?.friction = 1
        rockTileMap.physicsBody?.restitution = 0
        rockTileMap.physicsBody?.categoryBitMask = PhysicsCategory.Rock
        rockTileMap.physicsBody?.collisionBitMask = PhysicsCategory.Penguin
        rockTileMap.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        
    }

    //Tells setupObstaclePhysics() what the definition of a single node is
    func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition? {
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
   
    //Rotates the player in the 4 cardinal directions with a Dpad
    @objc func playerMovement(notification: NSNotification) {
        guard let buttonName: String = notification.userInfo?["button"] as? String else {
            return
        }
        
        print(buttonName)
        
        if buttonName == "Up" {
            if !isMoving {
                player.zRotation = CGFloat(180).degreesToRadians()
            }
        }
        else if buttonName == "Down"{
            if !isMoving {
                player.zRotation = CGFloat(0).degreesToRadians()
            }
        }
        else if buttonName == "Left"{
            if !isMoving {
                player.zRotation = CGFloat(-90).degreesToRadians()
            }
        }
        else if buttonName == "Right"{
            if !isMoving {
                player.zRotation = CGFloat(90).degreesToRadians()
            }
        }
        else if buttonName == "Slide"
        {
            if !isMoving { //protects from the player cheating and moving while on the path
            player.move()
            SKTAudio.sharedInstance().playSoundEffect("Skate.wav")
            isMoving = true
            }
        }
        else if buttonName == "WSBack"
        {
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            let scene = MainMenuScene(fileNamed: "WorldSelect")
            scene?.scaleMode = .aspectFill
            view!.presentScene(scene)
        }
        print(player.zRotation)
    }
    
    func win() { //present message and fire newGame() after 3 sec
        inGameMessage(text: "Congrats")
       SKTAudio.sharedInstance().pauseBackgroundMusic()
      run(SKAction.afterDelay(3, runBlock: mainMenu))
    }
    
    func lose() {
        if !gameOver {
            camera?.constraints?.removeAll()
            var background: SKSpriteNode
            background = SKSpriteNode(imageNamed: "gameover")
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            run(SKAction.playSoundFileNamed("gg", waitForCompletion: false))
            background.position = CGPoint(x: (camera?.position.x)!, y: (camera?.position.y)!)
            //background.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2)
            background.scale(to: CGSize(width: 667, height: 375))
            background.zPosition = 100
            addChild(background)
            run(SKAction.afterDelay(3, runBlock: mainMenu))
        }
    }
    
    func inGameMessage(text:String){ // Shows message to the player
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.maxY - 30)

        addChild(message)
        print("messageDeleted")
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
    
    func mainMenu(){ //increments the Levels and ressets the Scene
        let scene = MainMenuScene(fileNamed: "MainMenu")
        scene?.scaleMode = .aspectFill
        view!.presentScene(scene)
    }
}
