//
//  Card.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import Foundation
import SpriteKit

/*
    Card class stores data and image for card node object in game
*/
class Card : SKSpriteNode {
    var suit = "";
    var value = 0;
    
    /*
        Required for SKSpriteNode
    */
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    /*
        checks and chnages card name based on special cases
        assigns values and image reference based on which card it is.
        Card images obtained from: http://opengameart.org/content/playing-cards-vector-png
    */
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