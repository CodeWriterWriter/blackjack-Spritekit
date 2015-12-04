//
//  GameScene.swift
//  BlackJack-Sprites
//
//  Created by 20063321 on 27/11/2015.
//  Copyright (c) 2015 20063321. All rights reserved.
//

/*
    Main class where logic is run
*/

import SpriteKit

/*
    Enums for turn and gameState to keep track of game state
    Followed by necessary variables for functioning
*/
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
    
    /*
        Declare constant buttons and their image files
    */
    let hitButton = SKSpriteNode(imageNamed:"PNG-cards-1.3/hit.png")
    let stayButton = SKSpriteNode(imageNamed: "PNG-cards-1.3/stay.png")
    let resetButton = SKSpriteNode(imageNamed: "PNG-cards-1.3/reset.png")
    
    override func didMoveToView(view: SKView) {
        /*
            Adds labels to show which side belongs to which player
        */
        let dealerLabel = SKLabelNode(fontNamed:"Helvetica")
        dealerLabel.text = "Dealer";
        dealerLabel.fontSize = 45;
        dealerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 700);
        
        self.addChild(dealerLabel)
        
        let playerLabel = SKLabelNode(fontNamed:"Helvetica")
        playerLabel.text = "Player";
        playerLabel.fontSize = 45;
        playerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 100);
        
        self.addChild(playerLabel)
        
        /*
            On move to scene sets data for the buttons
        */
        
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
        
        self.backgroundColor = UIColor(red: 0.0, green: 102/255.0, blue: 0.0, alpha: 1.0)
        
        
        /*
            Variable Set up
        */
        
        deckSetUp()
        gameSetUp()
        
        /*
            Adds a card to dealer and player hand and draws them
        */
        for var i = 0; i < player.handSize; i += 1 {
            player.hand[i].xScale = 0.125
            player.hand[i].yScale = 0.125
            player.hand[i].position = CGPointMake(350 + (50 * CGFloat(i)),200)
            self.addChild(player.hand[i])
            
        }
        
        for var i = 0; i < dealer.handSize; i += 1 {
            dealer.hand[i].xScale = 0.125
            dealer.hand[i].yScale = 0.125
            dealer.hand[i].position = CGPointMake(350 + (50 * CGFloat(i)),600)
            self.addChild(dealer.hand[i])
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            /*
                Checks which button is being touched based on location and runs code based on which button is pressed
            */
            let location = touch.locationInNode(self)
            let node =  self.nodeAtPoint(location)
            
            /*
                If player presses hit, and the game is going, and it's their turn,
                adds a card to their hand and draws it
                then checks if the player has busted
                or won through having 5 cards
                if so, presents them a message
                and ends the game state
            */
            if (node.name == "hit"){
                if (currentGameState == gameState.Ongoing){
                    if (currentTurn == turn.DealerTurn) {}
                    else{
                        player.hand.append(draw())
                        player.updateInfo()
                        player.hand.last?.xScale = 0.125
                        player.hand.last?.yScale = 0.125
                        player.hand.last?.position = CGPointMake(350 + (75 * CGFloat(player.handSize-1)),200)
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
            
            /*
                If player presses stay,
                The turn changes to the dealer turn
                The dealer will keep hitting until they reach 16 or higher
                and the game ends.
                Win and lose conditions are the checked to determine winner
                and the winner is displayed to the player
            
            */
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
                            dealer.hand.last?.xScale = 0.125
                            dealer.hand.last?.yScale = 0.125
                            dealer.hand.last?.position = CGPointMake(350 + (75 * CGFloat(dealer.handSize-1)),600)
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
            /*
                If reset is pressed the game is restarted
            */
            if (node.name == "reset")
            {
                self.reset()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    /*
        Deallocates resources and loads current scene as new scene
    */
    func reset(){
        self.removeAllChildren()
        self.removeAllActions()
        self.view?.presentScene(self)
    }
    /*
        Iterates through deck starting from the bottom
        Then randomly generates random position between 0
        and the current iterated position
        and swaps the two.
        Obtained from: http://iosdevelopertips.com/swift-code/swift-shuffle-array-type.html
    */
    func shuffle (var array: [Card]) ->  [Card]{
        for var i = array.count-1; i > 0 ; i-- {
            let j = Int(arc4random_uniform(UInt32(i-1)))
            swap(&array[i], &array[j])
        }
        return array
    }
    
    /*
        Emptys current deck
        The creates a new card for each value suit combination
        and adds them to deck,
        then shuffles deck.
    */
    func deckSetUp(){
        deck.removeAll()
        for suit in suits{
            for var i = 1; i < 14; i++ {
                deck.append(Card(suitName: suit, cardValue: i))
            }
        }
        deck = shuffle(deck)
    }
    /*
        Removes card from deck to be added to a new array
    */
    func draw() -> Card {
        return deck.removeLast()
    }
    /*
        Sets the gamestate and turn,
        and re-initializes each players data
    */
    func gameSetUp(){
        currentTurn = turn.PlayerTurn
        currentGameState = gameState.Ongoing
        player.aces = 0
        player.hand.removeAll()
        player.hand.append(draw())
        player.updateInfo()
        dealer.aces = 0
        dealer.hand.removeAll()
        dealer.hand.append(draw())
        dealer.updateInfo()
        
    }
}
