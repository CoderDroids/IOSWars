//
//  Headquarter.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-16.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class Headquarter : Building
{
    init( parent : SKNode, pos : CGPoint, owner : Owner )
    {
        super.init( parent : parent,  pos: pos, type : BuildingType.HeadQuarter, owner : owner, health : 10, gold : 100 )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onInteract()
    {
        if self.buildingOwner == Owner.Player && self.hasActed == false {
            GameplayManager.instance.showUnitPurchasePopup( building : self )
        }
    }
}
