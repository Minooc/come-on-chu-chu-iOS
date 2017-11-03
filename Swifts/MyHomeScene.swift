//
//  MyHome.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/18/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class MyHomeScene: SKScene {
    
    var designPanel: SKSpriteNode!
    var furniture: SKSpriteNode!
    var designFloor: SKSpriteNode!
    var itemEffect: SKSpriteNode!
    var designitem: SKSpriteNode!
    var exitDesign: SKSpriteNode!
    
    
    var customizingPanel: SKSpriteNode!
    var customizeBody: SKSpriteNode!
    var customizeSkin: SKSpriteNode!
    var customizeFace: SKSpriteNode!
    var useMyPicture: SKSpriteNode!
    var customizeCheckBtn: SKSpriteNode!
    var customizeExit: SKSpriteNode!
    
    
    var onDesignMode: Bool!
    var onCustomizingMode: Bool!
    
    var purchaseItemTable: UICollectionView!
    
    override func didMove(to view: SKView) {
        
        onDesignMode = false
        onCustomizingMode = false


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
            
            if touchedNode.name == "designhome" {
                createDesignPanel()
                

            }
            
            if touchedNode.name == "callmycat" {
                
            }
            
            if touchedNode.name == "customize" {
                createCustomizingPanel()
                
            }
            
            if touchedNode.name == "screenshot" {
                
            }
            
            
            // design mode
            
            if onDesignMode {
                

                
                if (touchedNode == exitDesign) {
                    
                    purchaseItemTable.removeFromSuperview()
                    designPanel.removeFromParent()
                    
                    
                    perform(#selector(designMode), with: nil, afterDelay: 0.1)
                }
                
            }
            
            // end of design mode
            
            if onCustomizingMode {
                
                if (touchedNode == customizeExit) {
                    
                    print("on customizing mode")
                    customizingPanel.removeFromParent()
                    
                    perform(#selector(customizingMode), with: nil, afterDelay: 0.1)
                }
            }
            
        }
    }
    
    func createDesignPanel() {
        
        designPanel = SKSpriteNode(imageNamed: "designhome_background")
        designPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
        designPanel.size = CGSize(width: 1337, height: 750)
        designPanel.xScale = 1
        designPanel.yScale = 1
        designPanel.zPosition = 5
        self.addChild(designPanel)
        
        furniture = SKSpriteNode(imageNamed: "designhome_furniture-crop")
        furniture?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        furniture?.position = CGPoint(x: -260, y: 135)
        furniture?.xScale = 1
        furniture?.yScale = 1
        furniture.size = CGSize(width: 253, height: 95)
        furniture?.zPosition = 6
        designPanel.addChild(furniture!)
        
        designFloor = SKSpriteNode(imageNamed: "designhome_floor-crop")
        designFloor?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        designFloor?.position = CGPoint(x: 5, y: 135)
        designFloor?.xScale = 1
        designFloor?.yScale = 1
        designFloor.size = CGSize(width: 253, height: 95)
        designFloor?.zPosition = 6
        designPanel.addChild(designFloor!)
        
        itemEffect = SKSpriteNode(imageNamed: "designhome_itemeffect-crop")
        itemEffect?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        itemEffect?.position = CGPoint(x: 270, y: 135)
        itemEffect?.xScale = 1
        itemEffect?.yScale = 1
        itemEffect.size = CGSize(width: 253, height: 95)
        itemEffect?.zPosition = 6
        designPanel.addChild(itemEffect!)
        
//        designitem = SKSpriteNode(imageNamed: "designhome_item-crop")
//        designitem?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        designitem?.position = CGPoint(x: -437, y: -132)
//        designitem?.xScale = 1
//        designitem?.yScale = 1
//        designitem.size = CGSize(width: 255.9, height: 400)
//        designitem?.zPosition = 6
//        designPanel.addChild(designitem!)
        
        exitDesign = SKSpriteNode(imageNamed: "designhome_exit-crop")
        exitDesign?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        exitDesign?.position = CGPoint(x: 573, y: 213)
        exitDesign?.xScale = 1
        exitDesign?.yScale = 1
        exitDesign.size = CGSize(width: 90, height: 90)
        exitDesign?.zPosition = 6
        designPanel.addChild(exitDesign!)
        
        print("on design mode")
        
        // Build a collection view of purchasable items
        purchaseItemTable = PurchaseItemTable(frame: CGRect(x:55,y:170,width:610,height:220), collectionViewLayout: UICollectionViewLayout())
        purchaseItemHandler()
        
        perform(#selector(designMode), with: nil, afterDelay: 0.1)
    }
    
    func designMode() {
        if (onDesignMode == false) {
            onDesignMode = true
        } else {
            onDesignMode = false
        }
    }
    
    func createCustomizingPanel() {
        
        customizingPanel = SKSpriteNode(imageNamed: "customizing_background")
        customizingPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
        customizingPanel.size = CGSize(width: 1337, height: 750)
        customizingPanel.xScale = 1
        customizingPanel.yScale = 1
        customizingPanel.zPosition = 5
        self.addChild(customizingPanel)
        

        customizeBody = SKSpriteNode(imageNamed: "customizing_body")
        customizeBody?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customizeBody?.position = CGPoint(x: -407, y: 83.8)
        customizeBody?.xScale = 1
        customizeBody?.yScale = 1
        customizeBody.size = CGSize(width: 250, height: 92)
        customizeBody?.zPosition = 6
        customizingPanel.addChild(customizeBody!)
        
        customizeFace = SKSpriteNode(imageNamed: "customizing_face")
        customizeFace?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customizeFace?.position = CGPoint(x: -411, y: -127.3)
        customizeFace?.xScale = 1
        customizeFace?.yScale = 1
        customizeFace.size = CGSize(width: 248, height: 92)
        customizeFace?.zPosition = 6
        customizingPanel.addChild(customizeFace!)
        
        customizeSkin = SKSpriteNode(imageNamed: "customizing_skin")
        customizeSkin?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customizeSkin?.position = CGPoint(x: -411, y: -23.9)
        customizeSkin?.xScale = 1
        customizeSkin?.yScale = 1
        customizeSkin.size = CGSize(width: 248, height: 92)
        customizeSkin?.zPosition = 6
        customizingPanel.addChild(customizeSkin!)
        
        useMyPicture = SKSpriteNode(imageNamed: "customizing_usemypicture")
        useMyPicture?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        useMyPicture?.position = CGPoint(x: -410, y: -231.978)
        useMyPicture?.xScale = 1
        useMyPicture?.yScale = 1
        useMyPicture.size = CGSize(width: 255, height: 92)
        useMyPicture?.zPosition = 6
        customizingPanel.addChild(useMyPicture!)
        
        customizeCheckBtn = SKSpriteNode(imageNamed: "customizing_checkBtn-crop")
        customizeCheckBtn?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customizeCheckBtn?.position = CGPoint(x: 484.8, y: 212.4)
        customizeCheckBtn?.xScale = 1
        customizeCheckBtn?.yScale = 1
        customizeCheckBtn.size = CGSize(width: 85, height: 85)
        customizeCheckBtn?.zPosition = 6
        customizingPanel.addChild(customizeCheckBtn!)
        
        customizeExit = SKSpriteNode(imageNamed: "customizing_exit-crop")
        customizeExit?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customizeExit?.position = CGPoint(x: 577.2, y: 213)
        customizeExit?.xScale = 1
        customizeExit?.yScale = 1
        customizeExit.size = CGSize(width: 85, height: 85)
        customizeExit?.zPosition = 6
        customizingPanel.addChild(customizeExit!)
        
        perform(#selector(customizingMode), with: nil, afterDelay: 0.1)
    }
    
    func customizingMode() {
        if (onCustomizingMode == false) {
            onCustomizingMode = true
        } else {
            onCustomizingMode = false
        }
    }
    
    func purchaseItemHandler() {
        
        print("building purchase item table")
        
        //purchaseItemTable.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Item")
        purchaseItemTable.backgroundColor = UIColor.clear
        self.scene?.view?.addSubview(purchaseItemTable)
        
        purchaseItemTable.reloadData()
 
    }
    
    
    
}
