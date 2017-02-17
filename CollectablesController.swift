//
//  CollectablesController.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/17/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class CollectablesController {
    
    func randomBetweenNumbers(firstNum:CGFloat, secondNum:CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func getCollectable() -> SKSpriteNode {
    
        var collectable = SKSpriteNode()
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4 {
            if GamePlayController.instance.life! < 2 {
                collectable = SKSpriteNode.init(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            } else {
                collectable = SKSpriteNode(imageNamed: "Coin")
                collectable.name = "Coin"
                collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            }
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.darkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.player
        collectable.zPosition = 2
        
        return collectable
        }
    
    }

