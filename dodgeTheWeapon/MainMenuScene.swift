//
//  MainMenuScene.swift
//  dodgeTheWeapon
//
//  Created by Kostic on 5/14/17.
//  Copyright © 2017 Kostic. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Play" {
                if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                }
            }
            
        }
    }
}
