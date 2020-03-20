//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class OptionScene: SKScene {
    var helpButton : SKSpriteNode!
    var backButton : SKSpriteNode!
    
    override func didMove(to view: SKView )
    {
        helpButton = self.childNode( withName : "HelpButton" ) as! SKSpriteNode
        backButton = self.childNode( withName : "BackButton" ) as! SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        let touch = touches.first
        
        if let location = touch?.location( in: self )
        {
            if helpButton.contains(location) {
            } else if backButton.contains(location) {
                let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
                let gameScene = SKScene(fileNamed: "MainMenuScene" )!
                self.view?.presentScene( gameScene, transition: transition )
            }
        }
    }
}
