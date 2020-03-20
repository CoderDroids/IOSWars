//
//  GameScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-07.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var backButton : SKSpriteNode?
    var workshopButton : SKSpriteNode?
    var attackButton : SKSpriteNode?
    
    var workshopScene : SKNode?
    var attackScene : SKNode?
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
     
        backButton = self.childNode( withName : "BackButton" ) as! SKSpriteNode
        workshopButton = self.childNode( withName : "WorkshopSceneButton" ) as! SKSpriteNode
        attackButton = self.childNode( withName : "AttackSceneButton" ) as! SKSpriteNode
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        if backButton!.contains(pos) {
            let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
            let gameScene = SKScene(fileNamed: "MainMenuScene" )!
            self.view?.presentScene( gameScene, transition: transition )
        } else if (workshopButton?.contains( pos ))! {
            if workshopScene == nil {
                workshopScene = WorkshopScene( parent : self )
            }
        } else if (attackButton?.contains( pos ))! {
            if attackScene == nil {
                attackScene = AttackScene( parent : self )
            }
        } else {
            if workshopScene != nil {
                workshopScene?.removeFromParent()
                workshopScene = nil
            }
            if attackScene != nil {
                attackScene?.removeFromParent()
                attackScene = nil
            }
            
        }
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
