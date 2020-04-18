//
//  MainMenuScene.swift
//  IOSWars
//
//  Created by Younggi Kim on 2020-02-13.
//  Copyright © 2020 CoderDroids. All rights reserved.
//

import SpriteKit


class OptionScene: SKScene {
    var helpButton : SKSpriteNode!
    var backButton : SKSpriteNode!
    
    var effectSlider : UISlider!
    var musicSlider : UISlider!

    
    override func didMove(to view: SKView )
    {
        helpButton = self.childNode( withName : "HelpButton" ) as! SKSpriteNode
        backButton = self.childNode( withName : "BackButton" ) as! SKSpriteNode

        let h = UIScreen.main.bounds.height
        
        effectSlider = UISlider(frame: CGRect(x: 200, y: h * 0.48, width: 100, height: 15))
        effectSlider.isContinuous = true
        effectSlider.maximumValue = 1.0
        effectSlider.minimumValue = 0.0
        effectSlider.value = Audio.instance.getEffectVolume()
        effectSlider.addTarget(self, action:#selector(effectSliderControl(sender:)), for: .valueChanged)

        musicSlider = UISlider(frame: CGRect(x: 200, y: h * 0.37, width: 100, height: 15))
        musicSlider.isContinuous = true
        musicSlider.maximumValue = 1.0
        musicSlider.minimumValue = 0.0
        musicSlider.value = Audio.instance.getMusicVolume()
        musicSlider.addTarget(self, action:#selector(musicSliderControl(sender:)), for: .valueChanged)


        view.addSubview(effectSlider)
        view.addSubview(musicSlider)
    }
    
    override func willMove(from view: SKView) {
        effectSlider.removeFromSuperview()
        musicSlider.removeFromSuperview()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        let touch = touches.first
        if let location = touch?.location( in: self )
        {
            if helpButton.contains(location) {
                Audio.instance.playEffect(name: "click")
            } else if backButton.contains(location) {
                Audio.instance.playEffect(name: "click")
                let transition = SKTransition.flipHorizontal( withDuration: 0.5 )
                let gameScene = SKScene(fileNamed: "MainMenuScene" )!
                self.view?.presentScene( gameScene, transition: transition )
            }
        }
    }
    
    @IBAction func effectSliderControl(sender: UISlider)
    {
        Audio.instance.setEffectVolume(volume: effectSlider.value)
    }
    
    @IBAction func musicSliderControl(sender: UISlider)
    {
        Audio.instance.setMusicVolume(volume: musicSlider.value)
    }

}
