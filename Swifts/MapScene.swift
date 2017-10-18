//
//  MapSelectScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/24/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

struct MapName {
    static let Meoul = "Meoul"
    static let Parismiao = "Parismiao"
    static let Meowjing = "Meowjing"
    static let Moscyau = "Moscyau"
    static let Londonya = "Londonya"
    static let Romya = "Romya"
    static let Losangelnya = "Losangelnya"
    static let Berinya = "Berinya"
    static let Brazilinya = "Brazilinya"
    static let Ny = "Ny"
    static let Cairong = "Cairong"
    static let Meowcouver = "Meowcouver"
    static let Barcelonau = "Barcelonau"
}

class MapScene: SKScene {
    
    var cities = ["Meoul", "Parismiao", "Meowjing", "Moscyau", "Londonya", "Romya", "Losangelnya", "Berinya", "Brazilinya", "Ny", "Cairong", "Meowcouver", "Barcelonau"]
    
    var mapDictionary = [String: Bool]()
    
    var onOpenPanel: Bool!
    var travelBtn: SKShapeNode!
    var cancelBtn: SKShapeNode!
    var selectionPanel: SKSpriteNode!
    
    var mapToOpen: String!
    var amountToTravel: Int32!
    
    var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        onOpenPanel = false
        mapToOpen = ""
        amountToTravel = 0
        
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        for city in cities {
            initializeMapColor(city: city)
            
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
          
            if (touchedNode == background) {
 
                let previousLocation: CGPoint = touch.previousLocation(in: self)
                let ydiff: CGFloat =  previousLocation.y - location.y
                let xdiff: CGFloat = previousLocation.x - location.x
                var newPosition: CGPoint = CGPoint(x: background.position.x - xdiff, y:  background.position.y - ydiff)
                
                
                if (newPosition.x > 576.7) {
                    newPosition.x = 576.7
                }
                if (newPosition.x < -573.6) {
                    newPosition.x = -573.6
                }
                
                if (newPosition.y < -324.8) {
                    newPosition.y = -324.8
                }
                
                if (newPosition.y > 326.0) {
                    newPosition.y = 326.0
                }
                
                background.position = newPosition
                
            }
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            
            if touchedNode.name != nil && touchedNode.name?.range(of: "Btn") != nil {
                
                
                var selectedMap = touchedNode.name
                selectedMap = selectedMap?.replacingOccurrences(of: "Btn", with: "", options: .regularExpression)
                
                if let selectedMapToOpen = selectedMap {
                    print(selectedMapToOpen)
                    mapOpenHandler(mapToOpenPar: selectedMapToOpen)
                }
            }
            
            if touchedNode.name == "backToMenu" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
            
            
            if onOpenPanel {
                if touchedNode == travelBtn {
                    openMap()
                    
                    selectionPanel.removeFromParent()
                    perform(#selector(openMode), with: nil, afterDelay: 0.1)
                }
                
                if touchedNode == cancelBtn {
                    
                    selectionPanel.removeFromParent()
                    perform(#selector(openMode), with: nil, afterDelay: 0.1)
                    
                }

            }
        }
        
    }
    
    func initializeMapColor(city: String) {
        
        let thisNode: SKSpriteNode!
        thisNode = background.childNode(withName: city) as! SKSpriteNode
        
        if (GameManager.instance.getMapStatus(mapToOpen: city) == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot")
        }
       
        thisNode.zPosition = 1
    }
    
    func mapOpenHandler(mapToOpenPar: String) {
        
        if GameManager.instance.getMapStatus(mapToOpen: mapToOpenPar) == false {
        
            
            // Make Map Selection Panel
            selectionPanel = SKSpriteNode(imageNamed: "MapSelection")
            selectionPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
            selectionPanel.xScale = 1
            selectionPanel.yScale = 1
            selectionPanel.zPosition = 5
            self.addChild(selectionPanel)
            
            travelBtn = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
            travelBtn.position = CGPoint(x: -137, y: -145)
            travelBtn.xScale = 2.5
            travelBtn.yScale = 1
            travelBtn.zPosition = 6
            travelBtn.lineWidth = 0
            selectionPanel.addChild(travelBtn)
            
            cancelBtn = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
            cancelBtn.position = CGPoint(x: 178, y: -145)
            cancelBtn.xScale = 2.5
            cancelBtn.yScale = 1
            cancelBtn.zPosition = 6
            cancelBtn.lineWidth = 0
            selectionPanel.addChild(cancelBtn)
            
            print("We're opening \(mapToOpenPar)")
            let priceLbl = SKLabelNode(fontNamed: "Conformity")
            if (mapToOpenPar == "Brazilinya" || mapToOpenPar == "Losangelnya" || mapToOpenPar == "Meowcouver" || mapToOpenPar == "Ny" || mapToOpenPar == "Parismiao") {
                priceLbl.text = "2000"
                amountToTravel = 2000
            } else if (mapToOpenPar == "Berinya" || mapToOpenPar == "Meoul" || mapToOpenPar == "Barcelonau" || mapToOpenPar == "Romya") {
                priceLbl.text = "2800"
                amountToTravel = 2800
            } else if (mapToOpenPar == "Moscyau" || mapToOpenPar == "Cairong" || mapToOpenPar == "Meowjing" || mapToOpenPar == "Londonya") {
                priceLbl.text = "3600"
                amountToTravel = 3600
            }

            priceLbl.fontColor = UIColor(red: 246/255, green: 91/255, blue: 139/255, alpha: 1.0)
            priceLbl.fontSize = 24
            priceLbl.position = CGPoint(x: 43, y: 56)
            priceLbl.zPosition = 6
            selectionPanel.addChild(priceLbl)
            
            
            self.mapToOpen = mapToOpenPar
            
            perform(#selector(openMode), with: nil, afterDelay: 0.1)
            
            
            
        } else {
         
            // go to level select scene
            let scene = LevelSelectScene(fileNamed: "LevelSelectScene")
            scene?.selectedMap = mapToOpen
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            
        }
        

        

    }
    
    func openMode() {
        if (onOpenPanel) {
            onOpenPanel = false
        } else {
            onOpenPanel = true
        }
    }
    
    func openMap() {
        
        let currentBalance = GameManager.instance.getTotalCoin()
    
        if amountToTravel <= currentBalance {
            
            GameManager.instance.setTotalCoin(totalCoin: currentBalance - amountToTravel)
            print("You have now \(GameManager.instance.getTotalCoin())")
        
            let openMark: SKSpriteNode!
            openMark = background.childNode(withName: mapToOpen) as! SKSpriteNode
            
            GameManager.instance.openMap(mapToOpen: mapToOpen)
            
            openMark.texture = SKTexture(imageNamed: "redfoot")
            openMark.zPosition = 1
            
            GameManager.instance.saveData()
        } else {
            print("Not enough money. You have \(currentBalance)")
        }
        
        mapToOpen = ""
        amountToTravel = 0

    }
    

}
