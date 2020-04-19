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
    var turn : Int
    var playerGold : Int
    var enemyGold : Int
    
    init()
    {
        self.turn = 0
        self.playerGold = 200
        self.enemyGold = 200
    }
    
    func battle( attacker : Unit, defender: Unit, showResult : Bool )
    {
        
        if showResult {
            doBattle(attacker: attacker, defender: defender )
            let attackPopup = AttackPopup( parent : game!, size : CGSize( width: 600, height: 600 ), attacker : attacker, defender : defender )
        
            game!.popups.append( attackPopup )
        } else {
            doBattle(attacker : attacker, defender: defender )
        }
    }
    
    func battle( attacker : Unit, target : Building, showResult : Bool )
    {
        
        if showResult {
            doBattle(attacker: attacker, target: target )
            let attackPopup = AttackPopup( parent : game!, size : CGSize( width: 600, height : 600 ), attacker : attacker, target: target )
            game!.popups.append( attackPopup )
        } else {
            doBattle(attacker: attacker, target: target )
        }
    }
    
    private func doBattle( attacker : Unit, defender: Unit )
    {
        var attackDamage = attacker.attack * attacker.currentHealth / attacker.maxHealth
        defender.currentHealth = max( defender.currentHealth - attackDamage, 0.0 )
        if defender.currentHealth <= 0.0 {
            game!.removeUnit( unit: defender )
        }
        else {
            var defenderDamage = defender.attack * defender.currentHealth / defender.maxHealth
            attacker.currentHealth = max( attacker.currentHealth - defenderDamage, 0.0 )           
            if attacker.currentHealth <= 0.0 {
                game!.removeUnit( unit: attacker )
            }
        }
    }
    
    private func doBattle( attacker : Unit, target: Building )
    {
        var attackDamage = attacker.attack * attacker.currentHealth / attacker.maxHealth
        target.currentHealth = max( target.currentHealth - attackDamage, 0.0 )
        if target.currentHealth <= 0.0 {
            target.buildingOwner = attacker.unitOwner
            target.color = Building.getBuildingColor(owner: attacker.unitOwner )
        }
    }
    
    func checkIfGameEnd()
    {
        var playerHomeExist = false
        var enemyHomeExist = false
        for building in game!.buildings {
            if building.buildingType == BuildingType.HeadQuarter {
                if building.buildingOwner == Owner.Player {
                    playerHomeExist = true
                }
                else if building.buildingOwner == Owner.Opponent {
                    enemyHomeExist = true
                }
            }
        }
        
        if playerHomeExist == false {
            gameEnd( isWon: false )
        } else if enemyHomeExist == false {
            gameEnd( isWon: true )
        }
    }
    
    func showUnitInfo( unit : Unit )
    {
        
    }
    
    func buyUnit( type : UnitType, owner : Owner, address : vector_int2 ) -> Bool
    {
        let unitCost = Unit.getUnitCost(type: type )
        var purchased = false
        if owner == Owner.Player {
            if self.playerGold >= unitCost {
                self.playerGold -= unitCost
                purchased = true
            }
        } else if owner == Owner.Opponent {
            if self.enemyGold >= unitCost {
                self.enemyGold -= unitCost
                purchased = true
            }
        }
        if purchased {
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
            // unit can't move right after it's purchased
            unit.hasMoved = true
            if owner == Owner.Player {
                game!.units.append(unit)
            } else if owner == Owner.Opponent {
                game!.enemies.append(unit)
            }
            return true
        }
        return false
    }
    
    func showUnitPurchasePopup( building : Building )
    {
        let unitPurchase = UnitPurchasePopup( parent : game!, building : building )
        game!.popups.append( unitPurchase )
    }
    
    func takeTurn()
    {
        for building in game!.buildings {
            if building.buildingOwner == Owner.Player {
                playerGold += building.goldGenerate
            }
            else if building.buildingOwner == Owner.Opponent {
                enemyGold += building.goldGenerate
            }
            building.resetTurn()
        }
        for unit in game!.units {
            unit.resetTurn()
        }
        for unit in game!.enemies {
            unit.resetTurn()
        }
        
    }
    
    func gameEnd( isWon : Bool )
    {
        for popup in game!.popups {
            popup.removeFromParent()
        }
        game!.popups.removeAll()
        
        let gameEndPopup = GameEndPopup( gameScene : game!, isWon : isWon )
        game!.popups.append( gameEndPopup )
    }
    
}
