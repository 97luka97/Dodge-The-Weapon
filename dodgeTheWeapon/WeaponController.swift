//
//  WeaponController.swift
//  dodgeTheWeapon
//
//  Created by Kostic on 5/15/17.
//  Copyright © 2017 Kostic. All rights reserved.
//

import SpriteKit

struct CollisionDetection {
    static let PLAYER: UInt32 = 0
    static let WEAPON: UInt32 = 1
}

class WeaponController {

    var minX = CGFloat(-200)
    var maxX = CGFloat(200)
    
    func spawnWeapons() -> SKSpriteNode {
        let weapon: SKSpriteNode?
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 5 {
            
            weapon = SKSpriteNode(imageNamed: "weapon1")
            weapon?.name = "weapon1"
            weapon?.setScale(0.6)
            weapon?.physicsBody = SKPhysicsBody(circleOfRadius: (weapon?.size.height)! / 2)
        } else {
            
            weapon = SKSpriteNode(imageNamed: "weapon2")
            weapon?.name = "weapon2"
            weapon?.setScale(0.6)
            weapon?.physicsBody = SKPhysicsBody(circleOfRadius: (weapon?.size.height)! / 2)
        }
        
        weapon?.physicsBody?.collisionBitMask = CollisionDetection.WEAPON
        weapon?.zPosition = 3
        weapon?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        weapon?.position.x = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        weapon?.position.y = 500
        
        return weapon!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
}
