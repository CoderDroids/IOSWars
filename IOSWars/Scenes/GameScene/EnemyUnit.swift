//
//  EnemyUnit.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class EnemyUnit : Unit
{
    convenience init( parent : SKNode, type : UnitType, pos : CGPoint, size : CGSize, damage : Float, health : Float )
    {
        let imageName = Unit.getUnitImage( type : type )
        self.init( texture : SKTexture( imageNamed: imageName ), color : UIColor.red, size : size )
//        self.color = .red
//        self.colorBlendFactor = 1.0
        parent.addChild(self)
        self.position = pos
        
        self.baseDamage = damage
        self.maxHealth = health
        self.currentHealth = self.maxHealth
        self.unitType = type
    }
}
