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
    
    init( parent : SKNode, pos : CGPoint, statName : String, statValue : Int )
    {
        super.init()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.orange, size : CGSize( width: w * 0.8, height: h * 0.08 ) )
        addChild(background)
        
        let innerBackground = SKSpriteNode( color : UIColor.white, size : CGSize( width: w * 0.75, height: h * 0.07 ) )
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
