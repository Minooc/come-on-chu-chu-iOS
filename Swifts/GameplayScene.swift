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
    
    var nextLevel: Int!
    var backgroundLengthSum: CGFloat!
    
    var playerGotHit = false
    var playerCanGetHit = true
    
    var scoreText: SKLabelNode!
    var coinText: SKLabelNode!
    
    var firstHealth: SKSpriteNode!
    var secondHealth: SKSpriteNode!
    var thirdHealth: SKSpriteNode!
    
    var fishTail: SKSpriteNode!
    var fishBody: SKSpriteNode!
    var fishHead: SKSpriteNode!
    
    var gotFishTail: Bool!
    var gotFishBody: Bool!
    var gotFishHead: Bool!
    
    var obstacles = [Obstacle]()
    
    var loaded: Bool!
    
    override func didMove(to view: SKView) {
        // initialize everything
        
        physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "Player") as? Player
        //player?.texture = SKTexture(imageNamed: playerImage!)
        player?.initialize()
        
        previousBackground = SKSpriteNode()
        previousBackground.position = CGPoint(x: 99999, y: 0)
        backgroundLengthSum = 0
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        labelLocater()
        
        GameplayController.instance.scoreText = scoreText
        GameplayController.instance.coinText = coinText
        GameplayController.instance.initializeVariables()
        
        health = 3
        gotFishBody = false
        gotFishHead = false
        gotFishTail = false
        
        healthLocater()
        interfaceLocater()
        fishLocater()
        
        setObstacles()

        loaded = false
        nextLevel = 1
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        
        player?.movePlayer()
        moveCamera()
        managePlayer()
        
        if (playerSink) {
            player?.sinkPlayer()
        } else {
            player?.floatPlayer()
        }
        
        if !loaded {
            if (player!.position.x > background.position.x + (background.size.width / 2) - 1100) {

                print("close close!")
                loadNextLevel()
            }
        }
        
        else {
            if (player!.position.x > previousBackground.position.x + (previousBackground.size.width / 2) + 1100) {
                removePreviousLevel()
            }
        }
    }
    
    func loadNextLevel() {
        loaded = true
        
        nextLevel = nextLevel + 1
        
        print("NY\(nextLevel!)")
        let nextScene = SKScene(fileNamed: "NY\(nextLevel!)")
        


//        nextScene?.enumerateChildNodes(withName: "//*", using: { (node, stop) -> Void in
        

//        if (node.name == "background") {
        if let node = nextScene?.childNode(withName: "background") {
            let nextNode = node.copy() as! SKSpriteNode
            nextNode.position.x += self.background.size.width + backgroundLengthSum
            self.addChild(nextNode)
            
            self.previousBackground = self.background
            self.background = nextNode
            print("background changed")

        }

            
//        })
        
        backgroundLengthSum = backgroundLengthSum + previousBackground.size.width

        

    }
    
    func removePreviousLevel() {
//        for child in previousBackground.children as [SKNode] {
//            child.removeFromParent()
//        }
        previousBackground.removeFromParent()
        print("removed")
        loaded = false
    }
    
    func setObstacles() {
        
        while(true) {
            if let obs = self.childNode(withName: "obstacle") as? Obstacle {
                obs.animateObject()
                obs.name = "GeneralObstacle"
            }
            else {
                break
            }
        }
        

    }
    
    func labelLocater() {
        scoreText = SKLabelNode(fontNamed: "Conformity")
        scoreText.fontSize = 48
        scoreText.fontColor = UIColor.darkText
        scoreText.position = CGPoint(x: 442.152, y: 313.243)
        scoreText.zPosition = 3
        self.mainCamera?.addChild(scoreText)
        
        coinText = SKLabelNode(fontNamed: "Conformity")
        coinText.fontSize = 48
        coinText.fontColor = UIColor.darkText
        coinText.position = CGPoint(x: -550.779, y: 313.243)
        coinText.zPosition = 3
        self.mainCamera?.addChild(coinText)
    }
    
    func interfaceLocater() {
        // Health bar, Coin image, Coin label, Score image, Score label, Booster, pause, item
        
        // pause
        let pauseBtn = SKSpriteNode(imageNamed: "pause_button-crop")
        pauseBtn.anchorPoint = CGPoint(x: 0.5, y:0.5)
        pauseBtn.size.width = 75.5
        pauseBtn.size.height = 75.2
        pauseBtn.position = CGPoint(x: 603.8, y: 323.7)
        pauseBtn.zPosition = 3
        self.mainCamera?.addChild(pauseBtn)
        
        // collectable image
        let collectableImg = SKSpriteNode(imageNamed: "Collectable_located")
        collectableImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        collectableImg.size.width = 1337
        collectableImg.size.height = 750
        collectableImg.position = CGPoint(x: 0, y: 0)
        collectableImg.zPosition = 3
        self.mainCamera?.addChild(collectableImg)
        
     
        // coin image
        let coinImg = SKSpriteNode(imageNamed: "Coin_located")
        coinImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        coinImg.size.width = 1337
        coinImg.size.height = 750
        coinImg.position = CGPoint(x: 0, y: 0)
        coinImg.zPosition = 3
        self.mainCamera?.addChild(coinImg)
        
        // booster
        let booster = SKSpriteNode(imageNamed: "booster_button-crop")
        booster.anchorPoint = CGPoint(x: 0.5, y:0.5)
        booster.size.width = 251.991
        booster.size.height = 154.679
        booster.position = CGPoint(x: 529.742, y: -266.488)
        booster.zPosition = 3
        self.mainCamera?.addChild(booster)
        
        
        let length = SKSpriteNode(imageNamed: "length_showing")
        length.anchorPoint = CGPoint(x: 0.5, y:0.5)
        length.size.width = 1337
        length.size.height = 750
        length.position = CGPoint(x: 0, y: 0)
        length.zPosition = 3
        self.mainCamera?.addChild(length)
        
        let fish_bottom = SKSpriteNode(imageNamed: "Collectable_fish_buttom")
        fish_bottom.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fish_bottom.size.width = 1337
        fish_bottom.size.height = 750
        fish_bottom.position = CGPoint(x: 0, y: 0)
        fish_bottom.zPosition = 3
        self.mainCamera?.addChild(fish_bottom)
        
    }
    
    func healthLocater() {
        
        firstHealth = SKSpriteNode(imageNamed: "1_health")
        firstHealth.anchorPoint = CGPoint(x: 0.5, y:0.5)
        firstHealth.size.width = 1337
        firstHealth.size.height = 750
        firstHealth.position = CGPoint(x: 0, y: 0)
        firstHealth.zPosition = 3
        self.mainCamera?.addChild(firstHealth)
        
        secondHealth = SKSpriteNode(imageNamed: "2_health")
        secondHealth.anchorPoint = CGPoint(x: 0.5, y:0.5)
        secondHealth.size.width = 1337
        secondHealth.size.height = 750
        secondHealth.position = CGPoint(x: 0, y: 0)
        secondHealth.zPosition = 3
        self.mainCamera?.addChild(secondHealth)
        
        thirdHealth = SKSpriteNode(imageNamed: "3_full_health")
        thirdHealth.anchorPoint = CGPoint(x: 0.5, y:0.5)
        thirdHealth.size.width = 1337
        thirdHealth.size.height = 750
        thirdHealth.position = CGPoint(x: 0, y: 0)
        thirdHealth.zPosition = 3
        self.mainCamera?.addChild(thirdHealth)
        
        
    }
    
    func fishLocater() {
        fishTail = SKSpriteNode(imageNamed: "Collectable_fish_tail")
        fishTail.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fishTail.size.width = 1337
        fishTail.size.height = 750
        fishTail.position = CGPoint(x: 0, y: 0)
        fishTail.zPosition = 4
        self.mainCamera?.addChild(fishTail)
        
        fishBody = SKSpriteNode(imageNamed: "Collectable_fish_body")
        fishBody.anchorPoint = CGPoint(x: 0.5, y:0.5)
        fishBody.size.width = 1337
        fishBody.size.height = 750
        fishBody.position = CGPoint(x: 0, y: 0)
        fishBody.zPosition = 4
        self.mainCamera?.addChild(fishBody)
        
        fishHead = SKSpriteNode(imageNamed: "Collectable_fish_head")
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
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "GeneralObstacle" {
            
            if (playerCanGetHit) {
                print("You got hit")
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
            
            
            playerSink = true
            
            

        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerSink = false
        
    }
    
    func moveCamera() {
        self.mainCamera?.position.x += 4   // move camera right
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
            
            perform(#selector(setPlayerCanGetHitTrue), with: nil, afterDelay: 1.0)
            
        }
        
        if health == 3 {
            thirdHealth.isHidden = false
            secondHealth.isHidden = false
            firstHealth.isHidden = false
        }
        
        if health <= 2 {
            thirdHealth.isHidden = true
            secondHealth.isHidden = false
            firstHealth.isHidden = false
        }
        
        if health <= 1 {
            thirdHealth.isHidden = true
            secondHealth.isHidden = true
            firstHealth.isHidden = false
        }
        
        if health == 0 {
            thirdHealth.isHidden = true
            secondHealth.isHidden = true
            firstHealth.isHidden = true
            
            print("Health is 0")
            gameEnd()
            self.scene?.isPaused = true
        }
        

    }
    
    func setPlayerCanGetHitTrue() {
        playerCanGetHit = true
        print("Now you can hit again")
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
