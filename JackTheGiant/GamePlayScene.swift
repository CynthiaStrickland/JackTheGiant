//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/11/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

let cloudsController = CloudsController()

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var mainCamera: SKCameraNode?
    var player: Player?

    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var canMove = false
    var moveLeft = false
    var center: CGFloat?
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    var distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-157)
    let maxX = CGFloat(157)

    private var pausePanel: SKSpriteNode?
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 6
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.height)! / 2)
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 6
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitButton.name = "Quit"
        quitButton.zPosition = 6
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeButton)
        pausePanel?.addChild(quitButton)
        
        self.mainCamera?.addChild(pausePanel!) 
    }
    
    override func didMove(to view: SKView) {
        initializeVariables()
    }

    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
    }
    
    func beginContact(contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            //Play Sound
            
        
            //Increment the Score
            GamePlayController.instance.incrementLife()
            
            //Remove Life from Game
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            //Increment the Score
            GamePlayController.instance.incrementCoin()
            
            //Play Sound
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud"{
            secondBody.node?.removeFromParent()
            //Kill Player
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let location = touch.location(in: self)
            
            if self.scene?.isPaused == false {
                if location.x > center! {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                } else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            if nodes(at: location)[0].name == "Pause" {
                self.scene?.isPaused = true
                
                createPausePanel()
            }
            
            if nodes(at: location)[0].name == "Resume" {
                self.pausePanel?.removeFromParent()
                self.scene?.isPaused = false
            }
            
            if nodes(at: location)[0].name == "Quit" {
                let scene = MainMenu(fileNamed: "MainMenu");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.35));
            }
        }
        
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
        
    }
    
    func initializeVariables() {
        
        physicsWorld.contactDelegate = self
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player
        player?.initializePlayerAndAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackgrounds()
        getLabels()
        GamePlayController.instance.initializeVariables()
        
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distaneBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        print("The random number is \(cloudsController.randomBetweenNumbers(firstNum: 2, secondNum: 5))")
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        //PLAYER OUT OF SCENE 
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            self.scene?.isPaused = true
        }
        if (player?.position.y)! - (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            self.scene?.isPaused = true
        }
        
    }
    
    func moveCamera() {
        //self.mainCamera?.position.y = (self.mainCamera?.position.y)! - 3
        self.mainCamera?.position.y -= 3
        
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func createNewClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! - 400 {
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            cloudsController.arrangeCloudsInScene(scene: self, distaneBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: false)
            
            checkForChildsOffOfScreen()
        }
    }
    
    func checkForChildsOffOfScreen() {
        for child in children {
            
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                
                let childName = child.name?.components(separatedBy: " ")   //Creates an array
                if childName![0] != "BG" {
                    child.removeFromParent()
                }
            }
        }
        
        
    }
    
    func getLabels() {
        GamePlayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score Text") as? SKLabelNode
        GamePlayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as? SKLabelNode
        GamePlayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as? SKLabelNode
    }
}
