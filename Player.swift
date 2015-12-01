//
//  Player.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import Foundation

class Player {
    var hand :[Card] = []
    var value = 0
    var handSize = 0
    
    
    func updateInfo() {
        var localValue = 0
        handSize = hand.count
        for card in hand {
            if (card.value > 10){
                localValue += 10
            }
            else {
                localValue += card.value
            }
        }
        value = localValue
    }
}