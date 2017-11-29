//
//  Player.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {

    private var blinkAnimation = [SKTexture]()
    private var animateBlinkAction = SKAction()
    
    func initialize() {
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
//        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 50))
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0   // no bounce
        self.physicsBody?.categoryBitMask = ColliderType.player
        self.physicsBody?.collisionBitMask = ColliderType.obstacles
        self.physicsBody?.contactTestBitMask = ColliderType.collectables
        
    }
    
    
    func movePlayer() {
        self.position.x += 4
    }
    
    func sinkPlayer() {
        self.position.y -= 7
    }
    
    func floatPlayer() {
        self.position.y += 7
    }
    
    func initializeBlinkAnimation(timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        
        let thisTexture = SKTexture(cgImage: (self.texture?.cgImage())!)
        let blinked = SKTexture(imageNamed: "emptycat")
//        let thisTexture = SKTexture(rect: self.frame, in: self.texture!)
    
        blinkAnimation = []
        
        for _ in 0...3 {
            blinkAnimation.append(thisTexture)
            blinkAnimation.append(blinked)
            blinkAnimation.append(thisTexture)
        }

//        blinkAnimation.append(SKTexture(imageNamed: "coin"))
//        blinkAnimation.append(self.texture!)
//        blinkAnimation.append(SKTexture(imageNamed: "coin"))
//        blinkAnimation.append()
        
        animateBlinkAction = SKAction.animate(with: blinkAnimation, timePerFrame: timePerFrame, resize: false, restore: false)
        
        
    }
    
    func animateBlink() {
         initializeBlinkAnimation(timePerFrame: 0.125)
         self.run(animateBlinkAction, withKey: "Animate")
//        self.texture = SKTexture(imageNamed: "testcat2")
    }
    
}
