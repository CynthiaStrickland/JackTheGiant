//
//  GameScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/9/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let myNode = SKSpriteNode(imageNamed: "Spaceship")
        myNode.position = CGPoint(x: 0, y: 0)
        
         self.addChild(myNode)
        }
   }
