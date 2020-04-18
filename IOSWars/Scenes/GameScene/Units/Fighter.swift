//
//  Fighter.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class Fighter : Unit
{
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, owner : Owner )
    {
        super.init( parent : parent,  pos: pos, type : UnitType.Fighter, damage : 4, health : 10, movement : 4, owner : owner  )
    }
}
