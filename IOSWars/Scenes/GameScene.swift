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
    var units = [SKNode]()

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
    
    var playerHome : Building?
    var enemyHome : Building?
    
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
        
        playerHome = Building( parent: tileMap!, image: "player-base.png", pos : CGPoint( x: -100, y: -200 ), size: CGSize( width: 64, height: 64 ) )
        enemyHome = Building( parent: tileMap!, image: "tower-flag.png", pos : CGPoint( x: 100, y: 200 ), size: CGSize( width: 64, height: 64 ) )
 
        buildings.append( playerHome! )
        buildings.append( enemyHome! )
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
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
            var isProcessed : Bool = false
            var map_pos = self.convert(pos, to: self.tileMap!)
            print("pos = ", pos, " map_pos = ", map_pos )
            for building in buildings {
                if building.contains(map_pos) {
                    building.onTouch()
                    isProcessed = true
                    break
                }
            }
            
            if isProcessed == false {
                touchDownPoint = pos
                mapDragStart = tileMap?.position
                //attackButton?.isHidden = true
                //workshopButton?.isHidden = true
                backButton?.isHidden = true
                dragging = true
                
                //print("POS: x: %f , y: %f",touchDownPoint!.x,touchDownPoint!.y);
                //print("MAP: x: %f , y: %f",mapDragStart!.x,mapDragStart!.y);

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
            if(abs((tileMap?.position.x)!) > abs(((tileMap?.mapSize.width)! - screenSize.width)/2))
            {
                tileMap?.position = CGPoint(x: ((tileMap?.position.x)! < 0 ? -1 : 1) * abs(((tileMap?.mapSize.width)! - screenSize.width)/2),y:(tileMap?.position.y)!)
            }
            //protects against dragging off map in y axis
            if(abs((tileMap?.position.y)!) > abs(((tileMap?.mapSize.height)! - screenSize.height)/2))
            {
                tileMap?.position = CGPoint(x:(tileMap?.position.x)! ,y:  ((tileMap?.position.y)! < 0 ? -1 : 1) * abs(((tileMap?.mapSize.height)! - screenSize.height)/2))
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //attackButton?.isHidden = false
        //workshopButton?.isHidden = false
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
