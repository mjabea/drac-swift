//
//  Card.swift
//  Drac
//
//  Created by Rico Zuniga on 1/21/15.
//  Copyright (c) 2015 Ulap. All rights reserved.
//

import SpriteKit

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spade"
        case .Hearts:
            return "heart"
        case .Diamonds:
            return "diamond"
        case .Clubs:
            return "club"
        }
    }
}

class Card: SKSpriteNode {
    
    let rank:Rank!
    let suit:Suit!
    
    // create a random Card
    override init() {
        super.init(texture: SKTexture(imageNamed:"card-default"), color: nil, size: SKTexture(imageNamed:"card-default").size())
        self.rank = randomRank()
        self.suit = randomSuit()
        render()
    }
    
    init(rank:Rank, suit:Suit) {
        super.init(texture: SKTexture(imageNamed:"card-default"), color: nil, size: SKTexture(imageNamed:"card-default").size())
        self.rank = rank
        self.suit = suit
        render()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    func render() {
        let colorizer = self.suit.simpleDescription() == "club" || self.suit.simpleDescription() == "spade" ? SKColor.blackColor() : SKColor.redColor()
        
        let suit = SKSpriteNode(imageNamed:self.suit.simpleDescription())
        suit.color = colorizer
        suit.colorBlendFactor = 1.0
        suit.xScale = 0.75
        suit.yScale = 0.75
        
        let rank = SKSpriteNode(imageNamed:self.rank.simpleDescription())
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
    
    func randomRank() -> Rank {
        let ranks:[Rank] = [.Ace, .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten, .Jack, .Queen, .King]
        let count = UInt32(ranks.count)
        let rank = Int(arc4random_uniform(count))
        return ranks[rank]
    }

    func randomSuit() -> Suit {
        let suits:[Suit] = [.Clubs, .Spades, .Hearts, .Diamonds]
        let count = UInt32(suits.count)
        let suit = Int(arc4random_uniform(count))
        return suits[suit]
    }

}