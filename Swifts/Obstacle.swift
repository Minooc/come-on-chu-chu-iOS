//
//  Obstacle.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/27/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var obstacleAnimation = [SKTexture]()
    private var animateObstacleAction = SKAction()
    
    private var lastY = CGFloat()
    

    func initializePlayerAndAnimations(atlasName: String, prefix: String ) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        
        // store images to array
        for i in 1...textureAtlas.textureNames.count {
            let name = "\(prefix)\(i)"
            obstacleAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateObstacleAction = SKAction.animate(with: obstacleAnimation, timePerFrame: 0.08, resize: true, restore: false)
    
    }
    
    func animateObject() {
        initializePlayerAndAnimations(atlasName: "NY_obj.atlas", prefix: "obj_NY1_")
        self.run(SKAction.repeatForever(animateObstacleAction), withKey: "Animate")
    }
}
