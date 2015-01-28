//
//  GameScene.swift
//  Drac
//
//  Created by Rico Zuniga on 1/9/15.
//  Copyright (c) 2015 Ulap. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var movingCard:SKNode? = nil
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
            
            let node = self.nodeAtPoint(location)
            
            if  node.isKindOfClass(Card) {
                if let p = node.parent {
                    if p.isKindOfClass(SKNode) {
                        if p.isEqual(self) {
                            movingCard = node
                        } else {
                            movingCard = p
                        }
                    }
                }
                
                startMove()
            } else if let p = node.parent {
                if p.isKindOfClass(Card) {
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
            
            var targetPosition = origPosition
            
            // find the nodes that overlapped
            var intersections:[Card] = []
            for card in self.children {
                if card.isEqual(mc) {
                    continue
                }
                
                if card.intersectsNode(mc) {
                    intersections.append(card as Card)
                }
            }
            
            // find which one has the most overlap
            var highestOverlap:Card? = nil
            if intersections.count > 0 {
                highestOverlap = intersections[0]
                for intersection in intersections {
                    var overlap = CGRectUnion(mc.frame, intersection.frame)
                    if overlap.size.width * overlap.size.height < (highestOverlap?.size.width)! * (highestOverlap?.size.height)! {
                        highestOverlap = intersection
                    }
                }
                
                targetPosition = (highestOverlap?.position)!
                targetPosition.x += 10
            }
            
            // add the moving card to the overlapped card as a child
            func transfer() {
                if let ho = highestOverlap {
                    mc.removeFromParent()
                    ho.removeFromParent()
                    let container = SKNode()
                    container.addChild(ho)
                    container.addChild(mc)
                    self.addChild(container)
                }
            }
            
            let move = SKAction.moveTo(targetPosition, duration: 0.15)
            mc.runAction(move, completion: transfer)
            movingCard = nil
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
