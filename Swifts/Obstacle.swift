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
    
    var preExploded: Bool = false
    var exploded: Bool = false
    

    func initializePlayerAndAnimations(atlasName: String, prefix: String, timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        
        // store images to array
        for i in 1...textureAtlas.textureNames.count {
            let name = "\(prefix)\(i)"
            obstacleAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateObstacleAction = SKAction.animate(with: obstacleAnimation, timePerFrame: timePerFrame, resize: true, restore: false)
        
    
    }
    
    func preExplosion(atlasName: String, prefix: String, timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        
        // store images to array
        for i in 1...3 {
            let name = "\(prefix)\(i)"
            obstacleAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateObstacleAction = SKAction.animate(with: obstacleAnimation, timePerFrame: timePerFrame, resize: true, restore: false)
        
        
    }
    
    func explosion(atlasName: String, prefix: String, timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        
        // store images to array
        for i in 4...textureAtlas.textureNames.count {
            let name = "\(prefix)\(i)"
            obstacleAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateObstacleAction = SKAction.animate(with: obstacleAnimation, timePerFrame: timePerFrame, resize: true, restore: false)
        
        
    }

    
    func animateObject() {
        initializePlayerAndAnimations(atlasName: "NY_obj.atlas", prefix: "obj_NY1_", timePerFrame: 0.08)
        self.run(SKAction.repeatForever(animateObstacleAction), withKey: "Animate")
    }
    
    func flying() {
        self.position.x -= 7
    }
    
    func rising() {
        if (self.position.y - self.size.height / 2 < (0 - 755/2)) {
            self.position.y += 6
        }
    }
    
    func ass() {
        initializePlayerAndAnimations(atlasName: "Japan_Monkey.atlas", prefix: "Japan_monkey_", timePerFrame: 0.3)
        self.run(SKAction.repeatForever(animateObstacleAction), withKey: "Animate")
    }
    
    func preExplode() {
        if (preExploded == false) {
            preExploded = true
            preExplosion(atlasName: "Japan_WasabiBomb.atlas", prefix: "WasabiBomb", timePerFrame: 0.3)
            self.run(animateObstacleAction, withKey: "Animate")

        }
    }
    
    func bombExplode() {
        
        if (exploded == false) {
            exploded = true
            initializePlayerAndAnimations(atlasName: "Japan_WasabiBomb.atlas", prefix: "WasabiBomb", timePerFrame: 0.08)
            self.run(animateObstacleAction, withKey: "Animate")

        }
//        self.run(SKAction.repeatForever(animateObstacleAction), withKey: "Animate")
    }
    
}
