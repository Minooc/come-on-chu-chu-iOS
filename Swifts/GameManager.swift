//
//  GameManager.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/14/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import Foundation

class GameManager {
    static let instance = GameManager()
    private init() {}
    
    var gameData: GameData?
    
    func initializeGame() {
        
        if !FileManager.default.fileExists(atPath: getFilePath() as String) {

            gameData = GameData()
        
            gameData?.highScore = 0
            gameData?.totalCoin = 0
            
            gameData?.backgroundMusic = true
            gameData?.soundEffect = true
            gameData?.notification = true
            
            saveData()
        }
        
        loadData()
        
    }
    
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData
        
    }
    
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String)
        }
    }
    
    // where we want to save file
    private func getFilePath() -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return url!.appendingPathComponent("Game Manager").path
    }
    
    
    func getHighScore() -> Int32 {
        if (self.gameData?.highScore != nil) {
            return (self.gameData?.highScore)!
        } else {
            return 0
        }
    }
    
    func setHighScore(highScore: Int32) {
        self.gameData?.highScore = highScore
    }
    
    func getTotalCoin() -> Int32 {
        if (self.gameData?.totalCoin != nil) {
            return (self.gameData?.totalCoin)!
        } else {
            return 0
        }
    }
    
    func setTotalCoin(totalCoin: Int32) {
        self.gameData?.totalCoin = totalCoin
    }
    
    func dailyCheck(today: String) {
        self.gameData?.dailyGift[today] = true
    }
    
    func getDailyCheck(today: String) -> Bool {
        if let didGetGiftToday = self.gameData?.dailyGift[today] {
            return didGetGiftToday
        } else {
            return false
        }
    }
    
    func getBGM() -> Bool {
        if let backgroundMusic = self.gameData?.backgroundMusic {
            return backgroundMusic
        } else {
            return false
        }
    }
    
    func shuffleBGM() {
        if (getBGM() == true) {
            self.gameData?.backgroundMusic = false
        } else {
            self.gameData?.backgroundMusic = true
        }
    }
    
    func getSoundEffect() -> Bool {
        if let soundEffect = self.gameData?.soundEffect {
            return soundEffect
        } else {
            return false
        }
    }
    
    func shuffleSoundEffect() {
        if (getSoundEffect() == true) {
            self.gameData?.soundEffect = false
        } else {
            self.gameData?.soundEffect = true
        }
    }
    
    func getNotification() -> Bool {
        if let notification = self.gameData?.notification {
            return notification
        } else {
            return false
        }
    }
    
    func shuffleNotification() {
        if (getNotification() == true) {
            self.gameData?.notification = false
        } else {
            self.gameData?.notification = true
        }
    }
    
    
    func openMap(mapToOpen: String) {
        self.gameData?.mapDictionary[mapToOpen] = true
    }
    
    func closeMap(mapToOpen: String) {
        self.gameData?.mapDictionary[mapToOpen] = false
    }
    
    func getMapStatus(mapToOpen: String) -> Bool {
        if let didMapOpen = self.gameData?.mapDictionary[mapToOpen] {
            return didMapOpen
        } else {
            return false
        }
    }
}
