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
        GameManager.instance.initializeGame()
        
        getLabel()
        
        dailyGiftHandler()
        

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
    
    func dailyGiftHandler() {
        let date = Date()
        let calendar = Calendar.current
        
        var todayOfWeek: String!
        
        switch (calendar.component(.weekday, from: date)) {
            case 1: todayOfWeek = "Sunday"
            case 2: todayOfWeek = "Monday"
            case 3: todayOfWeek = "Tuesday"
            case 4: todayOfWeek = "Wednesday"
            case 5: todayOfWeek = "Thursday"
            case 6: todayOfWeek = "Friday"
            case 7: todayOfWeek = "Saturday"
            default: break
        }
        
        let gift = self.childNode(withName: "giftLabel") as? SKLabelNode
        gift?.text = todayOfWeek
        
        let today = "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
        // handle daily gift
        
        if !GameManager.instance.getDailyCheck(today: today) {
            GameManager.instance.dailyCheck(today: today)
            
            if (todayOfWeek == "Sunday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 200)
                print("You got 200 coins!")

            } else if (todayOfWeek == "Monday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 100)
                print("You got 100 coins!")
            } else if (todayOfWeek == "Tuesday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 300)
                print("You got 300 coins!")
                
            } else if (todayOfWeek == "Wednesday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 150)
                print("You got 150 coins!")
                
            } else if (todayOfWeek == "Thursday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 160)
                print("You got 160 coins!")
                
            } else if (todayOfWeek == "Friday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 250)
                print("You got 250 coins!")
                
            } else if (todayOfWeek == "Saturday") {
                let currentCoin = GameManager.instance.getTotalCoin()
                GameManager.instance.setTotalCoin(totalCoin: currentCoin + 350)
                print("You got 350 coins!")
                
            }
            
            
            
            GameManager.instance.saveData()
        } 
        
        
    }
    
    func getLabel() {
        let scoreLabel = self.childNode(withName: "HighScore") as? SKLabelNode
        scoreLabel?.text = "\(GameManager.instance.getHighScore())"
        
        let coinLabel = self.childNode(withName: "TotalCoin") as? SKLabelNode
        coinLabel?.text = "\(GameManager.instance.getTotalCoin())"
    }
    
    
}
