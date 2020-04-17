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
    var backButton : SKSpriteNode?
    //var workshopButton : SKSpriteNode?
    //var attackButton : SKSpriteNode?
    
    var touchDownPoint: CGPoint?
    var mapDragStart: CGPoint?
    var dragging : Bool = false
    
    var tileMap : SKTileMapNode?

    
    var workshopScene : SKNode?
    var attackScene : SKNode?
    
    let screenSize = UIScreen.main.bounds
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
     
        backButton = self.childNode( withName : "BackButton" ) as! SKSpriteNode
        //workshopButton = self.childNode( withName : "WorkshopSceneButton" ) as! SKSpriteNode
        //attackButton = self.childNode( withName : "AttackSceneButton" ) as! SKSpriteNode
        
        tileMap = self.childNode( withName : "Tile Map Node" ) as! SKTileMapNode
        
        let playerHome = Headquarter( parent: tileMap!, image: "player-base.png", pos : CGPoint( x: -100, y: -200 ), size: CGSize( width: 128, height: 128 ) )
        let enemyHome = EnemyBase( parent: tileMap!, image: "tower-flag.png", pos : CGPoint( x: 100, y: 200 ), size: CGSize( width: 128, height: 128 ) )
        buildings.append( playerHome )
        buildings.append( enemyHome )

        let unit1 = Unit( parent: tileMap!, type : UnitType.Fighter, pos : CGPoint( x : 0, y : -100 ), size : CGSize( width: 64, height: 64 ), damage: 10, health : 100 )
        let unit2 = Unit( parent: tileMap!, type : UnitType.Knight, pos : CGPoint( x : 0, y : 100 ), size : CGSize( width: 64, height: 64 ), damage: 10, health : 100 )
        units.append(unit1)
        units.append(unit2)
        
        self.currentUnit = unit1

        let enemy1 = EnemyUnit( parent: tileMap!, type : UnitType.Fighter, pos : CGPoint( x : 100, y : 100 ), size : CGSize( width: 64, height: 64 ), damage: 10, health : 100 )
        let enemy2 = EnemyUnit( parent: tileMap!, type : UnitType.Mage, pos : CGPoint( x : 200, y : 100 ), size : CGSize( width: 64, height: 64 ), damage: 10, health : 100 )
        enemies.append(enemy1)
        enemies.append(enemy2)
        
        Pathfinding.instance.generateGraph(tileMap: &tileMap!)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        //var screenSpace = Pathfinding.instance.screenToMap(tap: pos)
        //var tileSpace = Pathfinding.instance.MapToNode(pos: screenSpace)
        //print(tileMap?.tileDefinition(atColumn: Int(tileSpace.x), row: Int(tileSpace.y))?.name)
        if backButton!.contains(pos) {
            let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
            let gameScene = SKScene(fileNamed: "MainMenuScene" )!
            self.view?.presentScene( gameScene, transition: transition )
        }
        /*
        else if (workshopButton?.contains( pos ))! {
            if workshopScene == nil {
                workshopScene = WorkshopScene( parent : self )
            }
        } else if (attackButton?.contains( pos ))! {
            if attackScene == nil {
                attackScene = AttackScene( parent : self )
            }
        } */
        else {
            var isProcessed = false
            if self.currentPopup != nil {
                if self.currentPopup!.onTouchDown( pos : pos ) {
                    self.currentPopup = nil
                    isProcessed = true
                }
            }
            
            let map_pos = self.convert(pos, to: self.tileMap!)
            for building in buildings {
                if building.contains(map_pos) {
                    building.onInteract()
                    isProcessed = true
                    break
                }
            }
            if isProcessed == false {
                for unit in units {
                    if unit.contains(map_pos) {
                        unit.onInteract()
                        isProcessed = true
                        break
                    }
                }
            }
            if isProcessed == false {
                for enemy in enemies {
                    if enemy.contains(map_pos) {
                        if self.currentPopup == nil {
                            //enemy.onInteract()
                            // just for testing
                            //self.currentPopup = UnitInfoPopup( parent : self, unit : enemy )
                            self.currentPopup = AttackPopup( parent : self, size : CGSize( width: 600, height: 600 ), attacker : self.currentUnit!, defender : enemy )
                            //popups.append(unitPopup)
                            isProcessed = true
                            break
                        }
                    }
                }
            }
            
            if isProcessed == false {
                touchDownPoint = pos
                mapDragStart = tileMap?.position
                backButton?.isHidden = true
                dragging = true
                

                if workshopScene != nil {
                    workshopScene?.removeFromParent()
                    workshopScene = nil
                }
                if attackScene != nil {
                    attackScene?.removeFromParent()
                    attackScene = nil
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
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for unit in self.units {
            //unit.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
