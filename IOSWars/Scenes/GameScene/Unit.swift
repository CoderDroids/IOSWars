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
        return textureName
    }

    func onInteract()
    {
        print("unit interact")
    }
}
