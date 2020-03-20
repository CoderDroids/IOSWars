//
//  UnitNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class UnitNode : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, type : UnitType )
    {
        super.init()
        
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        self.position = pos

        let background = SKSpriteNode( color : UIColor.gray, size : CGSize( width: 100, height: 100 ) )
        addChild(background)

        parent.addChild( self )
        
//        let unitTexture = ModelActor()
//        background.addChild(unitTexture)

    }
}
