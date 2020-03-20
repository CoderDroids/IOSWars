//
//  ModelActor.swift
//  IOS Wars
//
//  Created by Younggi Kim on 2020-02-14.
//  Copyright © 2020 Mark Meritt. All rights reserved.
//

import SpriteKit
import UIKit

class ModelActor : SKSpriteNode
{
    convenience init( parent : SKNode, atlasName : String, imageName : String, position : CGPoint, scale : CGFloat )
    {
        self.init( atlasName : atlasName, imageName : imageName )
        self.position = position
        self.setScale( scale )
        parent.addChild( self )
    }
    
    init( atlasName : String, imageName : String )
    {
        let atlas = SKTextureAtlas( named: atlasName )
        let texture =  atlas.textureNamed(imageName)

        super.init( texture : texture, color : UIColor.clear, size: texture.size() )
    }
    
    init( texture : SKTexture )
    {
        super.init( texture : texture, color : UIColor.clear, size: texture.size() )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadTextures( atlas : String ) -> [SKTexture] {
        let atlas = SKTextureAtlas( named: atlas )
        var textures = atlas.textureNames
        textures.sort()
        var frames : [SKTexture] = []
        for name in textures {
            frames.append( atlas.textureNamed(name) )
        }
        return frames
    }
    
    func loadTextures( atlas : String, textureNames : [String] ) -> [SKTexture] {
        let atlas = SKTextureAtlas( named: atlas )
        var textures : [SKTexture] = []
        for name in textureNames {
            textures.append( atlas.textureNamed(name) )
        }
        return textures
    }
    
    func getTexture( atlas : String, name : String ) -> SKTexture {
        let atlas = SKTextureAtlas( named: atlas )
        return atlas.textureNamed(name)
    }
    
    func loadAnimation( atlas : String ) -> SKAction {
        let frames = loadTextures( atlas : atlas )
        return SKAction.animate(with: frames, timePerFrame: 0.1)
    }
}
