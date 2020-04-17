//
//  UnitBase.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-16.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

enum UnitType
{
    case Fighter
    case Knight
    case Mage
    case Catapult
}

class Unit : SKSpriteNode
{
    var baseDamage : Float
    var currentHealth : Float
    var maxHealth : Float
    var unitType : UnitType
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init( texture: SKTexture!, color: SKColor, size: CGSize )
    {
        self.baseDamage = 0
        self.currentHealth = 0
        self.maxHealth = 0
        self.unitType = UnitType.Fighter
        super.init( texture: texture, color: color, size: size )
    }

    convenience init( parent : SKNode, type : UnitType, pos : CGPoint, size : CGSize, damage : Float, health : Float )
    {
        let imageName = Unit.getUnitImage( type : type )
        self.init( texture : SKTexture( imageNamed: imageName ), color : .white, size : size )
        parent.addChild(self)
        self.position = pos
        
        self.baseDamage = damage
        self.maxHealth = health
        self.currentHealth = self.maxHealth
        self.unitType = type
    }
    
    class func getUnitImage( type : UnitType ) -> String
    {
        switch type
        {
        case UnitType.Fighter:
            return "swordman.png"
        case UnitType.Mage:
            return "wizard-face.png"
        case UnitType.Knight:
            return "knight.png"
        case UnitType.Catapult:
            return "catapult.png"
        default:
            return "swordman.png"
        }
    }
    
    class func getUnitName( type : UnitType ) -> String
    {
        switch type
        {
        case UnitType.Fighter:
            return "Fighter"
        case UnitType.Mage:
            return "Mage"
        case UnitType.Knight:
            return "Knight"
        case UnitType.Catapult:
            return "Catapult"
        default:
            return "Unit"
        }
    }

    func onInteract()
    {
        print("unit interact")
    }
}
