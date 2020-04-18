//
//  GameEndPopup.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-18.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class GameEndPopup : PopupNode
{
    var okButton : SKNode?
    var game : GameScene?
    
    init( gameScene : GameScene, isWon : Bool )
    {
        self.game = gameScene
        super.init()
        
        let background = SKSpriteNode( color : UIColor( red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0 ), size : CGSize( width: 300, height: 200 ) )
        self.addChild(background)
        
        let gameEndText = SKLabelNode()
        if isWon {
            gameEndText.text = "You Win!!"
        } else {
            gameEndText.text = "You Lost"
        }
        gameEndText.fontSize = 50
        gameEndText.fontColor = SKColor.yellow
        background.addChild(gameEndText)
        
        self.okButton = SKSpriteNode( color : UIColor.blue, size : CGSize( width: 150, height : 64 ) )
        self.okButton!.position = CGPoint( x : 0, y: -80 )
        background.addChild( self.okButton! )
     
        let mainMenuText = SKLabelNode()
        mainMenuText.position = CGPoint( x : 0, y : -10 )
        mainMenuText.text = "Main Menu"
        mainMenuText.fontSize = 35
        mainMenuText.fontColor = SKColor.white
        self.okButton!.addChild(mainMenuText)
        
        gameScene.addChild( self )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onTouchDown( pos : CGPoint ) -> Bool
    {
        let popup_pos = self.convert(pos, to: self)
        if self.okButton!.contains( popup_pos ) {
            let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
            let menuScene = SKScene(fileNamed: "MainMenuScene" )!
            game!.view?.presentScene( menuScene, transition: transition )
            return true
        }
        return false
    }
}
