//
//  GameScene.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright (c) 2015 20063321. All rights reserved.
//

import SpriteKit
enum turn {
    case PlayerTurn
    case DealerTurn
}
let suits = ["hearts","clubs","spades","diamonds"]
var deck: [Card] = []
var player : Player = Player()
var dealer : Player = Player()
class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        
        deckSetUp()
        gameSetUp()
        
        for var i = 0; i < player.handSize; i += 1 {
            player.hand[i].xScale = 0.1
            player.hand[i].yScale = 0.1
            player.hand[i].position = CGPointMake(500 + (10 * CGFloat(i)),200)
            self.addChild(player.hand[i])
            
        }
        
        /* Setup your scene here */
        /*let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)*/
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            /*let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)*/
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func shuffle (var array: [Card]) ->  [Card]{
        for var i = array.count-1; i > 0 ; i-- {
            let j = Int(arc4random_uniform(UInt32(i-1)))
            swap(&array[i], &array[j])
        }
        return array
    }
    
    func deckSetUp(){
        for suit in suits{
            for var i = 1; i < 14; i++ {
                deck.append(Card(suitName: suit, cardValue: i))
            }
        }
        deck = shuffle(deck)
    }
    func draw() -> Card {
        return deck.removeLast()
    }
    func gameSetUp(){
        player.hand.append(draw())
        player.handSize++
        player.updateInfo()
        dealer.hand.append(draw())
        dealer.handSize++
        dealer.updateInfo()
        
    }
}
