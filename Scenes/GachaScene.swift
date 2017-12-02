//
//  GachaScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 11/17/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class GachaScene: SKScene {
    
    var swish1: SKSpriteNode!
    var swish2: GachaObjects!
    var swish3: GachaObjects!
    
    var feedCommon: SKSpriteNode!
    var feedRare: GachaObjects!
    var feedSuperRare: GachaObjects!
    
    override func didMove(to view: SKView) {
        initializeObject()
        feed()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "CleanCatHouseBtn" {
                cleancat()
            }
            
            if touchedNode.name == "FeedBtn" {
                feed()
            }
            
            if touchedNode.name == "backToMenu" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
        }
    }
    
    func initializeObject() {
        swish1 = self.childNode(withName: "Swish1") as? SKSpriteNode
        swish2 = self.childNode(withName: "Swish2") as? GachaObjects
        swish3 = self.childNode(withName: "Swish3") as? GachaObjects
        
        swish2.animateObject(atlasName: "CCH_Swish_2.atlas", prefix: "CCH_Swish_2_", timePerFrame: 0.18)

        swish3.animateObject(atlasName: "CCH_Swish_3.atlas", prefix: "CCH_Swish_3_", timePerFrame: 0.18)
        
        feedCommon = self.childNode(withName: "Feed_Common") as? SKSpriteNode
        feedRare = self.childNode(withName: "Feed_Rare") as? GachaObjects
        feedSuperRare = self.childNode(withName: "Feed_Super_Rare") as? GachaObjects
        
        feedRare.animateObject(atlasName: "Feed_Rare.atlas", prefix: "Feed_Rare_", timePerFrame: 0.2)

        feedSuperRare.animateObject(atlasName: "Feed_Super_Rare.atlas", prefix: "Feed_Super_Rare_", timePerFrame: 0.2)
    }
    
    
    
    func cleancat() {
        swish1.isHidden = false
        swish2.isHidden = false
        swish3.isHidden = false
        
        feedCommon.isHidden = true
        feedRare.isHidden = true
        feedSuperRare.isHidden = true
        
        
    }
    
    func feed() {
        
        swish1.isHidden = true
        swish2.isHidden = true
        swish3.isHidden = true
        
        feedCommon.isHidden = false
        feedRare.isHidden = false
        feedSuperRare.isHidden = false
    }
    
}
