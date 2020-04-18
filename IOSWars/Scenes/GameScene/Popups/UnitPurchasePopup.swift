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
    var buyButtons : [SKNode] = []
    var building : Building?
    let units : [UnitType] = [UnitType.Fighter, UnitType.Knight, UnitType.Mage]
    init( parent : SKNode, building : Building )
    {
        self.building = building
        super.init()
        
        var width = UIScreen.main.bounds.width
        var height = CGFloat(330.0)
        
        let background = SKSpriteNode( color : UIColor( red: 0.7, green : 0.7, blue: 0.7, alpha : 0.9 ), size : CGSize( width: width * 0.9, height: height ) )
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
        
        if units.count > 0 {
            var offset = height / CGFloat(units.count)
            var h = offset
            for i in 0..<units.count {
                let unitNode = UnitPriceNode( parent : background, pos : CGPoint( x : 0, y : h ), size : CGSize( width : width * 0.8, height : offset * 0.9 ), type : self.units[i] )
                let buyButton = unitNode.childNode( withName : "Buy" )!
                self.buyButtons.append( buyButton )
                h -= offset
            }
        }

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
        for i in 0..<self.buyButtons.count {
            let button_pos = self.convert( pos, to : self.buyButtons[i].parent! )
            if self.buyButtons[i].contains( button_pos ) {
                GameplayManager.instance.buyUnit( type : units[i], address : self.building!.address  )
                return true
            }
        }
        return false
    }
}
