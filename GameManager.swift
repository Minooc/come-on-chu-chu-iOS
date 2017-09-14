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
        return (self.gameData?.highScore)!
    }
    
    func setHighScore(highScore: Int32) {
        self.gameData?.highScore = highScore
    }
    
    func getTotalCoin() -> Int32 {
        return (self.gameData?.totalCoin)!
    }
    
    func setTotalCoin(totalCoin: Int32) {
        self.gameData?.totalCoin = totalCoin
    }
}
