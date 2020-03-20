//
//  WorkshopScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//


import SpriteKit

class WorkshopScene : SKNode
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
        
        let background = SKSpriteNode( color : UIColor.yellow, size : CGSize( width: w * 0.8, height: h * 0.6 ) )
        addChild( background )
        
        let unit1 = UnitPriceNode( parent : background, pos : CGPoint( x: 0.0, y : background.size.height * 0.3 ), unitName : "Warrior", unitPrice : 200 )
        let unit2 = UnitPriceNode( parent : background, pos : CGPoint( x: 0.0, y : background.size.height * 0.1 ), unitName : "Cleric", unitPrice : 400 )
        let unit3 = UnitPriceNode( parent : background, pos : CGPoint( x: 0.0, y : -background.size.height * 0.1 ), unitName : "Knight", unitPrice : 600 )
        let unit4 = UnitPriceNode( parent : background, pos : CGPoint( x: 0.0, y : -background.size.height * 0.3 ), unitName : "Catapult", unitPrice : 800 )

        parent.addChild( self )

    }
    
    
    
}
