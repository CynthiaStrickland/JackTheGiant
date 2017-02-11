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
let node2 = SKSpriteNode(imageNamed: "Spaceship")


class GameScene: SKScene {
    override func didMove(to view: SKView) {
        myNode.position = CGPoint(x: 0, y: 0)
        myNode.setScale(0.8)
        
        myNode.physicsBody = SKPhysicsBody(circleOfRadius: myNode.size.height/2)
        myNode.physicsBody?.affectedByGravity = false
        
        myNode.position = CGPoint(x: 0, y: 350)
        myNode.setScale(0.8)
        
        myNode.physicsBody = SKPhysicsBody(circleOfRadius: myNode.size.height/2)
        myNode.physicsBody?.affectedByGravity = true
        
        node2.position = CGPoint(x: 1, y: -150)
        node2.setScale(0.8)
        
        node2.physicsBody = SKPhysicsBody(circleOfRadius: myNode.size.height/2)
        node2.physicsBody?.affectedByGravity = false
        node2.physicsBody?.isDynamic = false
        
        self.addChild(myNode)
        self.addChild(node2)
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
//        myNode.position.y += 1     // Moving node up 1 everytime it is called
    }
}




//        myNode.alpha = 0
//        myNode.anchorPoint = CGPoint(x: 1, y: 1)   //Anchor point for rotation (1,1) top right corner (0,0) is bottom left

//        let action = SKAction.fadeIn(withDuration: TimeInterval(5))
//        let action = SKAction.moveTo(x: 100, duration: TimeInterval(2))
//        let action = SKAction.move(to: CGPoint(x: 100, y: 200), duration: TimeInterval(2))
//        let action = SKAction.rotate(byAngle: 2, duration: TimeInterval(2))
//        myNode.run(action)


/*  let label = SKLabelNode(fontNamed: "Helvetica")
    label.text "Player's Score"
    label.fontSize = 60
    label.fontColor = SKColor.redColor()
    label.position = (CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    self.addChiled(label)
 
    */

