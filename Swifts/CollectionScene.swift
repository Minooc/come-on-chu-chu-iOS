//
//  CollectionScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/22/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class CollectionScene: SKScene {
    
    var createCat: SKSpriteNode!
    
    var background: SKSpriteNode!
    var switchImage: SKSpriteNode!
    var currentTime: String!
    var selected: String!
    
    var collectionTable: CollectionTable!
    
    override func didMove(to view: SKView) {
        
        background = self.childNode(withName: "background") as! SKSpriteNode
        switchImage = self.childNode(withName: "switchImage") as! SKSpriteNode
        
        currentTime = "daytime"
        selected = "default"
        
        collectionTable = CollectionTable()
        collectionTableHandler()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            

          
            if touchedNode.name == "backToMenu" {
                
                collectionTable.removeFromSuperview()
                
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
                collectionTable.category = "Normal Cat"
                //collectionTable.cats = ["name1", "name2", "3", "6", "createcat"]

                
            }
            
            if touchedNode.name == "rareBtn" {
                selected = "rareSelected"
                collectionTable.category = "Rare Cat"
                //collectionTable.cats = ["name1", "name2", "createcat"]
            }
            
            if touchedNode.name == "superrareBtn" {
                selected = "superrareSelected"
                collectionTable.category = "Super Rare Cat"
                
            }
            
            if touchedNode.name == "holycrapBtn" {
                selected = "holycrapSelected"
                collectionTable.category = "Holy Crap Cat"
                
            }
            
            if touchedNode.name == "mycatBtn" {
                selected = "mycatSelected"
                collectionTable.category = "My Cat"
                
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
        collectionTable.reloadData()
    }
    
    func collectionTableHandler() {
        
        
        
        collectionTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        collectionTable.frame=CGRect(x:120,y:150,width:310,height:240)
        collectionTable.backgroundColor = .clear
        collectionTable.separatorColor = .clear
        self.scene?.view?.addSubview(collectionTable)
        collectionTable.reloadData()
        
    }
}
