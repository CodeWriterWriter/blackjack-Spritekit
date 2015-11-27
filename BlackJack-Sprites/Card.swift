//
//  Card.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import Foundation
import SpriteKit

class Card : SKSpriteNode {
    var suit = "";
    var value = 0;
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(suitName: String, cardValue : Int){
        var title = ""
        if (cardValue == 1)
        {
            title = "ace"
        }
        else if (cardValue == 11){
            title = "jack"
        }
        else if (cardValue == 12){
            title = "queen"
        }
        else if (cardValue == 13){
            title = "king"
        }
        else {
            title = String(cardValue)
        }
        let imageNamed = "PNG-cards-1.3/" + title + "_of_" + suitName + ".png"
        let cardTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: cardTexture, color: UIColor.clearColor(), size: cardTexture.size())
        suit = suitName
        value = cardValue
    }
}