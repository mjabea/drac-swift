//
//  Card.swift
//  Drac
//
//  Created by Rico Zuniga on 1/21/15.
//  Copyright (c) 2015 Ulap. All rights reserved.
//

import SpriteKit

class Card: SKSpriteNode {
    
    // create a random Card
    override init() {
        super.init(texture: SKTexture(imageNamed:"card-default"), color: nil, size: SKTexture(imageNamed:"card-default").size())
        
        let suitImage = randomSuit()
        let colorizer = suitImage == "club" || suitImage == "spade" ? SKColor.blackColor() : SKColor.redColor()

        let suit = SKSpriteNode(imageNamed:suitImage)
        suit.color = colorizer
        suit.colorBlendFactor = 1.0
        suit.xScale = 0.75
        suit.yScale = 0.75
        
        let rank = SKSpriteNode(imageNamed:self.randomRank())
        rank.color = colorizer
        rank.colorBlendFactor = 1.0
        rank.xScale = 0.75
        rank.yScale = 0.75
        
        let qWidth = self.frame.width / 5
        let qHeight = self.frame.height / 4
        
        suit.position = CGPoint(x:qWidth, y:qHeight);
        rank.position = CGPoint(x:-qWidth, y:qHeight);
        
        self.addChild(suit)
        self.addChild(rank)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    func randomRank() -> String {
        let ranks = ["ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
        let count = UInt32(ranks.count)
        let rank = Int(arc4random_uniform(count))
        return ranks[rank]
    }

    func randomSuit() -> String {
        let suits = ["club", "spade", "heart", "diamond"]
        let count = UInt32(suits.count)
        let suit = Int(arc4random_uniform(count))
        return suits[suit]
    }

}