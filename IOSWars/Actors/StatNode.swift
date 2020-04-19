//
//  UnitPriceNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class StatNode : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, statName : String, statValue : Int )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.orange, size : CGSize( width: w, height: h ) )
        addChild(background)
        
        let innerBackground = SKSpriteNode( color : UIColor.white, size : CGSize( width: w * 0.95, height: h * 0.9 ) )
        background.addChild( innerBackground )

        let statNameText = SKLabelNode()
        statNameText.fontSize = 35
        statNameText.fontColor = SKColor.black
        statNameText.text = "\(statName): "
        statNameText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        statNameText.position = CGPoint( x: background.size.width * -0.2, y : 0.0 )
        innerBackground.addChild(statNameText)
        
        let statValueText = SKLabelNode()
        statValueText.fontSize = 30
        statValueText.fontColor = SKColor.black
        statValueText.text = "\(statValue)"
        statValueText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        statValueText.position = CGPoint( x: background.size.width * 0.2, y : 0.0 )
        innerBackground.addChild(statValueText)

        parent.addChild( self )

    }
}
