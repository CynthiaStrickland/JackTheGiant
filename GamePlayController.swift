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
    
    var score: Int?
    var coin: Int?
    var life: Int?
 
}
