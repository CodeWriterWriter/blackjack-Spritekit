//
//  Player.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright © 2015 20063321. All rights reserved.
//

import Foundation
/*
        Player class stores player and dealer data
*/
class Player {
    var hand :[Card] = []
    var aces = 0
    var value = 0
    var handSize = 0
    
    /*
        Updates player data and changes face card values to match their in game value
    */
    func updateInfo() {
        var localValue = 0
        handSize = hand.count
        for card in hand {
            if (card.value > 10){
                localValue += 10
            }
            else {
                if (card.value == 1)
                {
                    aces++;
                    localValue += 11
                }
                else
                {
                    localValue += card.value
                }
            }
        }
        value = localValue
        checkAces()
    }
    
    /*
        Checks if player is bust due to an ace, and changes value of ace to 1 if they are
    */
    func checkAces() {
        if ((value > 21) && (aces > 0))
        {
            value -= 10;
            aces--;
        }
    }
}