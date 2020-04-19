//
//  GameScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-07.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var buildings = [Building]()
    var units = [Unit]()
    var enemies = [Unit]()
    var popups = [PopupNode]()
    var currentPopup : PopupNode?
    var currentUnit : Unit?

    var graphs = [String : GKGraph]()
    var backButton : SKNode?
    var turnButton : SKNode?
    var goldText : SKLabelNode?
    
    var touchDownPoint: CGPoint?
    var mapDragStart: CGPoint?
    var dragging : Bool = false
    var attackingUnit: Bool = false
    var enemyTurn: Bool = false
    
    var tileMap : SKTileMapNode?

    
    var workshopScene : SKNode?
    var attackScene : SKNode?
    
    let screenSize = UIScreen.main.bounds
    
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Create shape node to use during mouse interaction
        let w = self.size.width
        let h = self.size.height
     
        backButton = self.childNode( withName : "BackButton" )
        turnButton = self.childNode( withName : "TurnButton" )
        turnButton!.position = CGPoint( x: w * 0.4, y: -h * 0.4 )
        goldText = self.childNode( withName : "Gold" ) as! SKLabelNode
        goldText!.position = CGPoint( x: w * 0.25, y: h * 0.4 )
        //attackButton = self.childNode( withName : "AttackSceneButton" ) as! SKSpriteNode
        
        tileMap = self.childNode( withName : "Tile Map Node" ) as! SKTileMapNode
        Pathfinding.instance.loadMap(tileMap: &tileMap!)
        
        let playerHome = Headquarter( parent: tileMap!, pos : CGPoint( x: 10, y: 10 ), owner : Owner.Player )
        let enemyHome = Headquarter( parent: tileMap!, pos : CGPoint( x: 20, y: 20 ), owner : Owner.Opponent )
        buildings.append( playerHome )
        buildings.append( enemyHome )
        let town1 = Town( parent: tileMap!, pos : CGPoint( x: 10, y: 20 ), owner : Owner.Neutral )
        let town2 = Town( parent: tileMap!, pos : CGPoint( x: 21, y: 10 ), owner : Owner.Neutral )
        buildings.append(town1)
        buildings.append(town2)

        let unit1 = Fighter( parent: tileMap!, pos : CGPoint( x: 11, y: 11 ), owner : Owner.Player )
        let unit2 = Knight( parent: tileMap!, pos : CGPoint( x: 13, y: 13 ), owner : Owner.Player )
        let unit3 = Mage( parent: tileMap!, pos : CGPoint( x: 16, y: 12 ), owner : Owner.Player )
        units.append(unit1)
        units.append(unit2)
        units.append(unit3)

        let enemy1 = Fighter( parent: tileMap!, pos : CGPoint( x: 18, y: 20 ), owner : Owner.Opponent )
        let enemy2 = Knight( parent: tileMap!, pos : CGPoint( x: 16, y: 15 ), owner : Owner.Opponent )
        enemies.append(enemy1)
        enemies.append(enemy2)
        
        Pathfinding.instance.generateGraph(e: &enemies, u: &units, b: &buildings)
        GameplayManager.instance.game = self
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if enemyTurn{return}
        
        if backButton!.contains(pos) {
            let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
            let gameScene = SKScene(fileNamed: "MainMenuScene" )!
            self.view?.presentScene( gameScene, transition: transition )
        }
        else if turnButton!.contains(pos){
            GameplayManager.instance.takeTurn()
            enemyTurn = true
        }
        else {
            var isProcessed = false
            if self.popups.count > 0 {
                if self.popups[0].onTouchDown( pos : pos ) {
                    self.popups[0].removeFromParent()
                    self.popups.removeFirst()
                    isProcessed = true
                }
            }
            else
            {
                let map_pos = self.convert(pos, to: self.tileMap!)
                if isProcessed == false && self.popups.count == 0 && self.currentUnit == nil {
                    for unit in units {
                        if unit.contains(map_pos)  && !unit.hasMoved
                        {
                            self.currentUnit = unit
                            Pathfinding.instance.tintTiles(pos: pos,range: unit.movementRange,color: UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.3))
                            isProcessed = true
                            break
                        }
                    }
                }
                if isProcessed == false {

                    for enemy in enemies {
                        if enemy.contains(map_pos) {
                            if self.currentUnit != nil && attackingUnit {
                                if(Pathfinding.instance.unitDistnce(u1: (currentUnit?.position)!, u2: enemy.position) <= (currentUnit?.attackRange)!)
                                {
                                    GameplayManager.instance.battle( attacker : self.currentUnit!, defender: enemy, showResult : true )
                                }
                                attackingUnit = false
                                Pathfinding.instance.clearTintedTiles()
                                self.currentUnit = nil
                                isProcessed = true
                                break
                            }
                            else {
                                attackingUnit = false
                                self.currentUnit = nil
                                GameplayManager.instance.showUnitInfo( unit : enemy )
                                isProcessed = true
                                break
                            }
                        }
                    }
                }
                if isProcessed == false{
                    for building in buildings {
                        if building.contains(map_pos) {
                            if self.currentUnit != nil && attackingUnit {
                                if(Pathfinding.instance.unitDistnce(u1: (currentUnit?.position)!, u2: building.position) <= (currentUnit?.attackRange)! && building.buildingOwner != Owner.Player)
                                {
                                    GameplayManager.instance.battle( attacker : self.currentUnit!, target: building )
                                    break
                                }
                            }
                            else
                            {
                            attackingUnit = false
                            self.currentUnit = nil
                            building.onInteract()
                            isProcessed = true
                            break
                            }
                        }
                    }
                }
                
                if isProcessed == false {
                    if self.currentUnit != nil && !attackingUnit{
                        if moveUnit(pos: pos, unit: &self.currentUnit!)
                        {
                            self.currentUnit = nil
                        }
                    } else {
                        attackingUnit = false
                        Pathfinding.instance.clearTintedTiles()
                        touchDownPoint = pos
                        mapDragStart = tileMap?.position
                        backButton?.isHidden = true
                        dragging = true
                        self.currentUnit = nil
                    }
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if(dragging)
        {
            tileMap?.position = CGPoint(x: mapDragStart!.x-(touchDownPoint!.x-pos.x),
                                    y:mapDragStart!.y-(touchDownPoint!.y-pos.y))
        
            //protects against dragging off map in x axis
            if(abs((tileMap?.position.x)!) > abs((tileMap?.mapSize.width)!/(2*(1/(tileMap?.xScale)!))-(screenSize.width/2)))
            {
                tileMap?.position = CGPoint(x: ((tileMap?.position.x)! < 0 ? -1 : 1) * abs((tileMap?.mapSize.width)!/(2*(1/(tileMap?.xScale)!))-(screenSize.width/2)),y:(tileMap?.position.y)!)
            }
            //protects against dragging off map in y axis
            if(abs((tileMap?.position.y)!) > abs((tileMap?.mapSize.height)!/(2*(1/(tileMap?.yScale)!))-(screenSize.height/2)))
            {
                tileMap?.position = CGPoint(x:(tileMap?.position.x)! ,y:  ((tileMap?.position.y)! < 0 ? -1 : 1) * abs((tileMap?.mapSize.height)!/(2*(1/(tileMap?.yScale)!))-(screenSize.height/2)))
            }
        }
    }
    
    private func moveUnit(pos: CGPoint, unit: inout Unit)->Bool
    {
        
        Pathfinding.instance.clearTintedTiles()

        let path = Pathfinding.instance.getPath(startPoint: Pathfinding.instance.ScreenToNode(pos: unit.position), endPoint: Pathfinding.instance.tapToNode(tap: pos))
        
        
        if path == nil{return true}
        
        if (path?.count)! <= unit.movementRange
        {
            
            unit.position = (path?.last!)!
            unit.hasMoved = true
            Pathfinding.instance.generateGraph(e: &enemies, u: &units, b: &buildings)
            if(Pathfinding.instance.tintEnemyTiles(pos: pos,range: unit.attackRange,color: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 0.3), e: &enemies, b: &buildings))
            {
                attackingUnit = true
                return false
            }
        }
        return true
    }
    
    func removeUnit( unit : Unit )
    {
        if unit.unitOwner == Owner.Player {
            if let index = units.index( of: unit ) {
                units.remove( at: index )
            }
        } else if unit.unitOwner == Owner.Opponent {
            if let index = enemies.index( of: unit ) {
                enemies.remove( at: index )
            }
        }
        unit.removeFromParent()
    }
    
    func touchUp(atPoint pos : CGPoint) {
        backButton?.isHidden = false
        dragging = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        if enemyTurn
        {takeEnemyTurn()}
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for unit in self.units {
            //unit.update(deltaTime: dt)
        }
        
        goldText!.text = "Gold: \(GameplayManager.instance.playerGold)"
        
        self.lastUpdateTime = currentTime
    }
    
    func takeEnemyTurn()
    {
        for enemy in enemies
        {
            if !enemy.hasMoved
            {
                var shortestDistance :Int = 0
                var closestUnit: Unit?
                var closestBuilding: Building?
                var isUnit = false
                
                for unit in units
                {
                    if(shortestDistance == 0)
                    {
                        shortestDistance = Pathfinding.instance.unitDistnce(u1: enemy.position, u2: unit.position)
                        closestUnit = unit
                        isUnit = true
                    }
                    else if shortestDistance > Pathfinding.instance.unitDistnce(u1: enemy.position, u2: unit.position)
                    {
                        shortestDistance = Pathfinding.instance.unitDistnce(u1: enemy.position, u2: unit.position)
                        closestUnit = unit
                        isUnit = true
                    }
                }
                for building in buildings
                {
                    if building.buildingOwner == Owner.Opponent{continue}
                    if(shortestDistance == 0)
                    {
                        shortestDistance = Pathfinding.instance.unitDistnce(u1: enemy.position, u2: building.position)
                        closestBuilding = building
                        isUnit = false
                    }
                    else if shortestDistance > Pathfinding.instance.unitDistnce(u1: enemy.position, u2: building.position)
                    {
                        shortestDistance = Pathfinding.instance.unitDistnce(u1: enemy.position, u2: building.position)
                        closestBuilding = building
                        isUnit = false
                    }
                }
                
                if shortestDistance == 0{return}
                
                var closestThing: vector_int2
                if(isUnit){closestThing = Pathfinding.instance.ScreenToNode(pos: closestUnit!.position)}
                else{closestThing = Pathfinding.instance.ScreenToNode(pos: closestBuilding!.position)}
                
                var path = Pathfinding.instance.getPathEnemy(startPoint: Pathfinding.instance.ScreenToNode(pos: enemy.position), endPoint: closestThing)
                
                //if path == nil{continue}
                
                if (path?.count)! <= enemy.movementRange{enemy.position = (path?.removeLast())!}else
                {path = Array(path!.prefix(enemy.movementRange))}
                enemy.position = (path?.last!)!
                enemy.hasMoved = true
                Pathfinding.instance.generateGraph(e: &enemies, u: &units, b: &buildings)
                
                if Pathfinding.instance.unitDistnce(u1: enemy.position, u2: Pathfinding.instance.NodeToScreen(grid: closestThing)) <= enemy.attackRange
                {
                    if(isUnit){GameplayManager.instance.battle( attacker : enemy, defender: closestUnit! )}
                    else{GameplayManager.instance.battle( attacker : enemy, target: closestBuilding! )}
                }
            }
        }
        
        let unitTypes : [UnitType] = [UnitType.Fighter, UnitType.Knight, UnitType.Mage]

        var unit : Unit

        for building in buildings
        {
            if building.buildingOwner == Owner.Opponent
            {
                if building.buildingType == BuildingType.HeadQuarter
                {
                    var pos = CGPoint( x: CGFloat(building.address.x), y: CGFloat(building.address.y) )

                    switch(unitTypes[Int.random(in: 0..<unitTypes.count)] )
                    {
                    case UnitType.Fighter:
                        unit = Fighter( parent: tileMap!, pos : pos , owner : Owner.Opponent )
                    case .Knight:
                        unit = Knight( parent: tileMap!, pos : pos , owner : Owner.Opponent )
                    case .Mage:
                        unit = Mage( parent: tileMap!, pos : pos , owner : Owner.Opponent )
                    default:
                        unit = Fighter( parent: tileMap!, pos : pos , owner : Owner.Opponent )
                    }
                    unit.hasMoved = true
                    enemies.append(unit)
                }
            }
        }
        enemyTurn = false
    }
}
