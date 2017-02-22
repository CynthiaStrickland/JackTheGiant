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
    
    private var musicBtn: SKSpriteNode?;
    private var musicOn = SKTexture(imageNamed: "Music On Button");
    private var musicOff = SKTexture(imageNamed: "Music Off Button");
    
    override func didMove(to view: SKView) {
        GameManager.instance.initializeGameData()
        setMusic()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            if nodes(at: location)[0].name == "Start Game" {
                
                GameManager.instance.gameStartedFromMainMenu = true

                let scene = GameplayScene(fileNamed: "GameplayScene");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
            
            if nodes(at: location)[0].name == "Highscore" {
                let scene = HighscoreScene(fileNamed: "Highscore");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
            
            if nodes(at: location)[0].name == "Options" {
                let scene = OptionScene(fileNamed: "Options");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }

            if nodes(at: location)[0].name == "Music" {
                handleMusicButton();
            }
        } 
    }
    
    private func setMusic() {
        if GameManager.instance.getIsMusicOn() {
            if AudioManager.instance.isAudioPlayerInitialized() {
                AudioManager.instance.playBGMusic();
                musicBtn?.texture = musicOff;
            }
        }
    }
    
    private func handleMusicButton() {
        if GameManager.instance.getIsMusicOn() {
            AudioManager.instance.stopBGMusic();
            GameManager.instance.setIsMusicOn(false);
            musicBtn?.texture = musicOn;
        } else {
            AudioManager.instance.playBGMusic();
            GameManager.instance.setIsMusicOn(true);
            musicBtn?.texture = musicOff;
        }
        GameManager.instance.saveData();
    }
}
