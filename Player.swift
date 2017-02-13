//
//  Player.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/11/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func movePlayer(moveLeft: Bool) {
        
        
        if moveLeft {
            self.position.x = self.position.x - 7
            
        } else {
            self.position.x = self.position.x + 7

        }
        
    }
}
