//
//  MainMenuScene.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//
import SpriteKit

class MainMenuScene: SKScene {
    
    var settingPanel: SKSpriteNode!
    var settingSquare: SKShapeNode!

    var soundsBox: SKSpriteNode!
    var musicBox: SKSpriteNode!
    var notificationBox: SKSpriteNode!
    var facebookBtn: SKSpriteNode!

    var soundsCheck: SKSpriteNode?
    var musicCheck: SKSpriteNode?
    var notificationCheck: SKSpriteNode?


    var meowshopPanel: SKSpriteNode!
    var specialPackage: SKSpriteNode!
    var ultraBooster: SKSpriteNode!
    var canAndCoin: SKSpriteNode!
    var exitShop: SKSpriteNode!

    var onSetting: Bool?
    var onMeowshop: Bool?

//    var meowshopTable: UICollectionView!
    var meowshopTable: MeowshopTable!
    
    
    override func didMove(to view: SKView) {
        
        GameManager.instance.initializeGame()
        self.scene?.isPaused = false
        
        dailyGiftHandler()
        getLabel()
        
        onSetting = false
        onMeowshop = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            
            if touchedNode.name == "Setting" {
                createSettingPanel()
            }
            
            /*
             if let nameOfCat = touchedNode.name {
             
             let scene = GameplayScene(fileNamed: "Egypt1")
             scene?.playerImage = nameOfCat
             scene!.scaleMode = .aspectFill
             
             self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
             }
             */
            
            if touchedNode.name == "CollectionBtn" {
                let scene = CollectionScene(fileNamed: "CollectionScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
            }
            
            if touchedNode.name == "mapBtn" {
                let scene = MapScene(fileNamed: "MapScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
            if touchedNode.name == "homeBtn" {
                let scene = MyHomeScene(fileNamed: "MyHomeScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
            if touchedNode.name == "Meowshop" {
                createMeowshopPanel()
            }
            
            // on Setting
            
            if onSetting == true {
                
                if touchedNode == settingSquare {
                    
                }
                    
                else if touchedNode == facebookBtn {
                    
                }
                    
                else if touchedNode == soundsBox || touchedNode == soundsCheck {
                    
                    if (GameManager.instance.getSoundEffect() == false) {
                        soundsCheck?.isHidden = false
                        GameManager.instance.shuffleSoundEffect()
                    } else {
                        soundsCheck?.isHidden = true
                        GameManager.instance.shuffleSoundEffect()
                    }
                    
                }
                    
                else if touchedNode == musicBox || touchedNode == musicCheck {
                    
                    if (GameManager.instance.getBGM() == false) {
                        musicCheck?.isHidden = false
                        GameManager.instance.shuffleBGM()
                    } else {
                        musicCheck?.isHidden = true
                        GameManager.instance.shuffleBGM()
                    }
                    
                }
                    
                else if touchedNode == notificationBox || touchedNode == notificationCheck {
                    
                    if (GameManager.instance.getNotification() == false) {
                        notificationCheck?.isHidden = false
                        GameManager.instance.shuffleNotification()
                    } else {
                        notificationCheck?.isHidden = true
                        GameManager.instance.shuffleNotification()
                    }
                    
                }
                    
                else {
                    settingSquare.removeFromParent()
                    settingPanel.removeFromParent()
                    
                    perform(#selector(settingMode), with: nil, afterDelay: 0.1)
                }
                
                GameManager.instance.saveData()
                
                
            }
            
            // end of Setting
            
            
            
            if onMeowshop == true {
                
                if (touchedNode == exitShop) {
                    
                    meowshopTable.removeFromSuperview()
                    meowshopPanel.removeFromParent()
                    perform(#selector(meowshopMode), with: nil, afterDelay: 0.1)
                }
                
                if (touchedNode == ultraBooster) {
                    
                    meowshopTable.category = "ultra-booster"
                    meowshopTable.reloadData()
                }
                
                if (touchedNode == canAndCoin) {
                    
                    meowshopTable.category = "can-and-coin"
                    meowshopTable.reloadData()
                }
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
        
        //        let gift = self.childNode(withName: "giftLabel") as? SKLabelNode
        //        gift?.text = todayOfWeek
        
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
    
    func createSettingPanel() {
        print("Making Pannel")


        settingPanel = SKSpriteNode(imageNamed: "default setting screen")
        settingPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
        settingPanel.xScale = 1
        settingPanel.yScale = 1
        settingPanel.zPosition = 5
        self.addChild(settingPanel)

        settingSquare = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
        settingSquare.position = CGPoint(x: 13, y: -25)
        settingSquare.xScale = 10
        settingSquare.yScale = 6
        settingSquare.zPosition = 6
        settingSquare.lineWidth = 0
        self.addChild(settingSquare)

        facebookBtn = SKSpriteNode(imageNamed: "facebookBtn")
        facebookBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        facebookBtn.xScale = 1
        facebookBtn.yScale = 1
        facebookBtn.zPosition = 6
        facebookBtn.position = CGPoint(x: 193, y: 67)
        settingPanel.addChild(facebookBtn)

        soundsBox = SKSpriteNode(imageNamed: "selectionBox")
        soundsBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        soundsBox.xScale = 1
        soundsBox.yScale = 1
        soundsBox.zPosition = 6
        soundsBox.position = CGPoint(x: 200, y: 0)
        settingPanel.addChild(soundsBox)

        musicBox = SKSpriteNode(imageNamed: "selectionBox")
        musicBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicBox.xScale = 1
        musicBox.yScale = 1
        musicBox.zPosition = 6
        musicBox.position = CGPoint(x: 200, y: -65)
        settingPanel.addChild(musicBox)

        notificationBox = SKSpriteNode(imageNamed: "selectionBox")
        notificationBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        notificationBox.xScale = 1
        notificationBox.yScale = 1
        notificationBox.zPosition = 6
        notificationBox.position = CGPoint(x: 200, y: -130)
        settingPanel.addChild(notificationBox)


        soundsCheck = SKSpriteNode(imageNamed: "check sign")
        soundsCheck?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        soundsCheck?.xScale = 1
        soundsCheck?.yScale = 1
        soundsCheck?.zPosition = 6
        soundsCheck?.position.y += 10
        soundsBox.addChild(soundsCheck!)

        musicCheck = SKSpriteNode(imageNamed: "check sign")
        musicCheck?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicCheck?.xScale = 1
        musicCheck?.yScale = 1
        musicCheck?.zPosition = 6
        musicCheck?.position.y += 10
        musicBox.addChild(musicCheck!)

        notificationCheck = SKSpriteNode(imageNamed: "check sign")
        notificationCheck?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        notificationCheck?.xScale = 1
        notificationCheck?.yScale = 1
        notificationCheck?.zPosition = 6
        notificationCheck?.position.y += 10
        notificationBox.addChild(notificationCheck!)

        if (GameManager.instance.getSoundEffect() == false) {
            soundsCheck?.isHidden = true
        } else {
            soundsCheck?.isHidden = false
        }

        if (GameManager.instance.getBGM() == false) {
            musicCheck?.isHidden = true
        } else {
            musicCheck?.isHidden = false
        }

        if (GameManager.instance.getNotification() == false) {
            notificationCheck?.isHidden = true
        } else {
            notificationCheck?.isHidden = false
        }

        perform(#selector(settingMode), with: nil, afterDelay: 0.1)

    }

    func createMeowshopPanel() {

        meowshopPanel = SKSpriteNode(imageNamed: "Meowshop-Background")
        meowshopPanel.anchorPoint = CGPoint(x: 0.5, y:0.5)
        meowshopPanel.size = CGSize(width: 1337, height: 750)
        meowshopPanel.xScale = 1
        meowshopPanel.yScale = 1
        meowshopPanel.zPosition = 5
        self.addChild(meowshopPanel)

        specialPackage = SKSpriteNode(imageNamed: "meowshop-special")
        specialPackage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        specialPackage?.position = CGPoint(x: -260, y: 135)
        specialPackage?.xScale = 1
        specialPackage?.yScale = 1
        specialPackage.size = CGSize(width: 253, height: 95)
        specialPackage?.zPosition = 6
        meowshopPanel.addChild(specialPackage!)

        ultraBooster = SKSpriteNode(imageNamed: "meowshop-booster")
        ultraBooster?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ultraBooster?.position = CGPoint(x: 5, y: 147)
        ultraBooster?.xScale = 1
        ultraBooster?.yScale = 1
        ultraBooster.size = CGSize(width: 253, height: 115)
        ultraBooster?.zPosition = 6
        meowshopPanel.addChild(ultraBooster!)

        canAndCoin = SKSpriteNode(imageNamed: "meowshop-CanAndCoin")
        canAndCoin?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        canAndCoin?.position = CGPoint(x: 270, y: 135)
        canAndCoin?.xScale = 1
        canAndCoin?.yScale = 1
        canAndCoin.size = CGSize(width: 253, height: 95)
        canAndCoin?.zPosition = 6
        meowshopPanel.addChild(canAndCoin!)

        //        designitem = SKSpriteNode(imageNamed: "designhome_item-crop")
        //        designitem?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //        designitem?.position = CGPoint(x: -437, y: -132)
        //        designitem?.xScale = 1
        //        designitem?.yScale = 1
        //        designitem.size = CGSize(width: 255.9, height: 400)
        //        designitem?.zPosition = 6
        //        designPanel.addChild(designitem!)

        exitShop = SKSpriteNode(imageNamed: "meowshop-exit")
        exitShop?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        exitShop?.position = CGPoint(x: 573, y: 213)
        exitShop?.xScale = 1
        exitShop?.yScale = 1
        exitShop.size = CGSize(width: 90, height: 90)
        exitShop?.zPosition = 6
        meowshopPanel.addChild(exitShop!)

        print("on shop mode")

        // Build a collection view of purchasable items
//        purchaseItemTable = PurchaseItemTable(frame: CGRect(x:55,y:170,width:610,height:220), collectionViewLayout: UICollectionViewLayout())
//        purchaseItemHandler()

        meowshopTable = MeowshopTable(frame: CGRect(x:55,y:170,width:610,height:230), collectionViewLayout: UICollectionViewLayout())
        meowshopHandler()

         perform(#selector(meowshopMode), with: nil, afterDelay: 0.1)
    }

    func settingMode() {
        if (onSetting == false) {
            onSetting = true
        } else {
            onSetting = false
        }
    }

    func meowshopMode() {
        if (onMeowshop == false) {
            onMeowshop = true
        } else {
            onMeowshop = false
        }
    }

    func meowshopHandler() {


        //purchaseItemTable.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Item")
        meowshopTable.backgroundColor = UIColor.clear
        self.scene?.view?.addSubview(meowshopTable)

        meowshopTable.reloadData()

    }
    
}
