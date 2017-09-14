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
            
            // TO DO: sound, score up
            
            secondBody.node?.removeFromParent()
            
        
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
        self.mainCamera?.position.x += 7   // move camera right
    }
    
    
    
}
