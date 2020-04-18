//
//  tintedSquare.swift
//  IOSWars
//
//  Created by Ted Bissada on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class tintedSquare : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, color: UIColor)
    {
        super.init()
        self.position = pos
        let background = SKSpriteNode(color: color, size: size)

        addChild(background)
        parent.addChild( self )
        let unitTexture = ModelActor( texture : SKTexture( imageNamed: "tint.png"))
        unitTexture.blendMode = .alpha

        unitTexture.size = size
        background.addChild(unitTexture)
    }
}
