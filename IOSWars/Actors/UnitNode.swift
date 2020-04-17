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
        
        var textureName : String
        switch type
        {
        case UnitType.Fighter:
            textureName = "swordman.png"
        case UnitType.Mage:
            textureName = "wizard-face.png"
        case UnitType.Knight:
            textureName = "knight.png"
        case UnitType.Catapult:
            textureName = "catapult.png"
        default:
            textureName = "swordman.png"
        }
        let unitTexture = ModelActor( texture : SKTexture( imageNamed: textureName))
        unitTexture.size = CGSize( width : 80, height : 80 )
        background.addChild(unitTexture)

    }
}
