//
//  UnitInfoPopup.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class UnitInfoPopup : PopupNode
{
    var battleButton : SKSpriteNode?
    var closeButton : SKSpriteNode?
    
    init( parent : SKNode, unit : Unit )
    {
        super.init()
        
        let background = SKSpriteNode( color : UIColor.gray, size : CGSize( width: 300, height: 300 ) )
        self.addChild(background)
        
        self.closeButton = SKSpriteNode( color : UIColor.red, size : CGSize( width: 64, height : 64 ) )
        self.closeButton!.position = CGPoint( x : 160, y : 160 )
        background.addChild( self.closeButton! )
        
        let closeText = SKLabelNode()
        closeText.position = CGPoint( x : 0, y : -20 )
        closeText.text = "X"
        closeText.fontSize = 50
        closeText.fontColor = SKColor.white
        closeButton!.addChild(closeText)
        
        self.battleButton = SKSpriteNode( color : UIColor.blue, size : CGSize( width: 128, height : 64 ) )
        self.battleButton!.position = CGPoint( x : 0, y: -130 )
        background.addChild( self.battleButton! )
        
        let battleText = SKLabelNode()
        battleText.position = CGPoint( x : 0, y : -10 )
        battleText.text = "Battle"
        battleText.fontSize = 30
        battleText.fontColor = SKColor.white
        self.battleButton!.addChild(battleText)
        
        let unitNode = UnitNode( parent : background, pos : CGPoint( x : 0, y : 0 ), type : unit.unitType )
        
        parent.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onTouchDown( pos : CGPoint ) -> Bool
    {
        var popup_pos = self.convert(pos, to: self)
        if self.closeButton!.contains( popup_pos ) {
            self.removeFromParent()
            return true
        }
        else if self.battleButton!.contains( popup_pos ) {
            self.removeFromParent()
            return true
        }
        return false
    }

    
    
}

