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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, unitName : String, unitPrice : Int )
    {
        super.init()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.gray, size : CGSize( width: w * 0.6, height: h * 0.06 ) )
        addChild( background )
        
        let unitNameText = SKLabelNode()
        unitNameText.fontSize = 30
        unitNameText.fontColor = SKColor.white
        unitNameText.text = unitName
        unitNameText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        unitNameText.position = CGPoint( x: background.size.width * -0.3, y : 0.0 )
        background.addChild(unitNameText)
        
        let unitPriceText = SKLabelNode()
        unitPriceText.fontSize = 30
        unitPriceText.fontColor = SKColor.white
        unitPriceText.text = "\(unitPrice)g"
        unitPriceText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        unitPriceText.position = CGPoint( x: background.size.width * 0.3, y : 0.0 )
        background.addChild(unitPriceText)
        
        parent.addChild( self )

    }
}
