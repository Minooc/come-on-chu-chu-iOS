//
//  GameplayController.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/14/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayController {
    
    static let instance = GameplayController()
    private init() {}
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    
    var score: Int32?
    var coin: Int32?
    
    func initializeVariables() {
        
        score = 0
        coin = 0
        
        scoreText?.text = "\(score!)"
        coinText?.text = "\(coin!)"
        
    }
    
    func incrementScore() {
        score! += 1
        scoreText?.text = "\(score!)"
    }
    
    func incrementCoin() {
        coin! += 1
        coinText?.text = "\(coin!)"
    }
    

    
    
}
