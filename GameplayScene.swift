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
    
    var mainCamera: SKCameraNode?
    
    
    override func didMove(to view: SKView) {
        // initialize everything
        
        physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "Player") as? Player
        player?.texture = SKTexture(imageNamed: playerImage!)
        player?.initialize()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        
        GameplayController.instance.scoreText = self.mainCamera!.childNode(withName: "Score Label") as? SKLabelNode
        GameplayController.instance.coinText = self.mainCamera!.childNode(withName: "Coin Label") as? SKLabelNode
        GameplayController.instance.initializeVariables()
        
        interfaceLocater()

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        player?.movePlayer()
        moveCamera()
        
        if (playerSink) {
            player?.sinkPlayer()
        } else {
            player?.floatPlayer()
        }
    }
    
    func interfaceLocater() {
        // Health bar, Coin image, Coin label, Score image, Score label, Booster, pause, item
        
        // pause
        let pauseBtn = SKSpriteNode(imageNamed: "pause")
        pauseBtn.anchorPoint = CGPoint(x: 0.5, y:0.5)
        pauseBtn.size.width = 75.5
        pauseBtn.size.height = 75.2
        pauseBtn.position = CGPoint(x: 603.8, y: 323.7)
        pauseBtn.zPosition = 3
        self.mainCamera?.addChild(pauseBtn)
        
        // collectable image
        let collectableImg = SKSpriteNode(imageNamed: "collectable")
        collectableImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        collectableImg.size.width = 79.586
        collectableImg.size.height = 68.4
        collectableImg.position = CGPoint(x: -107.319, y: 264.156)
        collectableImg.zPosition = 3
        
        self.mainCamera?.addChild(collectableImg)
        
     
        // coin image
        let coinImg = SKSpriteNode(imageNamed: "coin")
        coinImg.anchorPoint = CGPoint(x: 0.5, y:0.5)
        coinImg.size.width = 71.085
        coinImg.size.height = 70
        coinImg.position = CGPoint(x: -602.845, y: 256.506)
        coinImg.zPosition = 3
        self.mainCamera?.addChild(coinImg)
        
        // booster
        
        let booster = SKSpriteNode(imageNamed: "booster")
        booster.anchorPoint = CGPoint(x: 0.5, y:0.5)
        booster.size.width = 251.991
        booster.size.height = 154.679
        booster.position = CGPoint(x: 529.742, y: -266.488)
        booster.zPosition = 3
        self.mainCamera?.addChild(booster)
        
        let itemPanel = SKSpriteNode(imageNamed: "itemPanel")
        itemPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
        itemPanel.size.width = 318.783
        itemPanel.size.height = 109.699
        itemPanel.position = CGPoint(x: -0.828, y: -304.16)
        itemPanel.zPosition = 3
        self.mainCamera?.addChild(itemPanel)
        
        // health bar
        let healthBar = SKSpriteNode(imageNamed: "healthBar")
        healthBar.anchorPoint = CGPoint(x: 0.5, y:0.5)
        healthBar.size.width = 1178.902
        healthBar.size.height = 50.57
        healthBar.position = CGPoint(x: -55.067, y: 324.543)
        healthBar.zPosition = 3
        self.mainCamera?.addChild(healthBar)
        
        
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
            
            
        
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "End" {
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
    
    func gameEnd() {
        
        if (GameManager.instance.getHighScore() < GameplayController.instance.score!) {
            GameManager.instance.setHighScore(highScore: GameplayController.instance.score!)
        }
        
        let totalCoin = GameManager.instance.getTotalCoin() + GameplayController.instance.coin!
        GameManager.instance.setTotalCoin(totalCoin: totalCoin)
        
        GameManager.instance.saveData()
    }
    
}
