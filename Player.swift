//
//  Player.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/12/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func movePlayer() {
        self.position.x += 7
    }
    
    func sinkPlayer() {
        self.position.y += 3
    }
    
    func floatPlayer() {
        self.position.y -= 3
    }
    
}
