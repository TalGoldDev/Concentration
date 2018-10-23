//
//  ViewController.swift
//  Concentration
//
//  Created by Tal on 22/10/2018.
//  Copyright © 2018 Tal. All rights reserved.
//

import UIKit

let cardPairs = 6

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    var game = Concentration(numberOfSets: cardPairs)


    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "flip count: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBOutlet var cardButtonCollection: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButtonCollection.index(of: sender) {
            game.chooseCard(at: index)
            updateViewFromModel()
        } else {
            print("This card is not part of the cards array")
        }
    }
    
    @IBOutlet weak var labelGameComplete: UILabel!
    @IBOutlet weak var btnStartNewGame: UIButton!
    
    @IBAction func btnStartNewGameClick(_ sender: UIButton) {
        if game.isGameComplete {
            self.game = Concentration(numberOfSets: cardPairs)
            updateViewFromModel()
        }
    }
    func updateViewFromModel(){
        flipCountLabel.text = "Score: \(game.score)"
        
        if game.isGameComplete {
            labelGameComplete.text = "Good Job, Lets Go Again!"
            btnStartNewGame.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            btnStartNewGame.setTitle("New Game", for: UIControl.State.normal)
        } else {
            labelGameComplete.text = ""
            btnStartNewGame.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            btnStartNewGame.setTitle("", for: UIControl.State.normal)
        }
        
        for index in cardButtonCollection.indices {
            let card = game.cards[index]
            let button = cardButtonCollection[index]
            if card.isFacedUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else if card.isMatched {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.setTitle("", for: UIControl.State.normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }

    
    var emojiChoices = ["🦇","😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

