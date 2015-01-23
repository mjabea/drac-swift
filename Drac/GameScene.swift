//
//  GameScene.swift
//  Drac
//
//  Created by Rico Zuniga on 1/9/15.
//  Copyright (c) 2015 Ulap. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var movingCard:Card? = nil
    var origPosition = CGPoint()
    var offset = CGPoint()
    var topMost = CGFloat(1.0)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        for i in 1...20 {
            let card = Card()
            card.position = CGPoint(x:Int(arc4random_uniform(UInt32(self.frame.width))), y:Int(arc4random_uniform(UInt32(self.frame.height))));
            self.addChild(card)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            func startMove() {
                origPosition = (movingCard?.position)!
                
                offset = CGPoint(x:origPosition.x - location.x, y:origPosition.y - location.y)
                movingCard?.zPosition = topMost
                topMost += 1.0
            }
            
            if self.nodeAtPoint(location) is Card {
                movingCard = self.nodeAtPoint(location) as? Card
                startMove()
            } else if let p = self.nodeAtPoint(location).parent {
                if p is Card {
                    movingCard = p as? Card
                    startMove()
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            movingCard?.position = CGPoint(x:location.x + offset.x, y:location.y + offset.y)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if let mc = movingCard {
            
            let move = SKAction.moveTo(origPosition, duration: 0.15)
            mc.runAction(move)
            movingCard = nil
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        if let mc = movingCard {
            let move = SKAction.moveTo(origPosition, duration: 0.5)
            mc.runAction(move)
            movingCard = nil
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
