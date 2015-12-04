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
enum gameState {
    case Ongoing
    case Finished
}
let suits = ["hearts","clubs","spades","diamonds"]
var deck: [Card] = []
var player : Player = Player()
var dealer : Player = Player()
var currentTurn = turn.PlayerTurn
var currentGameState   = gameState.Ongoing
class GameScene: SKScene {
    
    let hitButton = SKSpriteNode(imageNamed:"PNG-cards-1.3/hit.png")
    let stayButton = SKSpriteNode(imageNamed: "PNG-cards-1.3/stay.png")
    let resetButton = SKSpriteNode(imageNamed: "PNG-cards-1.3/reset.png")
    
    override func didMoveToView(view: SKView) {
        
        
        hitButton.position = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame))
        hitButton.xScale = 0.1
        hitButton.yScale = 0.1
        hitButton.name = "hit"
        self.addChild(hitButton)
        
        stayButton.position = CGPointMake(CGRectGetMidX(self.frame) , CGRectGetMidY(self.frame))
        stayButton.xScale = 0.1
        stayButton.yScale = 0.1
        stayButton.name = "stay"
        self.addChild(stayButton)
        
        resetButton.position = CGPointMake(CGRectGetMidX(self.frame) + 100 , CGRectGetMidY(self.frame))
        resetButton.xScale = 0.1
        resetButton.yScale = 0.1
        resetButton.name = "reset"
        self.addChild(resetButton)
        
        
        
        

        
        deckSetUp()
        gameSetUp()
        
        for var i = 0; i < player.handSize; i += 1 {
            player.hand[i].xScale = 0.1
            player.hand[i].yScale = 0.1
            player.hand[i].position = CGPointMake(400 + (100 * CGFloat(i)),200)
            self.addChild(player.hand[i])
            
        }
        
        for var i = 0; i < dealer.handSize; i += 1 {
            dealer.hand[i].xScale = 0.1
            dealer.hand[i].yScale = 0.1
            dealer.hand[i].position = CGPointMake(400 + (100 * CGFloat(i)),600)
            self.addChild(dealer.hand[i])
            
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
            let location = touch.locationInNode(self)
            let node =  self.nodeAtPoint(location)
            
            if (node.name == "hit"){
                if (currentGameState == gameState.Ongoing){
                    if (currentTurn == turn.DealerTurn) {}
                    else{
                        player.hand.append(draw())
                        player.updateInfo()
                        player.hand.last?.xScale = 0.1
                        player.hand.last?.yScale = 0.1
                        player.hand.last?.position = CGPointMake(400 + (50 * CGFloat(player.handSize-1)),200)
                        self.addChild(player.hand.last!)
                        
                        print("" + String(player.value))
                    }
                    if (player.value > 21)
                    {
                        currentGameState = gameState.Finished
                        let myLabel = SKLabelNode(fontNamed:"Helvetica")
                        myLabel.text = "You Lose";
                        myLabel.fontSize = 45;
                        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
                        
                        self.addChild(myLabel)

                        
                    }
                    else if (player.handSize >= 5){
                        currentGameState = gameState.Finished
                        let myLabel = SKLabelNode(fontNamed:"Helvetica")
                        myLabel.text = "You Win";
                        myLabel.fontSize = 45;
                        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
                        
                        self.addChild(myLabel)

                    }
                }
            }
            if (node.name == "stay")
            {
                let myLabel = SKLabelNode(fontNamed:"Helvetica")
                myLabel.text = "";
                myLabel.fontSize = 45;
                myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
                
                self.addChild(myLabel)
                if (currentGameState == gameState.Ongoing){
                    if (currentTurn == turn.DealerTurn) {}
                    else {
                        currentTurn = turn.DealerTurn
                        while (dealer.value < 16){
                            dealer.hand.append(draw())
                            dealer.updateInfo()
                            print(String(dealer.value))
                            dealer.hand.last?.xScale = 0.1
                            dealer.hand.last?.yScale = 0.1
                            dealer.hand.last?.position = CGPointMake(400 + (50 * CGFloat(dealer.handSize-1)),600)
                            self.addChild(dealer.hand.last!)
                        }
                        currentGameState = gameState.Finished
                        if (((dealer.value > player.value) && !(dealer.value > 21)) || (player.value > 21) || ((dealer.handSize >= 5) && !(dealer.value > 21) ))
                        {
                            myLabel.text = "You Lost"
                        }
                        else if (dealer.value == player.value)
                        {
                            myLabel.text = "You Tied"
                        }
                        else
                        {
                            myLabel.text = "You Win"
                        }
                    }
                }
            }
            if (node.name == "reset")
            {
                self.reset()
            }
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
    
    func reset(){
        self.removeAllChildren()
        self.removeAllActions()
        self.view?.presentScene(self)
    }
    
    func shuffle (var array: [Card]) ->  [Card]{
        for var i = array.count-1; i > 0 ; i-- {
            let j = Int(arc4random_uniform(UInt32(i-1)))
            swap(&array[i], &array[j])
        }
        return array
    }
    
    func deckSetUp(){
        deck.removeAll()
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
        currentTurn = turn.PlayerTurn
        currentGameState = gameState.Ongoing
        player.hand.removeAll()
        player.hand.append(draw())
        player.updateInfo()
        dealer.hand.removeAll()
        dealer.hand.append(draw())
        dealer.updateInfo()
        
    }
}
