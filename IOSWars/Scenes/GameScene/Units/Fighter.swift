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
    
//    init( parent : SKNode, pos : CGPoint )
//    {
//        super.init( texture : SKTexture( imageNamed: Unit.getUnitImage(type: UnitType.Fighter) ), color : .white, size : CGSize( width : 64, height : 64 ) )
//        self.position = pos
//        self.unitType = UnitType.Fighter
//        self.currentHealth = 10
//        self.maxHealth = 10
//        self.attack = 4
//        self.movementRange = 4
//        self.unitCost = 200
//    }
    
    init( parent : SKNode, pos : CGPoint )
    {
        super.init( parent : parent,  pos: pos, type : UnitType.Fighter, damage : 4, health : 10, movement : 4, cost : 200  )
    }
}
