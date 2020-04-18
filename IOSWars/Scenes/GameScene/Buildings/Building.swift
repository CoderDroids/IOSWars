//
//  Building.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-16.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

enum BuildingType
{
    case HeadQuarter
    case Town
}

enum Owner
{
    case Neutral
    case Player
    case Opponent
}

class Building : SKSpriteNode
{
    var currentHealth : Float
    var maxHealth : Float
    var goldGenerate : Int
    var buildingType : BuildingType
    var buildingOwner : Owner
    var address : vector_int2
    var hasActed : Bool
    var isAttacked : Bool
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, type : BuildingType, owner : Owner, health : Float, gold : Int )
    {
        self.currentHealth = health
        self.maxHealth = health
        self.goldGenerate = gold
        self.buildingType = type
        self.buildingOwner = owner
        self.address = vector_int2( Int32(pos.x), Int32(pos.y) )
        self.hasActed = false
        self.isAttacked = false
        
        let imageName = Building.getBuildingImage( type : type, owner : owner )
        let buildingColor = Building.getBuildingColor( owner : owner )

        super.init( texture : SKTexture( imageNamed: imageName ), color : buildingColor, size : CGSize( width : 96, height : 96 ) )
        self.colorBlendFactor = 1.0
        parent.addChild(self)
        self.position = Pathfinding.instance.NodeToScreen( grid: self.address )
    }
    
    class func getBuildingColor( owner : Owner ) -> UIColor
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
    
    class func getBuildingImage( type : BuildingType, owner : Owner ) -> String
    {
        switch type
        {
        case BuildingType.HeadQuarter:
            if owner == Owner.Player {
                return "player-base.png"
            } else {
                return "tower-flag.png"
            }
        case BuildingType.Town:
            return "village.png"
        default:
            return "white-tower.png"
        }
    }
    
    class func getBuildingName( type : BuildingType ) -> String
    {
        switch type
        {
        case BuildingType.HeadQuarter:
            return "Home Base"
        case BuildingType.Town:
            return "Town"
        default:
            return "Building"
        }
    }
    
    func onInteract()
    {
        print("building onInteract")
    }
    
    func resetTurn()
    {
        self.hasActed = false
        
        if self.isAttacked == false {
            currentHealth = min( currentHealth + 1, maxHealth )
        }
        self.isAttacked = false
    }
    
    
}
