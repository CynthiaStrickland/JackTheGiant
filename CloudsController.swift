//
//  CloudsController.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/14/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import SpriteKit

class CloudsController {

    var lastCloudPositionY = CGFloat()

    func shuffle(cloudsArray:[SKSpriteNode]) -> [SKSpriteNode] {
        /* This function takes and argument and returns a value.  It takes an array, cloudsArray, which is going to be a type of SpriteNodes.  It's going to return and array of SKSpriteNode.  
         
         Iterate through the array and count the items in the array and decrement it.   Swap does just that.  It just swaps the places of the arrays shuffledArray[i] and shuffledArray[j].    */
        
        var shuffledArray = cloudsArray
        
        for i in 0..<shuffledArray.count {
            let j = Int(arc4random_uniform(UInt32(shuffledArray.count - i))) + i;   //This gives a random number
            if i == j {continue}
            swap(&shuffledArray[i], &shuffledArray[j]);
        }
        
        return shuffledArray
    }
    
    func randomBetweenNumbers(firstNum:CGFloat, secondNum:CGFloat) -> CGFloat {
        
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
                    //Here you are doing some calculations and getting a randome number to be applied to the x-position
    }
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        
        for _ in 0...2 {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
                    //Adding names because they need to be removed for memory efficiency
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.xScale = 0.9
            cloud1.yScale = 0.9

            cloud2.xScale = 0.9
            cloud2.yScale = 0.9
            
            cloud3.xScale = 0.9
            cloud3.yScale = 0.9
            
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            //add Physics bodies to the clouds
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
            
            clouds = shuffle(cloudsArray: clouds)   //Shuffles the clouds
            
        }
        
        return clouds
    }
    
    func arrangeCloudsInScene(scene: SKScene, distaneBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, player: Player, initialClouds: Bool) {
    
        var clouds = createClouds()
        
        if initialClouds {
            while clouds[0].name == "Dark Cloud" {
            clouds = shuffle(cloudsArray: clouds);
            }
        }
        
        var positionY = CGFloat()
        
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
    
        var random = 0
    
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 10, secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 10, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            scene.addChild(clouds[i])
            positionY -= distaneBetweenClouds
            lastCloudPositionY = positionY
        }
        
    
    }
    
    
    
    
    
}
