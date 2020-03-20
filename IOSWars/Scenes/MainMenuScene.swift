//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class MainMenuScene: SKScene {
    var continueButton : SKSpriteNode!
    var newGameButton : SKSpriteNode!
    var optionButton : SKSpriteNode!
    var creditButton : SKSpriteNode!
    
    override func didMove(to view: SKView )
    {
        continueButton = self.childNode( withName : "ContinueButton" ) as! SKSpriteNode
        newGameButton = self.childNode( withName : "NewGameButton" ) as! SKSpriteNode
        optionButton = self.childNode( withName : "OptionButton" ) as! SKSpriteNode
        creditButton = self.childNode( withName : "CreditButton" ) as! SKSpriteNode
        
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
            var sceneName : String?
            if continueButton.contains(location) {
                sceneName = "GameScene"
            } else if newGameButton.contains(location) {
                sceneName = "GameScene"
            } else if optionButton.contains(location) {
                sceneName = "OptionScene"
            } else if creditButton.contains(location) {
                sceneName = "CreditScene"
            }
            
            if sceneName != nil {
                let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
                let gameScene = SKScene(fileNamed: sceneName! )!
                self.view?.presentScene( gameScene, transition: transition )
            }
        }
    }
}
