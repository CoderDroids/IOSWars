//
//  BuildingInfoPopup.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class UnitPurchasePopup : PopupNode
{
    var closeButton : SKSpriteNode?
    init( parent : SKNode, building : Building )
    {
        super.init()
        
        var width = UIScreen.main.bounds.width
        
        
        let background = SKSpriteNode( color : UIColor( red: 0.7, green : 0.7, blue: 0.7, alpha : 0.9 ), size : CGSize( width: width * 0.9, height: 330 ) )
        self.addChild(background)
        
        self.closeButton = SKSpriteNode( color : UIColor.red, size : CGSize( width: 64, height : 64 ) )
        self.closeButton!.position = CGPoint( x : width * 0.45, y : 180 )
        background.addChild( self.closeButton! )
        
        let closeText = SKLabelNode()
        closeText.position = CGPoint( x : 0, y : -20 )
        closeText.text = "X"
        closeText.fontSize = 50
        closeText.fontColor = SKColor.white
        closeButton!.addChild(closeText)
        
        let unitNode1 = UnitPriceNode( parent : background, pos : CGPoint( x : 0, y : 110 ), size : CGSize( width : width * 0.8, height : 100 ), type : UnitType.Fighter )
        let unitNode2 = UnitPriceNode( parent : background, pos : CGPoint( x : 0, y : 0 ), size : CGSize( width : width * 0.8, height : 100 ), type : UnitType.Knight )
        let unitNode3 = UnitPriceNode( parent : background, pos : CGPoint( x : 0, y : -110 ), size : CGSize( width : width * 0.8, height : 100 ), type : UnitType.Mage )

        parent.addChild(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onTouchDown( pos : CGPoint ) -> Bool
    {
        let popup_pos = self.convert(pos, to: self)
        if self.closeButton!.contains( popup_pos ) {
            return true
        }
        return false
    }
}
