//
//  LevelSelectScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/25/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class LevelSelectScene: SKScene {
    
    var selectedMap: String!
    
    override func didMove(to view: SKView) {
        
        let background: SKSpriteNode!
        background = self.childNode(withName: "background") as! SKSpriteNode
        
        
        background.texture = SKTexture(imageNamed: "levelselect_\(selectedMap!)")
    }
}
