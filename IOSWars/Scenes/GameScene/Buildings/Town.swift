//
//  Town.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class Town : Building
{
    init( parent : SKNode, pos : CGPoint, owner : BuildingOwner )
    {
        super.init( parent : parent,  pos: pos, type : BuildingType.Town, owner : owner, health : 10, gold : 100 )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onInteract()
    {
        print("Town touched")
    }
}
