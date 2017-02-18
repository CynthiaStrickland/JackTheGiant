//
//  HighscoreScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/15/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var scoreLabel : SKLabelNode?
    private var coinLabel : SKLabelNode?
   
    
    override func didMove(to view: SKView) {
        getReference()
    }
    
    private func getReference() {
        scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode!
        coinLabel = self.childNode(withName: "Coin Label") as? SKLabelNode!
    }

    private func setScore() {
        if GameManager.instance.getEasyDifficulty() == true {
            scoreLabel?.text = "(\(GameManager.instance.getEasyDifficulty())"
            coinLabel?.text = "(\(GameManager.instance.getEasyDifficulty())"
        }
        else if GameManager.instance.getMediumDifficulty() == true{
            scoreLabel?.text = "(\(GameManager.instance.getMediumDifficulty())"
            coinLabel?.text = "(\(GameManager.instance.getMediumDifficulty())"
        }
        else if GameManager.instance.getHardDifficulty() == true {
            scoreLabel?.text = "(\(GameManager.instance.getHardDifficulty())"
            coinLabel?.text = "(\(GameManager.instance.getHardDifficulty())"
                }
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

