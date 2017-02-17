//
//  CollectablesController.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/17/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class CollectablesController {
    
    func getCollectable() -> SKSpriteNode? {
    
        var collectable = SKSpriteNode?()
        
        return collectable
    }
    
    func randomBetweenNumbers(firstNum:CGFloat, secondNum:CGFloat) -> CGFloat {
        
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

