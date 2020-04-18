//
//  BuildingInfoPopup.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class BuildingInfoPopup : PopupNode
{
    init( parent : SKNode, unit : Unit )
    {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onTouchDown( pos : CGPoint ) -> Bool
    {
        var popup_pos = self.convert(pos, to: self)
        
        return false
    }
}
