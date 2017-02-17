//
//  GamePlayController.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/17/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit


class GamePlayController {
    
    /* This is creating a singleton.   The private init makes sure no other class can create another object for this class. Lecture 53  */
    static let instance = GamePlayController()
    private init () {}
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int = 0
    var coin: Int = 0
    var life: Int = 0
 
    func initializeVariables() {
        if GameManager.instance.gameStartedFromMainMenu {
            
            GameManager.instance.gameStartedFromMainMenu = false
            
            score = -1
            coin = 0
            life = 2
            
            scoreText?.text = "\(String(describing: score))"
            coinText?.text = "x\(String(describing: coin))"
            lifeText?.text = "x\(String(describing: life))"
            
        } else if GameManager.instance.gameRestartedPlayerDied {
            
            GameManager.instance.gameRestartedPlayerDied = false
            
            scoreText?.text = "\(String(describing: score))"
            coinText?.text = "x\(String(describing: coin))"
            lifeText?.text = "x\(String(describing: life))"
        }
    }
    
    func incrementScore() {
        score += 1
        scoreText?.text = "\(String(describing: score))"
    }
    
    func incrementCoin() {
        coin += 1
        score += 200
        scoreText?.text = "\(score)"
        coinText?.text = "x\(coin)"
    }
    
    func incrementLife() {
        life += 1
        score += 300
        scoreText?.text = "\(score)"
        lifeText?.text = "x\(life)"
    }
}
