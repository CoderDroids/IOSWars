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
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, type : UnitType )
    {
        super.init()
        
        self.position = pos
        let background = SKSpriteNode( color : UIColor.gray, size : size )
        addChild(background)

        parent.addChild( self )
        

        let unitTexture = ModelActor( texture : SKTexture( imageNamed: Unit.getUnitImage(type : type )))
        unitTexture.color = UIColor.green
        unitTexture.colorBlendFactor = 1.0
        unitTexture.size = CGSize( width : size.width * 0.9, height : size.height * 0.9 )
        background.addChild(unitTexture)

    }
}
