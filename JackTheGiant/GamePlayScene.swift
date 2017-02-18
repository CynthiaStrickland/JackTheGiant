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
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    var distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-157)
    let maxX = CGFloat(157)

    private var pausePanel: SKSpriteNode?
    
    private let playerMinX = CGFloat(-214)
    private let playerMaxX = CGFloat(214)
    
    override func didMove(to view: SKView) {
        initializeVariables()
        setCameraSpeed()        
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
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
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
                //****Play Sound
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false));
                //****Increment The Score
            GamePlayController.instance.incrementLife();
                //****Remove Life from Game
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false));
            GamePlayController.instance.incrementCoin();
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud"{
            if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
                
                self.scene?.isPaused = true;
                
                GamePlayController.instance.life -= 1;
                
                if GamePlayController.instance.life >= 0 {
                    GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life)"
                } else {
                    createEndScorePanel()
                }
                
                firstBody.node?.removeFromParent();
                
                Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false);
            }
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
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        
        //PLAYER OUT OF SCENE
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
        
        if (player?.position.x)! < playerMinX {
            player?.position.x = playerMinX
        }
        
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            self.scene?.isPaused = true
        }
        if (player?.position.y)! - (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            self.scene?.isPaused = true
        }
        
        if player!.position.y - player!.size.height * 3.7 > mainCamera!.position.y {
            self.scene?.isPaused = true;
            
            GamePlayController.instance.life -= 1;
            
            if GamePlayController.instance.life >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life)"
            } else {
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false);
        }
        
        if player!.position.y + player!.size.height * 3.7 < mainCamera!.position.y {
            self.scene?.isPaused = true;
            
            GamePlayController.instance.life -= 1;
            
            if GamePlayController.instance.life >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life)"
            } else {
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false);
        }
        
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func moveCamera() {
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        self.mainCamera?.position.y -= 3
    }
    
    func getLabels() {
        GamePlayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score Text") as? SKLabelNode
        GamePlayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as? SKLabelNode
        GamePlayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as? SKLabelNode
    }
    
    func createNewClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
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

    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty(){
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        } else if GameManager.instance.getMediumDifficulty(){
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        } else if GameManager.instance.getHardDifficulty(){
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
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
    
    private func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score");
        let scoreLabel = SKLabelNode(fontNamed: "Blow");
        let coinLabel = SKLabelNode(fontNamed: "Blow");
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        endScorePanel.zPosition = 8;
        endScorePanel.xScale = 1.5;
        endScorePanel.yScale = 1.5;
        
        scoreLabel.text = "x\(GamePlayController.instance.score)"
        coinLabel.text = "x\(GamePlayController.instance.coin)"
        
        endScorePanel.addChild(scoreLabel);
        endScorePanel.addChild(coinLabel);
        
        scoreLabel.fontSize = 50;
        scoreLabel.zPosition = 7;
        
        coinLabel.fontSize = 50;
        coinLabel.zPosition = 7;
        
        endScorePanel.position = CGPoint(x: mainCamera!.frame.size.width / 2, y: mainCamera!.frame.size.height / 2);
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10);
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y - 105);
        
        mainCamera?.addChild(endScorePanel);
        
    }
    
    @objc
    private func playerDied() {
        if GamePlayController.instance.life >= 0 {
            GameManager.instance.gameRestartedPlayerDied = true;
            
            let scene = GameplayScene(fileNamed: "GameplayScene");
            scene?.scaleMode = SKSceneScaleMode.aspectFill;
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
        } else {
            if GameManager.instance.getEasyDifficulty() {
                let highscore = GameManager.instance.getEasyDifficultyScore();
                let coinScore = GameManager.instance.getEasyDifficultyCoinScore();
                
                if highscore < Int32(GamePlayController.instance.score) {
                    GameManager.instance.setEasyDifficultyScore(Int32(GamePlayController.instance.score));
                }
                
                if coinScore < Int32(GamePlayController.instance.coin) {
                    GameManager.instance.setEasyDifficultyCoinScore(Int32(GamePlayController.instance.coin));
                }
                
            } else if GameManager.instance.getMediumDifficulty() {
                let highscore = GameManager.instance.getMediumDifficultyScore();
                let coinScore = GameManager.instance.getMediumDifficultyCoinScore();
                
                if highscore < Int32(GamePlayController.instance.score) {
                    GameManager.instance.setMediumDifficultyScore(Int32(GamePlayController.instance.score));
                }
                
                if coinScore < Int32(GamePlayController.instance.coin) {
                    GameManager.instance.setMediumDifficultyCoinScore(Int32(GamePlayController.instance.coin));
                }
                
            } else if GameManager.instance.getHardDifficulty() {
                let highscore = GameManager.instance.getHardDifficultyScore();
                let coinScore = GameManager.instance.getHardDifficultyCoinScore();
                
                if highscore < Int32(GamePlayController.instance.score) {
                    GameManager.instance.setHardDifficultyScore(Int32(GamePlayController.instance.score));
                }
                
                if coinScore < Int32(GamePlayController.instance.coin) {
                    GameManager.instance.setHardDifficultyCoinScore(Int32(GamePlayController.instance.coin));
                }
                
            }
            
            GameManager.instance.saveData();
            
            let scene = MainMenu(fileNamed: "MainMenu");
            scene?.scaleMode = SKSceneScaleMode.aspectFill;
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
        }
    }
}




















