//
//  GameScene.swift
//  Drac
//
//  Created by Rico Zuniga on 1/9/15.
//  Copyright (c) 2015 Ulap. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let card = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 49, height: 70))
            let suit = SKSpriteNode(imageNamed:"heart")
            let rank = SKSpriteNode(imageNamed:"king-red")

            card.position = location
            
            let qWidth = card.frame.width / 4
            let qHeight = card.frame.height / 4
            
            suit.position = CGPoint(x:qWidth, y:qHeight);
            rank.position = CGPoint(x:-qWidth, y:qHeight);
            
            self.addChild(card)
            card.addChild(suit)
            card.addChild(rank)

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
