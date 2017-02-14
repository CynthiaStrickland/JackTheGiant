//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/11/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

let cloudsController = CloudsController()

class GameplayScene: SKScene {
    
    var mainCamera: SKCameraNode?
    var player: Player?

    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    var distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(85)
    let maxX = CGFloat(392)

    
    override func didMove(to view: SKView) {
        initializeVariables()
        
    }

    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
        
    }
    
    func initializeVariables() {
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player
        player?.initializePlayerAndAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackgrounds()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distaneBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: true)
        
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG1") as? BGClass!
        bg2 = self.childNode(withName: "BG2") as? BGClass!
        bg3 = self.childNode(withName: "BG3") as? BGClass!

        
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
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
}
