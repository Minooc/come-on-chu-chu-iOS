//
//  ItemShopScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/27/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class ItemShopScene: SKScene {
    
    var itemSelected: SKSpriteNode!
    var background: SKSpriteNode!
    var instruction: SKSpriteNode!
    var boostBuyPanel: SKSpriteNode!
    var item_big: SKSpriteNode!
    
    var boostPanelSelected: Bool!
    
    // boost items
    var autoFlying: SKSpriteNode!
    var bubbleShield: SKSpriteNode!
    var slipperyLotion: SKSpriteNode!
    var fluufyTail: SKSpriteNode!
    var badassPaw: SKSpriteNode!
    var awesomeSticker: SKSpriteNode!
    var instantFish: SKSpriteNode!
    var randomBox: SKSpriteNode!
    
    var locationToTravel: String!
    var levelToTravel: Int!

    
    override func didMove(to view: SKView) {
        
        initializePicture()
        
        boostPanelSelected = true
        displayBoostItems()
        
        itemSelected.isHidden = true
        instruction.isHidden = true
        item_big.isHidden = true
        
    }
    
    func initializePicture() {
        
        // backgrounds
        background = self.childNode(withName: "background") as! SKSpriteNode
        itemSelected = self.childNode(withName: "ItemSelected") as! SKSpriteNode
        instruction = self.childNode(withName: "Instruction") as! SKSpriteNode
        boostBuyPanel = self.childNode(withName: "BuyPanel") as! SKSpriteNode
        item_big = self.childNode(withName: "Item_big") as! SKSpriteNode
        
        // boost items
        autoFlying =  self.childNode(withName: "AutoFlying") as! SKSpriteNode
        bubbleShield =  self.childNode(withName: "BubbleShield") as! SKSpriteNode
        slipperyLotion =  self.childNode(withName: "SlipperyLotion") as! SKSpriteNode
        fluufyTail =  self.childNode(withName: "FluufyTail") as! SKSpriteNode
        badassPaw =  self.childNode(withName: "BadassPaw") as! SKSpriteNode
        awesomeSticker =  self.childNode(withName: "AwesomeSticker") as! SKSpriteNode
        instantFish =  self.childNode(withName: "InstantFish") as! SKSpriteNode
        randomBox =  self.childNode(withName: "RandomBox") as! SKSpriteNode
        
    }
    
    func displayBoostItems() {
        

        autoFlying.isHidden = false
        bubbleShield.isHidden = false
        slipperyLotion.isHidden = false
        fluufyTail.isHidden = false
        badassPaw.isHidden = false
        awesomeSticker.isHidden = false
        instantFish.isHidden = false
        randomBox.isHidden = false
        
        
    }
    
    func displayUpgradeItems() {
        
        autoFlying.isHidden = true
        bubbleShield.isHidden = true
        slipperyLotion.isHidden = true
        fluufyTail.isHidden = true
        badassPaw.isHidden = true
        awesomeSticker.isHidden = true
        instantFish.isHidden = true
        randomBox.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "BoooostBtn" {
                if !boostPanelSelected {
                    background.texture = SKTexture(imageNamed: "Boost Item Background")
                    boostBuyPanel.isHidden = false
                    boostPanelSelected = true
                    item_big.isHidden = true
                    
                    displayBoostItems()
                }
                
            }
            
            if touchedNode.name == "UpgradeBtn" {
                if boostPanelSelected {
                    background.texture = SKTexture(imageNamed: "Upgrade Item Background")
                    itemSelected.isHidden = true
                    instruction.isHidden = true
                    boostBuyPanel.isHidden = true
                    boostPanelSelected = false
                    item_big.isHidden = true
                    
                    displayUpgradeItems()
                }
            }
            
        
            if boostPanelSelected {
                if touchedNode.name == "AutoFlying" {
                    itemSelected.position = CGPoint(x: -457, y: 0)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "AutoFlying Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "AutoFlying_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "BubbleShield" {
                    itemSelected.position = CGPoint(x: -327, y: 0)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "BubbleShield Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "BubbleShield_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "SlipperyLotion" {
                    itemSelected.position = CGPoint(x: -193, y: 0)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "SlipperyLotion Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "SlipperyLotion_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "FluufyTail" {
                    itemSelected.position = CGPoint(x: -65, y: 0)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "FluufyTail Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "FluufyTail_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "BadassPaw" {
                    itemSelected.position = CGPoint(x: -457, y: -150)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "BadassPaw Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "BadassPaw_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "AwesomeSticker" {
                    itemSelected.position = CGPoint(x: -327, y: -150)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "AwesomeSticker Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "AwesomeSticker_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "InstantFish" {
                    itemSelected.position = CGPoint(x: -193, y: -150)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "InstantFish Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "InstantFish_big")
                    item_big.isHidden = false
                }
                
                if touchedNode.name == "RandomBox" {
                    itemSelected.position = CGPoint(x: -65, y: -150)
                    itemSelected.isHidden = false
                    instruction.texture = SKTexture(imageNamed: "RandomBox Inst")
                    instruction.isHidden = false
                    item_big.texture = SKTexture(imageNamed: "RandomBox_big")
                    item_big.isHidden = false
                }
            }
        
            
            if boostPanelSelected {
                if touchedNode.name == "BuyBtn" {
                    
                }
            }
            
            
            
            if touchedNode.name == "TravelBtn" {
                // go to level
                print("\(locationToTravel!)\(levelToTravel!)")
                let scene = GameplayScene(fileNamed: "\(locationToTravel!)\(levelToTravel!)")
                scene?.playerImage = "nameOfCat"
                scene?.nextLevel = self.levelToTravel
                scene?.currentLocation = self.locationToTravel
                scene!.scaleMode = .aspectFill

                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
            

        }
        
    }
    
}
