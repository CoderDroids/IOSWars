//
//  Building.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-16.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class Building : SKSpriteNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init( texture: SKTexture!, color: SKColor!, size: CGSize )
    {
        super.init( texture: texture, color: color, size: size )
    }
    
    convenience init( parent : SKNode, image : String, pos : CGPoint, size : CGSize )
    {
        self.init( texture : SKTexture( imageNamed: image ), color : UIColor.white, size : size )
        parent.addChild(self)
        self.position = pos
    }
    
    func onInteract()
    {
        print("building onInteract")
    }
    
    
}
