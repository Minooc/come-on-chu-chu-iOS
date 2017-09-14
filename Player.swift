//
//  Player.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func initialize() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 50))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.4)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0   // no bounce
        self.physicsBody?.categoryBitMask = ColliderType.player
        self.physicsBody?.collisionBitMask = ColliderType.obstacles
        self.physicsBody?.contactTestBitMask = ColliderType.collectables
        
    }
    
    
    func movePlayer() {
        self.position.x += 7
    }
    
    func sinkPlayer() {
        self.position.y -= 10
    }
    
    func floatPlayer() {
        self.position.y += 10
    }
    
}
