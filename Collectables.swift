//
//  Collectables.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/13/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class Collectables: SKSpriteNode, SKPhysicsContactDelegate {
    
    /*
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        /*
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0   // no bounce
        self.physicsBody?.categoryBitMask = ColliderType.collectables
        self.physicsBody?.collisionBitMask = ColliderType.player
        */
    }
    
    convenience init(color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
        print("GOOD")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    */
    
    
}
