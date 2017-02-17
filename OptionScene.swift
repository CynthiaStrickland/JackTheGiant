//
//  OptionScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/15/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyBtn : SKSpriteNode?
    private var mediumBtn :SKSpriteNode?
    private var hardBtn :SKSpriteNode?
    
    private var sign : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
    }
    
    func initializeVariables() {
        //get reference to each variable
        
        easyBtn = self.childNode(withName: "Easy") as? SKSpriteNode
        mediumBtn = self.childNode(withName: "Medium") as? SKSpriteNode
        hardBtn = self.childNode(withName: "Hard") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            if nodes(at: location)[0].name == "Back" {
                let scene = MainMenu(fileNamed: "MainMenu");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.35));
            }
            
        }
        
    }
}
