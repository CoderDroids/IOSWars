//
//  UnitPriceNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class TitleTextNode : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, titleName : String )
    {
        super.init()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.orange, size : CGSize( width: w * 0.8, height: h * 0.08 ) )
        addChild(background)
        
        let innerBackground = SKSpriteNode( color : UIColor.white, size : CGSize( width: w * 0.75, height: h * 0.07 ) )
        background.addChild( innerBackground )

        let titleNameText = SKLabelNode()
        titleNameText.fontSize = 35
        titleNameText.fontColor = SKColor.black
        titleNameText.text = "\(titleName): "
        titleNameText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        innerBackground.addChild(titleNameText)

        parent.addChild( self )
    }
}
