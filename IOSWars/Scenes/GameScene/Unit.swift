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
    var attack : Float
    var currentHealth : Float
    var maxHealth : Float
    var unitType : UnitType
    var movementRange : Int
    var unitCost : Int
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    override init( texture: SKTexture!, color: SKColor, size: CGSize )
//    {
//        self.attack = 0
//        self.currentHealth = 0
//        self.maxHealth = 0
//        self.unitType = UnitType.Fighter
//        self.movementRange = 0
//        self.unitCost = 0
//        super.init( texture: texture, color: color, size: size )
//    }

    init( parent : SKNode, pos : CGPoint, type : UnitType, damage : Float, health : Float, movement : Int, cost : Int )
    {
                self.attack = 0
                self.currentHealth = 0
                self.maxHealth = 0
                self.unitType = UnitType.Fighter
                self.movementRange = 0
                self.unitCost = 0
        let imageName = Unit.getUnitImage( type : type )
        super.init( texture : SKTexture( imageNamed: imageName ), color : .white, size : CGSize( width : 64, height : 64 ) )
        parent.addChild(self)
        
        self.position = pos
        self.attack = damage
        self.maxHealth = health
        self.currentHealth = health
        self.unitType = type
        self.movementRange = movement
        self.unitCost = cost
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
