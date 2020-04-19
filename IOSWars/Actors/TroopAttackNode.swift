//
//  TroopAttackNode.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class TroopAttackNode : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, pos : CGPoint, size : CGSize, troop : Unit, isAttacker : Bool )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.yellow, size : CGSize( width: w, height: h ) )
        if isAttacker {
            background.color = UIColor.red
        } else {
            background.color = UIColor.blue
        }
        addChild( background )
     

        let troopNode = UnitNode( parent : background, pos : CGPoint( x : w * -0.3, y : 0 ), size : CGSize( width: 64, height: 64 ), type : troop.unitType )
        
        let attackNode = StatNode( parent : background, pos : CGPoint( x : w * 0.1, y : h * 0.3), size : CGSize( width : w * 0.6, height : h * 0.2 ), statName : "Attack", statValue: Int(troop.attack) )
        let healthNode = StatNode( parent : background, pos : CGPoint( x : w * 0.1, y : 0.0), size : CGSize( width : w * 0.6, height : h * 0.2 ), statName : "Health", statValue: Int(troop.currentHealth) )
        let troopNameNode = TitleTextNode( parent : background, pos : CGPoint( x : 0, y : h * -0.3), size : CGSize( width : w * 0.5, height : h * 0.2 ), titleName: Unit.getUnitName( type: troop.unitType ) )


        
        parent.addChild( self )
    }
}
