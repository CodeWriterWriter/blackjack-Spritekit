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
        for card in hand {
            if (card.value > 10){
                localValue += 10
            }
            else {
                localValue += card.value
            }
            var temp = ""
            if (card.value > 10)
            {
                if (card.value == 11){
                    temp = "Jack"
                }
                else if (card.value == 12){
                    temp = "Queen"
                }
                else if (card.value == 13){
                    temp = "King"
                }
                //hand += card.suit + ": " + temp + " "
            }
            else {
                //hand += card.suit + ": " + String(card.value) + " "
            }
        }
        value = localValue
    }
}