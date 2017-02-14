//
//  Player.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/11/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

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
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
    }
    
    func animatePlayer() {
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation() {
            self.removeAction(forKey: "Animate")
    }
    
    func movePlayer(moveLeft: Bool) {
        
        
        if moveLeft {
            self.position.x = self.position.x - 7
            
        } else {
            self.position.x = self.position.x + 7

        }
        
    }
}
