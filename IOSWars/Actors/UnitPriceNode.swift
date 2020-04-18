//
//  UnitPriceNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class UnitPriceNode : SKNode
{
    var buyButton : SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, type : UnitType )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        self.position = pos
        
        let unitFaceNode = UnitNode( parent : self, pos: CGPoint( x : w * -0.4, y : 0 ), size : CGSize( width: w * 0.2, height: h * 0.9 ), type : type )
        
        let unitNameText = SKLabelNode()
        unitNameText.fontSize = 30
        unitNameText.fontColor = SKColor.black
        unitNameText.text = Unit.getUnitName( type : type )
        unitNameText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        unitNameText.position = CGPoint( x: w * -0.15, y : 0.0 )
        addChild(unitNameText)
        
        let unitPriceText = SKLabelNode()
        unitPriceText.fontSize = 30
        unitPriceText.fontColor = SKColor.black
        let unitCost = Unit.getUnitCost( type : type )
        unitPriceText.text = "\(unitCost)g"
        unitPriceText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        unitPriceText.position = CGPoint( x: w * 0.15, y : 0.0 )
        addChild(unitPriceText)
        
        self.buyButton = SKSpriteNode( color : UIColor.green, size : CGSize( width: w * 0.2, height : h * 0.7 ) )
        self.buyButton!.position = CGPoint( x : w * 0.4, y: 0 )
        addChild( self.buyButton! )
        
        let buyText = SKLabelNode()
        buyText.position = CGPoint( x : 0, y : -10 )
        buyText.text = "Buy"
        buyText.fontSize = 30
        buyText.fontColor = SKColor.black
        self.buyButton!.addChild(buyText)
        
        parent.addChild( self )

    }
}
