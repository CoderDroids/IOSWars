//
//  GameplayManager.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-04-16.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit

class GameplayManager
{
    static let instance = GameplayManager()
    var game : GameScene?
    
    func battle( attacker : Unit, defender: Unit )
    {
        
    }
    
    func buyUnit( unit : Unit )
    {
    }
    
    func showUnitPurchasePopup( building : Building )
    {
        var unitPurchase = UnitPurchasePopup( parent : game!, building : building )
        game!.popups.append( unitPurchase )
    }
    
    func addPopup( popup : PopupNode )
    {
        game!.popups.append( popup )
    }
    
}
