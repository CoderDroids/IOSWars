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
        Pathfinding.instance.generateGraph(tileMap: &tileMap!)
        
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
        let unit3 = Mage( parent: tileMap!, pos : CGPoint( x: 14, y: 10 ), owner : Owner.Player )
        units.append(unit1)
        units.append(unit2)
        units.append(unit3)
        
        self.currentUnit = unit1

        let enemy1 = Fighter( parent: tileMap!, pos : CGPoint( x: 18, y: 20 ), owner : Owner.Opponent )
        let enemy2 = Knight( parent: tileMap!, pos : CGPoint( x: 17, y: 18 ), owner : Owner.Opponent )
        enemies.append(enemy1)
        enemies.append(enemy2)
        
        GameplayManager.instance.game = self
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if backButton!.contains(pos) {
            let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
            let gameScene = SKScene(fileNamed: "MainMenuScene" )!
            self.view?.presentScene( gameScene, transition: transition )
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
                if isProcessed == false && self.popups.count == 0 {
                    for unit in units {
                        if unit.contains(map_pos) {
                            Pathfinding.instance.tintTiles(pos: pos,range: unit.movementRange)
                            isProcessed = true
                            break
                        }
                    }
                }
                if isProcessed == false {
                    for enemy in enemies {
                        if enemy.contains(map_pos) {
                            if self.currentPopup == nil {
                                let attackPopup = AttackPopup( parent : self, size : CGSize( width: 600, height: 600 ), attacker : self.currentUnit!, defender : enemy )
                                popups.append(attackPopup)
                                isProcessed = true
                                break
                            }
                        }
                    }
                }
                for building in buildings {
                    if building.contains(map_pos) {
                        building.onInteract()
                        isProcessed = true
                        break
                    }
                }
            }
            
            if isProcessed == false {
                touchDownPoint = pos
                mapDragStart = tileMap?.position
                backButton?.isHidden = true
                dragging = true
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
        //Pathfinding.instance.clearTintedTiles()
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
