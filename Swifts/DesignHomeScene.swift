//
//  MyHome.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/18/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class DesignHomeScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "backToMenu" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
            

            
        }
    }
    
    
}

