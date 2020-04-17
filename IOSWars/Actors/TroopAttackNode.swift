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
    
    init( parent : SKNode, pos : CGPoint, troopName : String, isAttacker : Bool )
    {
        super.init()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        self.position = pos
        
        let background = SKSpriteNode( color : UIColor.yellow, size : CGSize( width: w, height: h * 0.5 ) )
        if isAttacker {
            background.color = UIColor.red
        } else {
            background.color = UIColor.blue
        }
        addChild( background )
     
        let statNode = StatNode( parent : background, pos : CGPoint( x : 0, y : background.size.height * 0.35), statName : "Strength", statValue: 10 )
    
        // TODO : make this generic
        if isAttacker == true {
            var pos1 : CGPoint = CGPoint( x : -100, y : -50 )
            let troop1 = UnitNode( parent : background, pos : pos1, type : UnitType.Knight )

            var pos2 : CGPoint = CGPoint( x : 100, y : -50 )
            let troop2 = UnitNode( parent : background, pos : pos2, type : UnitType.Catapult )
        
            var pos3 : CGPoint = CGPoint( x : 0, y : 60 )
            let troop3 = UnitNode( parent : background, pos : pos3, type : UnitType.Mage )
        } else {
            var pos1 : CGPoint = CGPoint( x : -100, y : 50 )
            let troop1 = UnitNode( parent : background, pos : pos1, type : UnitType.Fighter )

            var pos2 : CGPoint = CGPoint( x : 100, y : 50 )
            let troop2 = UnitNode( parent : background, pos : pos2, type : UnitType.Catapult )
        }

        let troopNameNode = TitleTextNode( parent : background, pos : CGPoint( x : 0, y : -background.size.height * 0.4), titleName: troopName )
        
        parent.addChild( self )
    }
}
