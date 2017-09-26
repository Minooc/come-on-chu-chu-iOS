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
    override func didMove(to view: SKView) {
        
        for city in cities {
            initializeMapColor(city: city)
            
        }
    
    }
    
    override func update(_ currentTime: TimeInterval) {
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
                    mapOpenHandler(mapToOpen: selectedMapToOpen)
                }
            }
            
            if touchedNode.name == "backToMenu" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
        }
        
    }
    
    func initializeMapColor(city: String) {
        
        let thisNode: SKSpriteNode!
        thisNode = self.childNode(withName: city) as! SKSpriteNode
        
        if (city == "Parismiao") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Parismiao") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot1")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot1")
        }
        }
        
        if (city == "Meowjing") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Meowjing") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot2")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot2")
        }
        }
        
        if (city == "Moscyau") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Moscyau") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot3")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot3")
        }
        }
        
        if (city == "Londonya") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Londonya") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot4")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot4")
        }
        }
        
        if (city == "Romya") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Romya") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot5")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot5")
        }
        }
        
        if (city == "Losangelnya") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Losangelnya") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot6")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot6")
        }
        }
        
        if (city == "Berinya") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Berinya") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot7")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot7")
        }
        }
        
        if (city == "Brazilinya") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Brazilinya") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot8")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot8")
        }
        }
        
        if (city == "Ny") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Ny") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot9")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot9")
        }
        }
        
        if (city == "Cairong") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Cairong") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot10")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot10")
        }
        }
        
        if (city == "Meoul") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Meoul") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot11")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot11")
        }
        }
        
        if (city == "Meowcouver") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Meowcouver") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot12")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot12")
        }
        }
        
        if (city == "Barcelonau") {
        if (GameManager.instance.getMapStatus(mapToOpen: "Barcelonau") == true) {
            thisNode.texture = SKTexture(imageNamed: "redfoot13")
        } else {
            thisNode.texture = SKTexture(imageNamed: "grayfoot13")
        }
        }
        thisNode.zPosition = 1
    }
    
    func mapOpenHandler(mapToOpen: String) {
        
        if GameManager.instance.getMapStatus(mapToOpen: mapToOpen) == false {
            print("It's not open. Do you want to open?")
            
            let openMark: SKSpriteNode!
            openMark = self.childNode(withName: mapToOpen) as! SKSpriteNode
            
            // for test: change image to red
            GameManager.instance.openMap(mapToOpen: mapToOpen)
            
            if (mapToOpen == "Parismiao") {
                openMark.texture = SKTexture(imageNamed: "redfoot1")
            } else if (mapToOpen == "Meowjing") {
                openMark.texture = SKTexture(imageNamed: "redfoot2")
            } else if (mapToOpen == "Moscyau") {
                openMark.texture = SKTexture(imageNamed: "redfoot3")
            } else if (mapToOpen == "Londonya") {
                openMark.texture = SKTexture(imageNamed: "redfoot4")
            } else if (mapToOpen == "Romya") {
                openMark.texture = SKTexture(imageNamed: "redfoot5")
            } else if (mapToOpen == "Losangelnya") {
                openMark.texture = SKTexture(imageNamed: "redfoot6")
            } else if (mapToOpen == "Berinya") {
                openMark.texture = SKTexture(imageNamed: "redfoot7")
            }else if (mapToOpen == "Brazilinya") {
                openMark.texture = SKTexture(imageNamed: "redfoot8")
            }else if (mapToOpen == "Ny") {
                openMark.texture = SKTexture(imageNamed: "redfoot9")
            } else if (mapToOpen == "Cairong") {
                openMark.texture = SKTexture(imageNamed: "redfoot10")
            } else if (mapToOpen == "Meoul") {
                openMark.texture = SKTexture(imageNamed: "redfoot11")
            } else if (mapToOpen == "Meowcouver") {
                openMark.texture = SKTexture(imageNamed: "redfoot12")
            } else if (mapToOpen == "Barcelonau") {
                openMark.texture = SKTexture(imageNamed: "redfoot13")
            }
            openMark.zPosition = 1
            
            GameManager.instance.saveData()
            
        } else {
         
            // go to level select scene
            let scene = LevelSelectScene(fileNamed: "LevelSelectScene")
            scene?.selectedMap = mapToOpen
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            
        }
        

        

    }
    

}
