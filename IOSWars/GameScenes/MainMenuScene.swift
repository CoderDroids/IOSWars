//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class MainMenuScene: SKScene {
    var playButtonNode : SKSpriteNode!
    var optionButtonNode : SKSpriteNode!
    var creditButtonNode : SKSpriteNode!
    
    override func didMove(to view: SKView )
    {
        playButtonNode = self.childNode( withName : "PlayButton" ) as! SKSpriteNode
        optionButtonNode = self.childNode( withName : "OptionButton" ) as! SKSpriteNode
        creditButtonNode = self.childNode( withName : "CreditButton" ) as! SKSpriteNode
        
        //let userDefaults = userDefaults.standard
        //if userDefaults.bool( forKey : "hard" ) {
        //
        //}
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        let touch = touches.first
        
        if let location = touch?.location( in: self )
        {
            if playButtonNode.contains(location) {
                let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
                let gameScene = SKScene(fileNamed: "GameScene" )!
                self.view?.presentScene( gameScene, transition: transition )
            } else if optionButtonNode.contains(location) {
                
            } else if creditButtonNode.contains(location) {
                
            }
        }
    }
    
    func optionMenu()
    {
        
    }
}
