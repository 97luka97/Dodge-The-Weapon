//
//  Player.swift
//  dodgeTheWeapon
//
//  Created by Kostic on 5/15/17.
//  Copyright © 2017 Kostic. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var minX = CGFloat(-200)
    var maxX = CGFloat(200)
    
    func initializePlayer() {
        name = "Player"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionDetection.PLAYER
        physicsBody?.contactTestBitMask = CollisionDetection.WEAPON
    }
    
    func move(left: Bool) {
        
        if left {
            
            texture = SKTexture(imageNamed: "playerLeft")
            position.x -= 10
            
            if position.x < minX {
                
                position.x = minX
            }
        } else {
            
            texture = SKTexture(imageNamed: "playerRight")
            position.x += 10
            
            if position.x > maxX {
                
                position.x = maxX
            }
            
        }
    }
    
}
