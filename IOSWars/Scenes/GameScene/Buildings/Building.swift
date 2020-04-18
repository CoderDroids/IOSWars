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

enum BuildingOwner
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
    var owner : BuildingOwner
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, type : BuildingType, owner : BuildingOwner, health : Float, gold : Int )
    {
        self.currentHealth = health
        self.maxHealth = health
        self.goldGenerate = gold
        self.buildingType = type
        self.owner = owner
        
        let imageName = Building.getBuildingImage( type : type, owner : owner )
        super.init( texture : SKTexture( imageNamed: imageName ), color : .white, size : CGSize( width : 96, height : 96 ) )
        parent.addChild(self)
        self.position = Pathfinding.instance.NodeToScreen( grid: vector_int2( Int32(pos.x), Int32(pos.y) ) )
    }
    
    class func getBuildingImage( type : BuildingType, owner : BuildingOwner ) -> String
    {
        switch type
        {
        case BuildingType.HeadQuarter:
            if owner == BuildingOwner.Player {
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
    
    
}
