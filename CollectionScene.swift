//
//  CollectionScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/22/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class CollectionScene: SKScene {
    
    var background: SKSpriteNode!
    var switchImage: SKSpriteNode!
    var currentTime: String!
    var selected: String!
    
    override func didMove(to view: SKView) {
        
        background = self.childNode(withName: "background") as! SKSpriteNode
        switchImage = self.childNode(withName: "switchImage") as! SKSpriteNode
        
        currentTime = "daytime"
        selected = "default"
        
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
            
            if touchedNode.name == "switchBtn" {
                if (currentTime == "daytime") {
                    switchImage.texture = SKTexture(imageNamed: "switch on")
                } else if (currentTime == "nighttime") {
                    switchImage.texture = SKTexture(imageNamed: "switch off")
                }
                perform(#selector(shuffleCurrentTime), with: nil, afterDelay: 0.1)
               
            }
            
            if touchedNode.name == "normalBtn" {
                selected = "normalSelected"
            }
            
            if touchedNode.name == "rareBtn" {
                selected = "rareSelected"
            }
            
            if touchedNode.name == "superrareBtn" {
                selected = "superrareSelected"
            }
            
            if touchedNode.name == "holycrapBtn" {
                selected = "holycrapSelected"
            }
            
            if touchedNode.name == "mycatBtn" {
                selected = "mycatSelected"
            }
            
            perform(#selector(setImage), with: nil, afterDelay: 0.1)
        }
    }
    
    func shuffleCurrentTime() {
        if (currentTime == "daytime") {
            currentTime = "nighttime"
        } else if (currentTime == "nighttime") {
            currentTime = "daytime"
        }
    }
    
    func setImage() {
        background.texture = SKTexture(imageNamed: "\(currentTime!)-\(selected!)")
    }
}
