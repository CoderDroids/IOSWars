//
//  AttackScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-03-19.
//  Copyright © 2020 CoderDroids. All rights reserved.
//


import SpriteKit

class AttackPopup : PopupNode
{
    var closeButton : SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( parent : SKNode, size : CGSize, attacker : Unit, defender : Unit )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        
        self.zPosition = 1
        
        let attackerNode = TroopAttackNode( parent : self, pos : CGPoint( x : 0, y : h * 0.25 ), size : CGSize( width : w * 0.9, height : h * 0.45 ), troop : attacker, isAttacker : true )
        let defenderNode = TroopAttackNode( parent : self, pos : CGPoint( x : 0, y : -h * 0.25 ), size : CGSize( width : w * 0.9, height : h * 0.45 ), troop : defender, isAttacker: false )
        
        self.closeButton = SKSpriteNode( color : UIColor.blue, size : CGSize( width: 128, height : 64 ) )
        self.closeButton!.position = CGPoint( x : 0, y: -h * 0.5 - 32 )
        self.addChild( self.closeButton! )
        
        let okText = SKLabelNode()
        okText.position = CGPoint( x : 0, y : -10 )
        okText.text = "OK"
        okText.fontSize = 30
        okText.fontColor = SKColor.white
        self.closeButton!.addChild(okText)
        
        parent.addChild( self )
        
        // do the attack result

    }
    
    init( parent : SKNode, size : CGSize, attacker : Unit, target : Building )
    {
        super.init()
        
        let w = size.width
        let h = size.height
        
        self.zPosition = 1
        
        let attackerNode = TroopAttackNode( parent : self, pos : CGPoint( x : 0, y : h * 0.25 ), size : CGSize( width : w * 0.9, height : h * 0.45 ), troop : attacker, isAttacker : true )
        //let defenderNode = BuildingNode()
        
        self.closeButton = SKSpriteNode( color : UIColor.blue, size : CGSize( width: 128, height : 64 ) )
        self.closeButton!.position = CGPoint( x : 0, y: -h * 0.5 - 32 )
        self.addChild( self.closeButton! )
        
        let okText = SKLabelNode()
        okText.position = CGPoint( x : 0, y : -10 )
        okText.text = "OK"
        okText.fontSize = 30
        okText.fontColor = SKColor.white
        self.closeButton!.addChild(okText)
        
        parent.addChild( self )
        
        // do the attack result

    }
    
    
    override func onTouchDown( pos : CGPoint ) -> Bool
    {
        var popup_pos = self.convert(pos, to: self)
        if self.closeButton!.contains( popup_pos ) {
            if GameplayManager.instance.checkIfGameEnd() {
                return false
            }
            return true
        }
        return false
    }
    
    
}
