//
//  AttackScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//


import SpriteKit

class AttackScene : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode )
    {
        super.init()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        self.zPosition = 1
        
        let attacker = TroopAttackNode( parent : self, pos : CGPoint( x : 0, y : h * 0.25 ), troopName : "Attacker", isAttacker : true )
        let defender = TroopAttackNode( parent : self, pos : CGPoint( x : 0, y : -h * 0.25 ), troopName : "Defender", isAttacker: false )


        parent.addChild( self )

    }
    
    
    
}
