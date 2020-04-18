//
//  pathfinding.swift
//  IOSWars
//
//  Created by Ted Bissada on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//
import Foundation
import GameplayKit
import CoreImage


class Pathfinding
{
    static let instance = Pathfinding()
    let screenSize = UIScreen.main.bounds
    var myGraph : GKGridGraph<GKGridGraphNode>?
    
    var map : SKTileMapNode?
    

    var drawContext : CIContext?
    
    var tintedNodes: [tintedSquare]

    
    private init()
    {tintedNodes = []}
    
    func generateGraph(e: inout [Unit],u: inout [Unit],b: inout [Building])
    {
        
        myGraph = GKGridGraph(fromGridStartingAt: vector_int2(0,0), width: Int32(map!.numberOfColumns), height: Int32(map!.numberOfColumns), diagonalsAllowed: false)
        var obstacles = [GKGridGraphNode]()

        for column in 0..<map!.numberOfColumns
        {
            for row in 0..<map!.numberOfRows
            {
                let tile = map!.tileDefinition(atColumn: column, row: row)
                if (tile?.name == "Water_Grid_Center")
                {
                    let pos: vector_int2 = vector_int2(Int32(column),Int32(row))
                    obstacles.append(myGraph!.node(atGridPosition: pos)!)
                }
            }
        }
        
        for building in b
        {
            let pos = ScreenToNode(pos: building.position)
            obstacles.append(myGraph!.node(atGridPosition: pos)!)
        }
        
        for unit in u
        {
            let pos = ScreenToNode(pos: unit.position)
            obstacles.append(myGraph!.node(atGridPosition: pos)!)
        }
        for unit in e
        {
            let pos = ScreenToNode(pos: unit.position)
            obstacles.append(myGraph!.node(atGridPosition: pos)!)
        }

        myGraph!.remove(obstacles)
    }
    
    func loadMap(tileMap: inout SKTileMapNode)
    {
        map = tileMap
    }
    
    func getPath(from: CGPoint, to: CGPoint)->[CGPoint] // this should use coordinates in map space
    {
        let startPoint = ScreenToNode(pos: from)
        let endPoint = ScreenToNode(pos: to)
        
        let tempNode = GKGridGraphNode(gridPosition: startPoint)
        myGraph?.connectToAdjacentNodes(node: tempNode)

        let pathNodes: [GKGridGraphNode] = myGraph!.findPath(from: myGraph!.node(atGridPosition: startPoint)!,to: myGraph!.node(atGridPosition: endPoint)!) as! [GKGridGraphNode]
        var pathPoints: [CGPoint] = []
        for point in pathNodes
        {
            pathPoints.append(NodeToScreen(grid: point.gridPosition))
        }
        
        myGraph!.remove([tempNode])
        return pathPoints
    }
    
    func pathLength(from: vector_int2, to: vector_int2)->Int
    {
        if (myGraph!.node(atGridPosition: to) == nil || myGraph!.node(atGridPosition: from) == nil)
        {
            return 999
        }
        let pathNodes: [GKGridGraphNode] = myGraph!.findPath(from: myGraph!.node(atGridPosition: from)!,to: myGraph!.node(atGridPosition: to)!) as! [GKGridGraphNode]
        return pathNodes.count
    }
    
    func NodeToScreen(grid:vector_int2)->CGPoint //converts node coordinates to tile map space
    {
        return (map?.centerOfTile(atColumn: Int(grid.x), row: Int(grid.y)))!
        
    }
    
    private func MapToNode(pos:CGPoint)->vector_int2 //converts map to pathfinding nodes
    {
        
        let xCord :Int =   Int(Float(pos.x)/(Float((map?.xScale)!) * (Float((map?.tileSize.width)!))))
        let yCord :Int =   Int(Float(pos.y)/(Float((map?.yScale)!) * (Float((map?.tileSize.height)!))))
        return vector_int2(Int32(xCord),Int32(yCord))
    }

    private func screenToMap(tap:CGPoint)->CGPoint //converts screen space aka tap coordinates to map coordinates
    {
        return CGPoint(x:((tap.x - (map?.position.x)!)+abs((map?.mapSize.width)!/(2*(1/(map?.xScale)!))))
            ,y:((tap.y - (map?.position.y)!)+abs((map?.mapSize.height)!/(2*(1/(map?.yScale)!)))))
    }
    
    func ScreenToNode(pos:CGPoint)->vector_int2
    {
        let xVal :Int = (map?.tileColumnIndex(fromPosition: pos))!
        let yVal :Int = (map?.tileRowIndex(fromPosition: pos))!
        return vector_int2(Int32(xVal),Int32(yVal))
    }
    
    func tintTiles(pos:CGPoint, range:Int)
    {
        let tileSize = CGSize(width: 0.8 * (map?.tileSize.width)!,height: 0.8 * (map?.tileSize.height)!)
        let gridPoint = MapToNode(pos:screenToMap(tap: pos))
        
        
       let tempNode = GKGridGraphNode(gridPosition: gridPoint)
        myGraph?.connectToAdjacentNodes(node: tempNode)
        
        for i in -range...range
        {
            for q in -range...range
            {
                if (pathLength(from: gridPoint, to: vector_int2(gridPoint.x + Int32(i),gridPoint.y+Int32(q))) <= range)
                {
                    tintTile(pos: vector_int2(gridPoint.x + Int32(i),gridPoint.y+Int32(q)), size: tileSize)
                }
            }
        }
        myGraph!.remove([tempNode])
    }
    
    private func tintTile(pos: vector_int2, size :CGSize)
    {
        let loc = NodeToScreen(grid: pos)
        tintedNodes.append(tintedSquare( parent: map!, pos : loc, size: size))
    }
    
    func clearTintedTiles()
    {
        print("removed tint")
        for node in tintedNodes
        {
            node.removeFromParent()
        }
        tintedNodes.removeAll()
    }
}
