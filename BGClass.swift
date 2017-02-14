//
//  BGClass.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/14/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3    // * 3 because three backgrounds
            
        }
    }
}
