//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class SplashScene: SKScene {
    override func didMove(to view: SKView )
    {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        Audio.instance.playMusic(name: "main")
        let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
        let mainScene = SKScene(fileNamed: "MainMenuScene" )!
        self.view?.presentScene( mainScene, transition: transition )
    }
}
