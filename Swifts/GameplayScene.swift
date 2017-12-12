//
//  GameplayScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate  {
    
    var player: Player?
    var playerImage: String?
    var playerSink = false
    
    var background: SKSpriteNode!
    var previousBackground: SKSpriteNode!
    
    var mainCamera: SKCameraNode?
    
    var health: Int!
    
    var boostEnabled: Bool!
    var boostMeter: Int!
    var boostBtn: Boost!
    var boostShape: SKShapeNode!
    
    var currentLocation: String?
    var nextLevel: Int!
    var backgroundLengthSum: CGFloat!
    
    var playerGotHit = false
    var playerCanGetHit = true
    
    var scoreText: MKOutlinedLabelNode!
    var coinText: SKLabelNode!
    
    var fishTail: SKSpriteNode!
    var fishBody: SKSpriteNode!
    var fishHead: SKSpriteNode!
    
    var gotFishTail: Bool!
    var gotFishBody: Bool!
    var gotFishHead: Bool!
    
    var obstacles = [Obstacle]()
    var lifeEngine: LifeEngine!
    
    var loaded: Bool!
    
    var sunglassTrigger: Bool!
    var boostTrigger: Bool!

    
    override func didMove(to view: SKView) {
        
        // initialize everything
        
        physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "Player") as? Player
        //player?.texture = SKTexture(imageNamed: playerImage!)
        player?.initialize()
        
        previousBackground = SKSpriteNode()
        previousBackground.position = CGPoint(x: 99999, y: 0)
        backgroundLengthSum = 0
        health = 4
        
        // Set camera and background
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        background = self.childNode(withName: "background") as? SKSpriteNode
        

        
        
        
        // Initialize booster
        boostMeter = 0
        boostEnabled = false
        boostBtn = Boost()
        self.mainCamera?.addChild(boostBtn)
        boostBtn.texture = SKTexture(imageNamed: "BoosterBtn-0")
        
        // Initialize Life Engine
        lifeEngine = LifeEngine()
        self.mainCamera?.addChild(lifeEngine)
        lifeHandler()
    
        
        labelLocater()
        
        GameplayController.instance.scoreText = scoreText
        GameplayController.instance.coinText = coinText
        GameplayController.instance.initializeVariables()
        
        gotFishBody = false
        gotFishHead = false
        gotFishTail = false
        
        interfaceLocater()
        fishLocater()
        setObstacles()

        loaded = false
//        nextLevel = 1
        
        boostTrigger = true
        sunglassTrigger = true
        
        
        print("Current Location is \(currentLocation)")
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        
        player?.movePlayer()


        
        moveCamera()
        managePlayer()
        
        obstacleHandler()
        
        
        if (playerSink) {
            player?.sinkPlayer()
        } else {
            player?.floatPlayer()
        }
        
        
        // If player got all 3 fishes
        
        if (gotFishBody && gotFishTail && gotFishHead && sunglassTrigger) {
            sunglassTrigger = false
            wearGlass()
        }
        
        
        if (boostMeter == 12 && boostTrigger) {
            boostTrigger = false
            boostFilled()
        }

        
        
        // prepare to load next level
        
        if !loaded {

            if (player!.position.x > background.position.x + (background.size.width/2) - 1100) {

                print("close close!")
                loadNextLevel()
            }
        }
            
        // remove previous level
        
        else {
            if (player!.position.x > previousBackground.position.x + (previousBackground.size.width / 2) + 1100) {
                removePreviousLevel()
            }
        }

    }
    

    

    
    func loadNextLevel() {
        loaded = true
        
        nextLevel = nextLevel + 1

        print("\(currentLocation!)\(nextLevel!)")
        let nextScene = SKScene(fileNamed: "\(currentLocation!)\(nextLevel!)")


        if let node = nextScene?.childNode(withName: "background") {
            let nextNode = node.copy() as! SKSpriteNode
            nextNode.position.x += self.background.size.width + backgroundLengthSum
            self.addChild(nextNode)

            self.previousBackground = self.background
            self.background = nextNode
            print("background changed")

        }

        backgroundLengthSum = backgroundLengthSum + previousBackground.size.width
        setObstacles()

    }
    
    func removePreviousLevel() {

        previousBackground.removeFromParent()
        loaded = false
    }
    
    func wearGlass() {
        
        
        
        
        
        
    }
    
    func boostUp() {
        if (boostMeter < 12 && player?.boosted == false) {
            boostMeter = boostMeter + 1
            boostBtn.texture = SKTexture(imageNamed: "BoosterBtn-\(boostMeter!)")
        }
    }
    
    func boostFilled() {
        boostBtn.animateObject(atlasName: "BoostFull.atlas", prefix: "BoosterBtn-full_", timePerFrame: 0.14)
        boostEnabled = true
    }
    
    func boostFire() {
        
        // Do something here
        player?.boosted = true
        
        // Re-initialize boost
        boostBtn.stopAnimation()
        boostBtn.texture = SKTexture(imageNamed: "BoosterBtn-0")
        boostMeter = 0
        boostEnabled = false
        boostTrigger = true
        
        perform(#selector(boostEnd), with: nil, afterDelay: 5.0)
    }
    
    func boostEnd() {
        print("boost ended")
        player?.boosted = false
        playerGotHit = true
        playerCanGetHit = false
        
    }
    
    
    func setObstacles() {
        
        
        for obs in background.children {
            if let ob = obs as? Obstacle {

                ob.move(toParent: self)

            }
        }
        
        while(true) {
            if let obs = self.childNode(withName: "princess_cat") as? Obstacle {
                obs.animateObject(atlasName: "England_princess.atlas", prefix: "England_princess_cat_", timePerFrame: 0.16)
                
                obs.name = "StandingObstacle"
                obstacles.append(obs)
            }
            else if let obs = self.childNode(withName: "pie") as? Obstacle {
                obs.animateObject(atlasName: "England_pie.atlas", prefix: "England_pie_", timePerFrame: 0.21)
                obs.name = "StandingObstacle"
                obstacles.append(obs)
                
            }
            else if let obs = self.childNode(withName: "umbrella cat") as? Obstacle {
                obs.animateObject(atlasName: "England_umbrella.atlas", prefix: "England_umbrella_", timePerFrame: 0.14)
                obs.name = "DroppingObstacle"
                obstacles.append(obs)
                
            }
            
            else if let obs = self.childNode(withName: "director_cat") as? Obstacle {
                obs.animateObject(atlasName: "LA_director.atlas", prefix: "LA_director_cat_", timePerFrame: 0.12)
                obs.name = "FlyingObstacle"
                obstacles.append(obs)
                
            }
                
            else if let obs = self.childNode(withName: "dancing_cat") as? Obstacle {
                obs.animateObject(atlasName: "Spain_dancing_cat.atlas", prefix: "Spain_dancing_cat_", timePerFrame: 0.16)
                obs.name = "WalkingObstacle"
                obstacles.append(obs)
                
            }
                
            else if let obs = self.childNode(withName: "cat_man") as? Obstacle {
                obs.animateObject(atlasName: "Spain_catman.atlas", prefix: "Spain_catman_", timePerFrame: 0.05)
                obs.name = "WalkingObstacle"
                obstacles.append(obs)
                
            }
              
            else if let obs = self.childNode(withName: "tomato") as? Obstacle {
                
                obs.name = "ChaseObstacle"
                obstacles.append(obs)
                
            }
               
            else if let obs = self.childNode(withName: "dropping") as? Obstacle {
                obs.name = "DroppingObstacle"
                obstacles.append(obs)
                
            }
                
            else if let obs = self.childNode(withName: "flying") as? Obstacle {
                obs.name = "FlyingObstacle"
                obstacles.append(obs)

            }
            else if let obs = self.childNode(withName: "upflying") as? Obstacle {
                obs.name = "UpFlyingObstacle"
                obstacles.append(obs)
                
            }
            else if let obs = self.childNode(withName: "downflying") as? Obstacle {
                obs.name = "DownFlyingObstacle"
                obstacles.append(obs)
                
            }
                
            else if let obs = self.childNode(withName: "rising") as? Obstacle {
                obs.name = "RisingObstacle"
                obstacles.append(obs)
                
            }
            else if let obs = self.childNode(withName: "ass") as? Obstacle {
                obs.name = "AssObstacle"
                obs.ass()
                obstacles.append(obs)
                
            }
            else if let obs = self.childNode(withName: "bomb") as? Obstacle {
                
                obs.name = "BombObstacle"
                obstacles.append(obs)
                
            }
            else {
                break
            }
        }
        

    }
    
    func obstacleHandler() {
        for ob in obstacles {
            if ob.name == "WalkingObstacle" {
                if (ob.position.x < (player?.position.x)! + 1200) {
                    ob.walking()
                }
            }
            if ob.name == "FlyingObstacle" {
                if (ob.position.x < (player?.position.x)! + 1200) {
                    ob.flying()
                }
            }
            
            if ob.name == "UpFlyingObstacle" {
                if (ob.position.x < (player?.position.x)! + 1000) {
                    ob.upFlying()
                }
            }
            
            if ob.name == "DownFlyingObstacle" {
                if (ob.position.x < (player?.position.x)! + 1000) {
                    ob.downFlying()
                }
            }
            
            if ob.name == "DroppingObstacle" {
                if (ob.position.x < (player?.position.x)! + 1000) {
                    ob.dropping()
                }
            }
            
            if ob.name == "RisingObstacle" {
                if (ob.position.x < (player?.position.x)! + 500) {
                    ob.rising()
                }
            }
            
            if ob.name == "ChaseObstacle" {
                if (ob.position.x < (player?.position.x)! + 1100) {
                    
                    if (ob.triggered) {
                        ob.triggered = false
                        let playerX = (player?.position.x)!
                        let playerY = (player?.position.y)!
                        
                        ob.flyingSpeedX = (playerX - ob.position.x)/100
                        ob.flyingSpeedY = (playerY - ob.position.y)/100
                        
                        
                        
                    }
                    
                    ob.position.x += ob.flyingSpeedX
                    ob.position.y += ob.flyingSpeedY
                }
            }
            
            if ob.name == "BombObstacle" {
                
//                print("ob \(ob.position.x)")
//                print("player \((player?.position.x)! - 4333)")
                
                if (ob.position.x < (player?.position.x)! + 1100) {
                    
                    if (ob.triggered) {
                        
                            ob.triggered = false
                            let playerX = (player?.position.x)!
                            let playerY = (player?.position.y)!
                        
                            ob.flyingSpeedX  = (playerX - ob.position.x)/100
                            ob.flyingSpeedY  = (playerY - ob.position.y)/100
                        
                            print("pre-explosion")
                            ob.preExplode()
                        }
                    
                    if (ob.exploded == false && (ob.position.x > (player?.position.x)!)) {
                        print("explosion")
                        ob.exploded = true
                        ob.bombExplode()
                    }
                    
                    if (ob.position.x > (player?.position.x)! - 100) {
                        ob.position.x += ob.flyingSpeedX
                        ob.position.y += ob.flyingSpeedY
                        
                    }
                    
                }

                
            }
            
            if ob.name == "AssObstacle" {
                if let presetTexture = ob.texture {
                    ob.physicsBody = SKPhysicsBody(texture: presetTexture, size: (presetTexture.size()))
                    ob.physicsBody?.affectedByGravity = false
                    ob.physicsBody?.allowsRotation = false
                    ob.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    ob.physicsBody?.categoryBitMask = 2
                    ob.physicsBody?.collisionBitMask = 0
                }
            }
            
            
            // Remove obstacle that passed
            if (ob.position.x < (player?.position.x)! - 1200) {
//                print(ob.position.x)
//                print((player?.position.x)! - 1200 - 4333)
                let indexToDelete = obstacles.index(of: ob)
                ob.removeFromParent()
                obstacles.remove(at: indexToDelete!)
//                print("it's gone")
                
            }
            
            //            if (ob.position.y > 1000) {
            //                print("yeah yeah yeah")
            //            }
            //
            //            if (ob.position.y < -1000) {
            //                print("kkkkkk")
            //            }
            
            
            
        }
    }
    
    func lifeHandler() {
        if (health != 0 ) {
            lifeEngine.animateLife(amount: health)
        }
    }
    
    func labelLocater() {
        
        scoreText = MKOutlinedLabelNode(fontNamed: "Conformity", fontSize: 48)
//        scoreText = SKLabelNode(fontNamed: "Conformity")
//        scoreText.fontSize = 48
        scoreText.fontColor = UIColor.white
        scoreText.borderColor = UIColor(red: 173/256, green: 53/256, blue: 81/256, alpha: 1.0)
//        scoreText.borderColor = UIColor.blue
        scoreText.position = CGPoint(x: -557, y: 254)
        scoreText.zPosition = 3
        self.mainCamera?.addChild(scoreText)

        coinText = SKLabelNode(fontNamed: "Conformity")
        coinText.fontSize = 48
        coinText.fontColor = UIColor.white
        coinText.position = CGPoint(x: -555, y: 208)
        coinText.zPosition = 3
        self.mainCamera?.addChild(coinText)
    }
    
    func interfaceLocater() {
        
        // pause
        let pauseBtn = SKSpriteNode(imageNamed: "Pause button")
        pauseBtn.anchorPoint = CGPoint(x: 0.5, y:0.5)
        pauseBtn.size.width = 1337
        pauseBtn.size.height = 750
        pauseBtn.position = CGPoint(x: 0, y: 0)
        pauseBtn.zPosition = 3
        self.mainCamera?.addChild(pauseBtn)
        
        // collectable image
        let collectableImg = SKSpriteNode(imageNamed: "Collectable score")
        collectableImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        collectableImg.size.width = 1337
        collectableImg.size.height = 750
        collectableImg.position = CGPoint(x: 0, y: 0)
        collectableImg.zPosition = 3
        self.mainCamera?.addChild(collectableImg)
        
     
        // coin image
        let coinImg = SKSpriteNode(imageNamed: "Coin score")
        coinImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        coinImg.size.width = 1337
        coinImg.size.height = 750
        coinImg.position = CGPoint(x: 0, y: 0)
        coinImg.zPosition = 3
        self.mainCamera?.addChild(coinImg)
        
        // create circle shape of booster
        boostShape = SKShapeNode(circleOfRadius: 110)
        boostShape.zPosition = 4
        boostShape.position = CGPoint(x: 516, y: -232)
        boostShape.lineWidth = 0
        self.mainCamera?.addChild(boostShape)
        
        let fish_bottom = SKSpriteNode(imageNamed: "Fish_base")
        fish_bottom.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fish_bottom.size.width = 1337
        fish_bottom.size.height = 750
        fish_bottom.position = CGPoint(x: 0, y: 0)
        fish_bottom.zPosition = 3
        self.mainCamera?.addChild(fish_bottom)
        
    }


    
    func fishLocater() {
        fishTail = SKSpriteNode(imageNamed: "Fish_Tail")
        fishTail.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fishTail.size.width = 1337
        fishTail.size.height = 750
        fishTail.position = CGPoint(x: 0, y: 0)
        fishTail.zPosition = 4
        self.mainCamera?.addChild(fishTail)
        
        fishBody = SKSpriteNode(imageNamed: "Fish_Body")
        fishBody.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fishBody.size.width = 1337
        fishBody.size.height = 750
        fishBody.position = CGPoint(x: 0, y: 0)
        fishBody.zPosition = 4
        self.mainCamera?.addChild(fishBody)
        
        fishHead = SKSpriteNode(imageNamed: "Fish_Head")
        fishHead.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fishHead.size.width = 1337
        fishHead.size.height = 750
        fishHead.position = CGPoint(x: 0, y: 0)
        fishHead.zPosition = 4
        self.mainCamera?.addChild(fishHead)
    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // called when two objects collide
        var firstBody = SKPhysicsBody()     // it will be player
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            
            // TO DO: sound
            
            GameplayController.instance.incrementCoin()
            secondBody.node?.removeFromParent()
            
            
            
        
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Collectable" {
            
            // TO DO: sound
            
            GameplayController.instance.incrementScore()
            secondBody.node?.removeFromParent()
            
            
        
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Fish Head" {
            
            
            secondBody.node?.removeFromParent()
            gotFishHead = true
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Fish Body" {
            
            
            secondBody.node?.removeFromParent()
            gotFishBody = true
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Fish Tail" {
            
            
            secondBody.node?.removeFromParent()
            gotFishTail = true
            
        } else if firstBody.node?.name == "Player" && (secondBody.node?.name == "StandingObstacle" || secondBody.node?.name == "FlyingObstacle" || secondBody.node?.name == "WalkingObstacle" || secondBody.node?.name == "UpFlyingObstacle" || secondBody.node?.name == "DownFlyingObstacle" || secondBody.node?.name == "DroppingObstacle" || secondBody.node?.name == "RisingObstacle" || secondBody.node?.name == "AssObstacle" || secondBody.node?.name == "BombObstacle" || secondBody.node?.name == "ChaseObstacle") {
            //  secondBody.node?.name == "GeneralObstacle"
            if (playerCanGetHit && !(player?.boosted)!) {
                
                playerGotHit = true
                playerCanGetHit = false
                health = health - 1
            }
            
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "CriticalObstacle" {
            // delete this part later
            
            gameEnd()
            print("Your high score is \(GameManager.instance.getHighScore())")
            print("Your total coin is \(GameManager.instance.getTotalCoin())")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            
            // Just for Test. Delete this later.
            if touchedNode == boostShape {
                boostUp()
                
                if boostEnabled {
                    boostFire()
                }
            }
        
            
            
            playerSink = true
        }
//        for touch in touches {
//            let location = touch.location(in: self)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerSink = false
        
    }
    
    func moveCamera() {
        self.mainCamera?.position.x += 4   // move camera right
        
        if (player?.boosted)! {
            self.mainCamera?.position.x += 4
        }
    }
    

    func managePlayer() {
        

        
        if (player?.position.y)! - (player?.size.height)! * 3.0 > (mainCamera?.position.y)! {
            print("The player is out of bounds up")
            gameEnd()
            self.scene?.isPaused = true
            
        }
        
        if (player?.position.y)! + (player?.size.height)! * 3.3 < (mainCamera?.position.y)! {
            print("The player is out of bounds DOWN")
            gameEnd()
            self.scene?.isPaused = true
        }
        
        if gotFishBody {
            fishBody.isHidden = false
        } else {
            fishBody.isHidden = true
        }
        
        if gotFishTail {
            fishTail.isHidden = false
        } else {
            fishTail.isHidden = true
        }
        
        if gotFishHead {
            fishHead.isHidden = false
        } else {
            fishHead.isHidden = true
        }
        
        if playerGotHit {
            playerGotHit = false
            lifeHandler()
            player?.animateBlink()
            
            perform(#selector(setPlayerCanGetHitTrue), with: nil, afterDelay: 1.5)
            
        }

        
        if health == 0 {

            gameEnd()
            self.scene?.isPaused = true
        }
        

    }
    
    func setPlayerCanGetHitTrue() {
        playerCanGetHit = true

    }
    

    
    func gameEnd() {
        
        if (GameManager.instance.getHighScore() < GameplayController.instance.score!) {
            GameManager.instance.setHighScore(highScore: GameplayController.instance.score!)
        }
        
        let totalCoin = GameManager.instance.getTotalCoin() + GameplayController.instance.coin!
        GameManager.instance.setTotalCoin(totalCoin: totalCoin)
        
        GameManager.instance.saveData()
        
        
        let scene = MainMenuScene(fileNamed: "MainMenuScene")
        scene!.scaleMode = .aspectFill
        
        self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))

    }
    
}
