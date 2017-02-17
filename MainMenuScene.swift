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
    var optionBtn: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        highscoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode!
//        optionBtn = self.childNode(withName: "Option") as? SKSpriteNode!
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);

            if nodes(at: location)[0].name == "Highscore" {
                let scene = HighscoreScene(fileNamed: "Highscore");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                print("The Button is Pressed")
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
            
            if nodes(at: location)[0].name == "Options" {
                let scene = OptionScene(fileNamed: "Options");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                print("The Button is Pressed")
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
//
//            if nodes(at: location)[0].name == "Music" {
//                handleMusicButton();
//            }
//            
        }
        
    }
    
    func handleMusicButton() {
        
    }
    
    
    
    
    
    
}
