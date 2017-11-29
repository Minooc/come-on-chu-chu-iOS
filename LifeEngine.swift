//
//  LifeEngine.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 11/27/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class LifeEngine: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var lifeAnimation = [SKTexture]()
    private var animateLifeAction = SKAction()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.anchorPoint = CGPoint(x: 0.5, y:0.5)
        self.size.width = 1337
        self.size.height = 750
        self.position = CGPoint(x: 0, y: 0)
        self.zPosition = 3
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLifeAnimation(atlasName: String, prefix: String, timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        lifeAnimation = []
        
        // store images to array
        for i in 1...textureAtlas.textureNames.count {
            let name = "\(prefix)\(i)"
            lifeAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateLifeAction = SKAction.animate(with: lifeAnimation, timePerFrame: timePerFrame, resize: true, restore: false)
        
        
    }
    
    func animateLife(amount: Int) {
        initializeLifeAnimation(atlasName: "Life\(amount).atlas", prefix: "Life\(amount)-", timePerFrame: 0.11)
        self.run(SKAction.repeatForever(animateLifeAction), withKey: "Animate")
    }
    
    


}
