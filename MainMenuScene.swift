//
//  MainMenuScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/15/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var highscoreBtn: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        highscoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode!
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            if nodes(at: location)[0].name == "Highscore" {
                print("Button is Pressed")
                
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                
            }
        }
    }
}
