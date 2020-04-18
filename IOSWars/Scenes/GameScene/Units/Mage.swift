//
//  Mage.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class Mage : Unit
{
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, owner : Owner )
    {
        super.init( parent : parent,  pos: pos, type : UnitType.Mage, damage : 15, health : 8, movement : 3,attack: 2, owner : owner  )
    }
}
