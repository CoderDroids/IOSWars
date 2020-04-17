//
//  pathfinding.swift
//  IOSWars
//
//  Created by Ted Bissada on 2020-04-17.
//  Copyright © 2020 CoderDroids. All rights reserved.
//
import Foundation
import GameplayKit

class Pathfinding
{
    static let instance = Pathfinding()
    let screenSize = UIScreen.main.bounds
    var myGraph : GKGridGraph<GKGridGraphNode>?
    var map : SKTileMapNode?
    
    private init(){}
    
    func generateGraph( tileMap: inout SKTileMapNode)
    {
        map = tileMap
        myGraph = GKGridGraph(fromGridStartingAt: vector_int2(0,0), width: Int32(tileMap.numberOfColumns), height: Int32(tileMap.numberOfColumns), diagonalsAllowed: false)
        var obstacles = [GKGridGraphNode]()

        for column in 0..<tileMap.numberOfColumns
        {
            for row in 0..<tileMap.numberOfRows
            {
                let tile = tileMap.tileDefinition(atColumn: column, row: row)
                if tile?.name == "Water"
                {
                    let pos: vector_int2 = vector_int2(Int32(row),Int32(column))
                    obstacles.append(myGraph!.node(atGridPosition: pos)!)
                }
            }
        }
        myGraph!.remove(obstacles)
    }
    
    func getPath(from: CGPoint, to: CGPoint)->[CGPoint] // this should use coordinates in map space
    {
        let startPoint = MapToNode(pos: from)
        let endPoint = MapToNode(pos: to)
        let pathNodes: [GKGridGraphNode] = myGraph!.findPath(from: myGraph!.node(atGridPosition: startPoint)!,to: myGraph!.node(atGridPosition: endPoint)!) as! [GKGridGraphNode]
        var pathPoints: [CGPoint] = []
        for point in pathNodes
        {
            pathPoints.append(NodeToMap(grid: point.gridPosition))
        }
        return pathPoints
    }
    
    private func NodeToMap(grid:vector_int2)->CGPoint //converts node coordinates to tile map space
    {
        return (map?.centerOfTile(atColumn: Int(grid.x), row: Int(grid.y)))!
    }
    
    private func MapToNode(pos:CGPoint)->vector_int2 //converts map to pathfinding nodes
    {
        let xCord :Int =   Int(Float(pos.x)/(Float((map?.xScale)!) * (Float((map?.tileSize.width)!))))
        let yCord :Int =   Int(Float(pos.y)/(Float((map?.yScale)!) * (Float((map?.tileSize.height)!))))
        return vector_int2(Int32(xCord),Int32(yCord))
    }
    
    func screenToMap(tap:CGPoint)->CGPoint //converts screen space aka tap coordinates to map coordinates
    {
        return CGPoint(x:((tap.x - (map?.position.x)!)+abs((map?.mapSize.width)!/(2*(1/(map?.xScale)!))))
            ,y:((tap.y - (map?.position.y)!)+abs((map?.mapSize.height)!/(2*(1/(map?.yScale)!)))))
    }
}
