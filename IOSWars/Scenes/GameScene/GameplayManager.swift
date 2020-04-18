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
    
    func buyUnit( type : UnitType, address : vector_int2 )
    {
        var pos = CGPoint( x: CGFloat(address.x), y: CGFloat(address.y) )
        var unit : Unit
        switch( type )
        {
        case UnitType.Fighter:
            unit = Fighter( parent: game!.tileMap!, pos : pos , owner : Owner.Player )
        case .Knight:
            unit = Knight( parent: game!.tileMap!, pos : pos , owner : Owner.Player )
        case .Mage:
            unit = Mage( parent: game!.tileMap!, pos : pos , owner : Owner.Player )
        default:
            unit = Fighter( parent: game!.tileMap!, pos : pos , owner : Owner.Player )
        }
        game!.units.append(unit)
    }
    
    func showUnitPurchasePopup( building : Building )
    {
        let unitPurchase = UnitPurchasePopup( parent : game!, building : building )
        game!.popups.append( unitPurchase )
    }
    
    func addPopup( popup : PopupNode )
    {
        game!.popups.append( popup )
    }
    
}
