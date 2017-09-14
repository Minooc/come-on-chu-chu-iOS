//
//  MainMenuScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
           
            if let nameOfCat = touchedNode.name {
                
                let scene = GameplayScene(fileNamed: "Egypt1")
                scene?.playerImage = nameOfCat
                scene!.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
            
        
        }
        
    }
    
    
}
