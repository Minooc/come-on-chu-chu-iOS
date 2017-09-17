//
//  GameData.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/14/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        // we use keys to store values
        
        static let HighScore = "HighScore"
        static let TotalCoin = "TotalCoin"
    
        static let DailyGift = "DailyGift"
    
    }
    
    var highScore = Int32()
    var totalCoin = Int32()
    
    var dailyGift = [String: Bool]()

    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
         self.highScore = aDecoder.decodeCInt(forKey: Keys.HighScore)
         self.totalCoin = aDecoder.decodeCInt(forKey: Keys.TotalCoin)
        
        if let dict = aDecoder.decodeObject(forKey: Keys.DailyGift) as? [String: Bool] {
         self.dailyGift = dict
        }
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encodeCInt(self.highScore, forKey: Keys.HighScore)
        aCoder.encodeCInt(self.totalCoin, forKey: Keys.TotalCoin)
        
        aCoder.encode(self.dailyGift, forKey: Keys.DailyGift)
    }
    

    
}
