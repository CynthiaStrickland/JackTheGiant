//
//  GameScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/9/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit
import GameplayKit

let myNode = SKSpriteNode(imageNamed: "Spaceship")

class GameScene: SKScene {
    override func didMove(to view: SKView) {
//        myNode.position = CGPoint(x: 0, y: 0)
//        myNode.setScale(0.5)
//        
//        self.addChild(myNode)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let myNode1 = SKSpriteNode(imageNamed: "Spaceship")
            myNode1.position = location
            myNode1.setScale(0.2)
            self.addChild(myNode1)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
        
            if atPoint(location).name == "Pause" {
            //   TODO:   Player touches Pause to make game pause.
            }
        }
    }
    
    
        //Called everytime before a frame is loaded
    override func update(_ currentTime: TimeInterval) {
        myNode.position.y += 1     // Moving node up 1 everytime it is called
    }
}
