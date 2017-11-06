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
        
        print("levelselect_\(selectedMap!)")
        background.texture = SKTexture(imageNamed: "levelselect_\(selectedMap!)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "level1" {
                let scene = ItemShopScene(fileNamed: "ItemShopScene")
                scene?.locationToTravel = selectedMap
                scene?.levelToTravel = 1
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
        }
    }
}
