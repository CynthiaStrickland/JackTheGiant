//
//  Player.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/11/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

struct ColliderType {
    
    static let player: UInt32 = 0
    static let cloud: UInt32 = 1
    static let darkCloudAndCollectables: UInt32 = 2
    //Going to use these for our masks for physics bodies
    
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initializePlayerAndAnimations() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = ColliderType.player
        self.physicsBody?.collisionBitMask = ColliderType.cloud
        self.physicsBody?.contactTestBitMask = ColliderType.darkCloudAndCollectables
        
        animatePlayerAction = SKAction.animate(with: playerAnimation,
                                               timePerFrame: 0.08,
                                               resize: true,
                                               restore: false)
        
    }
    
    func animatePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
        
    }
    
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
        
    }
    
    func movePlayer(moveLeft: Bool) {
        
        
        if moveLeft {
            //self.position.x = self.position.x - 7
            self.position.x -= 7
            
        } else {
            //self.position.x = self.position.x + 7
            self.position.x += 7

        }
        
    }
}
