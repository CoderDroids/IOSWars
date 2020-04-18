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
    var unitOwner : Owner
    
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
//
    init( parent : SKNode, pos : CGPoint, type : UnitType, damage : Float, health : Float, movement : Int, owner : Owner )
    {
        self.attack = damage
        self.currentHealth = health
        self.maxHealth = health
        self.unitType = type
        self.movementRange = movement
        self.unitOwner = owner
        
        let imageName = Unit.getUnitImage( type : type )
        let unitColor = Unit.getUnitColor( owner : owner )
        super.init( texture : SKTexture( imageNamed: imageName ), color : unitColor, size : CGSize( width : 64, height : 64 ) )
        self.colorBlendFactor = 1.0
        parent.addChild(self)
        
        self.position = Pathfinding.instance.NodeToScreen( grid: vector_int2( Int32(pos.x), Int32(pos.y) ) )
    }
    
    class func getUnitColor( owner : Owner ) -> UIColor
    {
        switch( owner )
        {
        case Owner.Player:
            return UIColor( red: 0, green: 1, blue: 0, alpha : 1 )
        case Owner.Opponent:
            return UIColor.red
        default:
            return UIColor.white
        }
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
    
    class func getUnitCost( type : UnitType ) -> Int
    {
        switch type
        {
        case UnitType.Fighter:
            return 200
        case UnitType.Mage:
            return 800
        case UnitType.Knight:
            return 400
        case UnitType.Catapult:
            return 1000
        default:
            return 0
        }
    }

    func onInteract()
    {
        print("unit interact")
    }
}
