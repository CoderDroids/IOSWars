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
     
        let statNode = StatNode( parent : background, pos : CGPoint( x : 0, y : background.size.height * 0.35), statName : "Attack", statValue: Int(troop.baseDamage) )
    
        // TODO : make this generic
        let troopNode = UnitNode( parent : background, pos : CGPoint( x : 0, y : 0 ), type : troop.unitType )
        let troopNameNode = TitleTextNode( parent : background, pos : CGPoint( x : 0, y : -background.size.height * 0.4), titleName: Unit.getUnitName( type: troop.unitType ) )
        
        parent.addChild( self )
    }
}
