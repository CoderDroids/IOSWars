//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class CreditScene: SKScene {
    var backButton : SKSpriteNode!
    
    override func didMove(to view: SKView )
    {
        backButton = self.childNode( withName : "BackButton" ) as! SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        let touch = touches.first
        
        if let location = touch?.location( in: self )
        {
            if backButton.contains(location) {
                let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
                let gameScene = SKScene(fileNamed: "MainMenuScene" )!
                self.view?.presentScene( gameScene, transition: transition )
            }
        }
    }
}
