//
//  Knight.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class Knight : Unit
{
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
//    init( parent : SKNode, pos : CGPoint )
//    {
//        super.init( texture : SKTexture( imageNamed: Unit.getUnitImage(type: UnitType.Knight) ), color : .white, size : CGSize( width : 64, height : 64 ) )
//        self.position = pos
//        self.unitType = UnitType.Knight
//        self.currentHealth = 18
//        self.maxHealth = 18
//        self.attack = 7
//        self.movementRange = 6
//        self.unitCost = 400
//    }
    
    init( parent : SKNode, pos : CGPoint, owner : Owner )
    {
        super.init( parent : parent,  pos: pos, type : UnitType.Knight, damage : 7, health : 18, movement : 6, cost : 400, owner : owner  )
    }
}
