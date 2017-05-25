//
//  GameplaySceneClass.swift
//  dodgeTheWeapon
//
//  Created by Kostic on 5/15/17.
//  Copyright © 2017 Kostic. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    var soundPlayer: AVAudioPlayer?
    var player: Player?
    var center = CGFloat()
    var canMove = false
    var moveLeft = false
    var scoreLabel: SKLabelNode?
    var score = 0
    var timerForFuncCountMissedWeapons = Timer()
    var weaponController = WeaponController()
    
    override func didMove(to view: SKView) {
        startGame()
        
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if location.x > center {
                moveLeft = false
            } else {
                moveLeft = true
            }
        }
        
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && (secondBody.node?.name == "weapon1" || secondBody.node?.name == "weapon2") {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            playSound()
            timerForFuncCountMissedWeapons.invalidate()
            
            let showAlert = UIAlertController(title: "You lost!", message: "Score: \(score)", preferredStyle: UIAlertControllerStyle.alert)
            
            showAlert.addAction(UIAlertAction(title: "Menu", style: .default, handler: { (action: UIAlertAction!) in
                self.goToMainMenu()
            }))
            
            showAlert.addAction(UIAlertAction(title: "Play again", style: .default, handler: { (action: UIAlertAction!) in
                self.restartGame()
            }))
            
            
            self.view?.window?.rootViewController?.present(showAlert, animated: true, completion: nil)
            
            
        }
        
    }
    
    func startGame() {
        
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "Player") as? Player
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "Score") as? SKLabelNode
        scoreLabel?.text = "0"
        
        center = self.frame.size.width / self.frame.size.height
        
        Timer.scheduledTimer(timeInterval: TimeInterval(weaponController.randomBetweenNumbers(firstNum: 1, secondNum: 1.5)), target: self, selector: #selector(GameplaySceneClass.callWeapons), userInfo: nil, repeats: true)
        
        timerForFuncCountMissedWeapons = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameplaySceneClass.countMissedWeapons), userInfo: nil, repeats: true)
    }
    
    
    func managePlayer() {
        
        if canMove {
            
            player?.move(left: moveLeft)
        }
    }
    
    func callWeapons() {
        
        self.scene?.addChild(weaponController.spawnWeapons())
    }
    
    func restartGame() {
        
        if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsCloseVertical(withDuration: TimeInterval(2)))
        }
    }
    
    
    
    func countMissedWeapons() {
        
        for child in children {
            if child.name == "weapon1" || child.name == "weapon2" {
                if child.position.y < -470 {
                    score += 1
                    scoreLabel?.text = String(score)
                    child.removeFromParent()
                }
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "hit", withExtension: ".mp3")!
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            guard let soundPlayer = soundPlayer else { return }
            
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func goToMainMenu() {
        if let scene = MainMenuScene(fileNamed: "MainMenu") {
            
            scene.scaleMode = .aspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
        }
    }
}

