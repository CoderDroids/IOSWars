//
//  BuildingNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-18.
//  Copyright © 2020 CoderDroids. All rights reserved.
//


import SpriteKit

class BuildingNode : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, target : Building )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.yellow, size : CGSize( width: w, height: h ) )
        background.color = UIColor.blue
        addChild( background )
        
        let buildingTexture = SKSpriteNode( texture: SKTexture( imageNamed: Building.getBuildingImage(type: target.buildingType, owner: target.buildingOwner ) ) )
        buildingTexture.position = CGPoint( x : 0, y : h * 0.1 )
        buildingTexture.color = Building.getBuildingColor(owner: target.buildingOwner )
        buildingTexture.colorBlendFactor = 1.0
        buildingTexture.size = CGSize( width : 100, height : 100)
        background.addChild(buildingTexture)


        let healthNode = StatNode( parent : background, pos : CGPoint( x : 0.0, y : h * -0.3 ), size : CGSize( width : w * 0.6, height : h * 0.2 ), statName : "Health", statValue: Int(target.currentHealth) )
        parent.addChild( self )
    }
}
